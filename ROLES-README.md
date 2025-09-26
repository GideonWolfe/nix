# Role-Based NixOS Configuration System

This system provides a simple way to define host "roles" that automatically enable the appropriate packages and configurations.

## How it Works

Instead of manually importing dozens of individual module files and managing dependencies, you can now simply enable roles with boolean flags:

```nix
# In your host configuration
{
  imports = [
    ../../modules/roles.nix
    # other imports...
  ];

  # Define this host's roles with simple boolean flags
  roles = {
    server = true;        # Basic server tools (htop, tmux, vim, git, etc.)
    development = true;   # Programming languages and tools
    monitoring = true;    # Prometheus, Grafana, monitoring tools
    desktop = false;      # GUI applications (Firefox, LibreOffice, etc.)
    gaming = false;       # Steam, Discord, gaming tools
  };

  # Rest of your host configuration...
}
```

## Available Roles

- **server**: Headless server configuration with essential CLI tools
- **development**: Programming environment with languages and dev tools  
- **monitoring**: Observability tools like Prometheus and Grafana
- **desktop**: GUI applications for desktop environments
- **gaming**: Gaming applications and related tools

## Benefits

1. **Declarative**: Just set `roles.desktop = true` instead of importing 10+ modules
2. **DRY**: Role definitions are centralized and reusable
3. **Consistent**: Every "desktop" host gets the same core applications
4. **Discoverable**: Easy to see what roles are available
5. **Extensible**: Easy to add new roles or modify existing ones

## Example: Sisyphus Test Configuration

The `sisyphus-roles` configuration demonstrates this system:

```nix
roles = {
  server = true;        # Gets: htop, tmux, vim, curl, wget, git, tree, neofetch
  development = true;   # Gets: neovim, git, gh, nodejs, python3, rustc, cargo, gcc
  monitoring = true;    # Gets: htop, iotop, nethogs, prometheus, grafana
  desktop = false;      # Skipped
  gaming = false;       # Skipped
};
```

## Building and Testing

```bash
# Build the role-based VM
nix build .#sisyphus-roles-vm

# Run the VM to test
nix run .#sisyphus-roles-vm
```

## Future Enhancements

This is a proof of concept that currently only manages packages. Future versions could:

1. **Module Imports**: Automatically import related configuration modules
2. **Service Configuration**: Enable/configure services based on roles
3. **User Groups**: Add users to appropriate groups (docker, audio, etc.)
4. **Role Dependencies**: Define role dependencies (desktop requires server, etc.)
5. **Per-Host Overrides**: Allow hosts to customize role packages
6. **Role Composition**: Combine multiple roles into higher-level roles

## Migration Strategy

To migrate existing hosts:

1. Create a new `<hostname>-roles.nix` configuration file
2. Add it to `flake.nix` alongside the existing config
3. Test the role-based version 
4. Once verified, replace the old configuration
5. Gradually enhance roles with module imports and services
