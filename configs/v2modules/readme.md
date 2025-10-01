# V2 Modules System

The v2modules system is a modern, feature-based NixOS configuration architecture that provides clean separation of concerns, type-safe options, and automated deployment workflows.

## Architecture Overview

```
v2modules/
├── features/          # Feature modules (enable/disable functionality)
├── lib/              # Library modules (options definitions, world config)
├── configs/          # Implementation modules (system/user configurations)
└── packages/         # Package collections
```

## Core Concepts

### Single User Per System
Each host declares one primary user using predefined presets:

```nix
custom.user = config.custom.userPresets.gideon;
```

### Feature-Based Configuration
Enable functionality through features rather than direct service configuration:

```nix
custom.features = {
  system.enable = true;
  desktop.enable = true;
  ssh.enable = true;
  wireguard.enable = true;
};
```

### World Configuration
Centralized infrastructure configuration in `lib/world.nix`:

```nix
custom.world.hosts.monitor.prometheus.domain = "prom.example.com";
custom.world.hosts.wireguard.serverIp = "1.2.3.4";
```

## Features

Features provide high-level functionality that can be enabled per-host. All features follow the pattern `custom.features.<name>.enable = true`.

### Available Features

- **system** - Base system configuration with Home Manager
- **desktop** - Desktop environment (Hyprland/Sway) with UI components
- **audio** - PipeWire audio support
- **bluetooth** - Bluetooth hardware and management
- **theming** - Stylix theming with global packages
- **packages** - Application package collections
- **ssh** - SSH server with configurable options
- **wireguard** - WireGuard VPN client (see detailed workflow below)
- **monitoring** - Prometheus + Alloy monitoring stack
- **secrets** - SOPS secrets management
- **gaming** - Steam and gaming peripherals
- **radio** - Amateur radio tools and hardware support

### WireGuard Feature Workflow

The WireGuard feature provides automated VPN client configuration with centralized key management.

#### Configuration Structure

**World Configuration (Single Source of Truth):**
```nix
# lib/world.nix
custom.world.hosts.wireguard = {
  serverIp = "66.108.176.86";           # VPN server public IP
  port = 123;                           # VPN server port
  vpnServerIp = "10.100.0.1";         # Server IP in VPN network
  publicKey = "Rv8R1GmrerXl...";       # Server public key
  network = "10.100.0.0/24";          # VPN network CIDR
  
  # Client definitions
  clients = {
    sisyphus = {
      publicKey = "PENDING_KEY_GENERATION";  # Update after deployment
      vpnIp = "10.100.0.4";                 # Pre-assigned client IP
    };
    hades = {
      publicKey = "PENDING_KEY_GENERATION";
      vpnIp = "10.100.0.5";
    };
  };
};
```

**Host Configuration (Minimal):**
```nix
# hosts/sisyphus/configuration.nix
custom.features.wireguard.enable = true;
# IP automatically derived from world.hosts.wireguard.clients.sisyphus.vpnIp
```

#### Deployment Workflow

**Step 1: Initial Configuration**
```nix
# Enable WireGuard on target host
custom.features.wireguard.enable = true;
```

**Step 2: Deploy and Generate Keys**
```bash
# Deploy the configuration
nixos-rebuild switch

# The system automatically:
# - Generates unique private key at /root/wireguard/${hostname}-wg0-private.key
# - Creates WireGuard interface
# - Starts helper service to display public key
```

**Step 3: Extract Public Key**
```bash
# View the generated public key and configuration
journalctl -u wireguard-pubkey-display

# Output example:
# =============================================
# WireGuard Public Key for sisyphus
# =============================================
# Public Key: ABC123...XYZ789
# VPN IP: 10.100.0.4/24
#
# Add this to your WireGuard server configuration:
# =============================================
# [Peer]
# PublicKey = ABC123...XYZ789
# AllowedIPs = 10.100.0.4/32
#
# Or update world.nix:
# custom.world.hosts.wireguard.clients.sisyphus.publicKey = "ABC123...XYZ789";
# =============================================
```

**Step 4: Update Configurations**
```nix
# Update world.nix with the actual public key
custom.world.hosts.wireguard.clients.sisyphus.publicKey = "ABC123...XYZ789";
```

TODO update the server config section since we are using nix options for this too... Maybe dynamically provide peers from `world.nix` data?

```bash
# Add peer to your WireGuard server
[Peer]
PublicKey = ABC123...XYZ789
AllowedIPs = 10.100.0.4/32
```

#### Key Management Philosophy

**Security-First Approach:**
- Each machine generates unique cryptographic identity
- Private keys never leave the target machine
- No shared keys across deployments
- Automatic key rotation when deploying to new hardware

**Operational Benefits:**
- Clean separation between old and new deployments
- No risk of key compromise during migrations
- Clear audit trail of key changes
- Simplified disaster recovery

**Key Regeneration Scenarios:**
- ✅ **Expected:** Deploying same config to new machine
- ✅ **Expected:** VM recreation or hardware replacement  
- ✅ **Expected:** Fresh OS installation
- ❌ **Won't happen:** Normal system updates or rebuilds

#### Advanced Options

```nix
custom.features.wireguard = {
  enable = true;
  interfaceName = "wg1";                    # Custom interface name
  persistentKeepalive = 30;                 # Custom keepalive interval
  allowedIPs = [ "0.0.0.0/0" ];            # Route all traffic through VPN
  openFirewall = false;                     # Disable automatic firewall rules
};
```

## Library Modules

### User Management (`lib/users.nix`)
Provides single-user-per-system configuration with predefined presets.

### World Configuration (`lib/world.nix`)
Centralized infrastructure and service endpoint definitions.

### User Presets (`lib/predefined-users.nix`)
Common user configurations that can be applied to any host.

## Development Workflow

### Adding New Features
1. Create feature module in `features/`
2. Define options under `custom.features.<name>`
3. Import required system/user configs conditionally
4. Document in this readme

### Testing Configurations
Each host configuration includes testing sections for experimentation:

```nix
# System-level testing
# services.someTestService.enable = true;

# Home Manager testing
home-manager.users.${config.custom.user.name} = {
  # programs.someTestProgram.enable = true;
};
```

### Host-Specific Customization
Use the testing sections in each host configuration to try new configurations before generalizing them into features.
