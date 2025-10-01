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
- **secrets** - SOPS infrastructure with AGE key management
- **gaming** - Steam and gaming peripherals
- **radio** - Amateur radio tools and hardware support

### SSH Feature

The SSH feature provides secure remote access with automatic user key integration.

#### Basic Configuration

```nix
# Enable SSH server with defaults
custom.features.ssh.enable = true;
```

#### Advanced Configuration

```nix
custom.features.ssh = {
  enable = true;
  ports = [ 2736 22 ];                    # Custom SSH ports
  openFirewall = true;                    # Open firewall automatically
  permitRootLogin = "no";                 # Disable root login
  passwordAuthentication = false;         # Disable password auth (keys only)
  importUserKeys = true;                  # Auto-import user's SSH keys (default)
  extraAuthorizedKeys = [                 # Additional authorized keys
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... admin@server"
  ];
};
```

#### Key Management Integration

The SSH feature automatically imports the system user's SSH public keys as authorized keys:

```nix
# User configuration with SSH keys
custom.user = config.custom.userPresets.gideon // {
  openssh.authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... laptop"
    "ssh-ed25519 BBBB3NzaC1lZDI1NTE5AAAAI... phone"
  ];
};

# SSH feature automatically includes these keys
custom.features.ssh.enable = true;
```

**Security Benefits:**
- Centralized key management through user configuration
- Automatic key deployment to SSH server
- Support for multiple keys per user
- Optional additional keys for admin access

### Secrets Feature

The secrets feature provides SOPS infrastructure with automatic AGE key generation and management.

#### Basic Configuration

```nix
# Enable secrets management
custom.features.secrets.enable = true;
```

#### Advanced Configuration

```nix
custom.features.secrets = {
  enable = true;
  defaultSopsFile = ../../../../secrets/gideon_secrets.yaml;  # Optional default
  ageKeyFile = "/var/lib/sops-nix/key.txt";                  # AGE private key location
  generateKey = true;                                        # Auto-generate AGE key
  hostKeyPath = "/etc/ssh/ssh_host_ed25519_key";            # SSH key for AGE derivation
};
```

#### AGE Key Workflow

**Step 1: Enable Secrets Feature**
```nix
custom.features.secrets.enable = true;
```

**Step 2: Deploy and Generate AGE Key**
```bash
# Deploy the configuration
nixos-rebuild switch

# The system automatically:
# - Generates AGE private key at /var/lib/sops-nix/key.txt
# - Displays the AGE public key for configuration
```

**Step 3: Extract AGE Public Key**
```bash
# View the generated public key
journalctl -u sops-age-key-display

# Output example:
# =============================================
# SOPS AGE Public Key for sisyphus
# =============================================
# Public Key: age1abc123...xyz789
#
# Add this to your .sops.yaml:
# =============================================
# keys:
#   - &hosts:
#       - &sisyphus age1abc123...xyz789
# =============================================
```

**Step 4: Update .sops.yaml**
Add the new host to your `.sops.yaml` creation rules as needed.

#### Using Secrets

Individual features can define their own secrets:

```nix
# In any feature that needs secrets
sops.secrets."some-secret" = {
  sopsFile = ../../../../secrets/gideon_secrets.yaml;
  owner = config.custom.user.name;
};
```

The secrets infrastructure handles the AGE key management automatically.

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
Provides single-user-per-system configuration with the following options:

- `name` - System username
- `home` - Home directory path  
- `shell` - Default shell (defaults to fish)
- `extraGroups` - Additional user groups
- `packages` - User-specific packages
- `openssh.authorizedKeys` - SSH public keys for remote access (automatically imported by SSH feature)
- `initialPassword` - Initial password (testing only)
- `homeManagerConfig` - Home Manager configuration

**SSH Integration:** When the SSH feature is enabled, user SSH keys are automatically imported as authorized keys for the SSH server, providing seamless remote access configuration.

### User Presets (`lib/predefined-users.nix`)
Common user configurations that can be applied to any host:

- `gideon` - Full-featured user with development tools, desktop environment, and admin privileges
- `test` - Minimal user for testing with basic shell and docker access

Each preset includes example SSH public keys that should be replaced with actual keys.

### World Configuration (`lib/world.nix`)
Centralized infrastructure and service endpoint definitions for:

- Monitoring endpoints (Prometheus, Grafana)
- WireGuard VPN server and client configurations
- Network topology and service discovery

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
