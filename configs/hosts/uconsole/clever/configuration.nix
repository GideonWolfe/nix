{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    initrd = {
      availableKernelModules = [ "vc4" "v3d" ];
    };
  };
  documentation.enable = false;
  networking.firewall.enable = false;
  services.openssh.enable = true;
  users.users.pi = {
    extraGroups = [ "wheel" ];
    initialPassword = "hunter2";
    isNormalUser = true;
  };
}
