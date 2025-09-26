{ config, lib, pkgs, inputs, ... }:

{
  # Import the role orchestration system
  imports = [
    ../../modules/roles.nix
    ../../modules/world.nix
  ];

  # Define this host's roles
  roles = {
    # Enable server role for basic functionality
    server = true;
    # Enable development role for testing development tools
    development = true;
    # Enable monitoring role to test the monitoring stack
    monitoring = true;
    # Disable desktop role for this test (it's a VM)
    desktop = false;
    # Disable gaming role
    gaming = false;
  };

  # Basic system settings
  networking.hostName = "sisyphus";
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # VM-specific settings
  virtualisation = {
    # Allocate reasonable resources for testing
    memorySize = 4096; # 4GB RAM for monitoring stack
    cores = 2;
    # Enable graphics for GUI testing if needed
    graphics = true;
    # Disk size for the VM
    diskSize = 12288; # 12GB for monitoring data
    # Store VM disk in a specific location instead of current directory
    writableStore = false; # Makes /nix/store read-only
  };

  # Create a test user and add to necessary groups
  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" "docker" ];
  };

  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # Set console keymap
  console.keyMap = "us";

  # Configure monitoring services using world data
  services.grafana.settings.server = {
    domain = config.local.world.hosts.monitor.grafana.domain;
    http_port = config.local.world.hosts.monitor.grafana.port;
  };

  services.prometheus.listenAddress = "0.0.0.0:${toString config.local.world.hosts.monitor.prometheus.port}";

  # Configure Loki
  services.loki.configuration.server.http_listen_port = config.local.world.hosts.monitor.loki.port;

  # System state version
  system.stateVersion = "25.05";
}
