# Advanced Role-Based NixOS Configuration System

This system provides a sophisticated, composable way to define host roles using NixOS module options. Multiple roles can be enabled simultaneously without conflicts, and they augment your existing modular configurations.

## Key Features

✅ **Option-based**: Uses `config.roles.<name> = true` instead of imports  
✅ **Composable**: Multiple roles can be enabled simultaneously without conflicts  
✅ **Augmentative**: Works with your existing dedicated modules  
✅ **Conflict-free**: Uses `lib.mkDefault` to allow per-host overrides  
✅ **Smart dependencies**: Automatically adds users to groups based on enabled roles  

## Available Roles

- **`desktop`**: GUI applications, fonts, desktop services
- **`server`**: Headless server tools, SSH, system utilities  
- **`development`**: Programming languages, IDEs, Docker, build tools
- **`monitoring`**: System monitoring, network analysis, observability
- **`gaming`**: Steam, Discord, gaming platforms
- **`media`**: Video editing, audio production, graphics design
- **`networking`**: Network analysis tools, VPN, testing utilities

## Usage

```nix
# In your host configuration
{
  imports = [
    ../../modules/role-system.nix
    # Your existing dedicated modules
    ../../modules/configs/system/services/audio/pipewire.nix
  ];

  # Enable multiple roles simultaneously
  roles = {
    desktop = true;       # GUI applications
    development = true;   # Programming tools
    monitoring = true;    # Observability tools
    server = true;        # Server tools (works with desktop!)
    networking = true;    # Network analysis
    gaming = false;       # Disabled for this host
    media = false;        # Disabled for this host
  };

  # Smart group assignment based on roles
  users.users.myuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" ] 
      ++ lib.optional config.roles.development "docker"
      ++ lib.optional config.roles.networking "wireshark";
  };
}
```

## Architecture Benefits

### 1. **Non-Destructive Integration**
- Uses `lib.mkDefault` so your existing configurations take precedence
- Augments rather than replaces your existing modules
- Import your dedicated modules alongside the role system

### 2. **Conflict Resolution**
- Multiple roles can define the same packages - they're automatically deduplicated
- Same services can be enabled by different roles - no conflicts
- Host-specific overrides always win over role defaults

### 3. **Composability**
- `desktop + development + monitoring` = A developer workstation with observability
- `server + development + networking` = A development server with network tools
- `gaming + desktop + media` = A multimedia gaming rig

### 4. **Smart Automation**
- Automatically adds users to appropriate groups (`docker`, `wireshark`, etc.)
- Enables supporting services only when needed
- Handles hardware enablement (graphics, bluetooth, etc.)

## Example Configurations

### Developer Workstation
```nix
roles = {
  desktop = true;       # GUI apps, fonts, desktop services
  development = true;   # Docker, IDEs, languages, build tools
  monitoring = true;    # htop, prometheus, profiling tools
  networking = true;    # Wireshark, network analysis
};
```

### Home Server
```nix
roles = {
  server = true;        # SSH, system tools, headless utilities
  monitoring = true;    # System monitoring, observability
  # No desktop role = headless
};
```

### Gaming + Streaming Setup
```nix
roles = {
  desktop = true;       # GUI environment
  gaming = true;        # Steam, Discord, gaming platforms
  media = true;         # OBS, video editing, streaming tools
  networking = true;    # For network optimization
};
```

## Migration from Old System

1. **Replace imports** with the role system:
   ```nix
   # OLD: Individual role file imports
   imports = [ ../../modules/roles/desktop.nix ];
   
   # NEW: Role system + existing modules
   imports = [ 
     ../../modules/role-system.nix 
     ../../modules/configs/system/services/audio/pipewire.nix
   ];
   roles.desktop = true;
   ```

2. **Keep your existing modules**: The role system works alongside them
3. **Use roles for packages**: Let roles handle bulk package installation
4. **Use dedicated modules for services**: Keep complex service configs separate

## Testing

```bash
# Build and test the role-based configuration
nix build .#sisyphus-roles-vm
nix run .#sisyphus-roles-vm

# Inside the VM, verify role packages are installed
which docker       # From development role
which prometheus   # From monitoring role  
which firefox      # From desktop role
which wireshark    # From networking role
```

This system scales beautifully - you can easily add new roles or extend existing ones without breaking existing configurations!
