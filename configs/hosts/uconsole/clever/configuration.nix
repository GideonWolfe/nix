{ ... }:

let
  backlightPatch = {
    name = "0001-video-backlight-Add-OCP8178-backlight-driver.patch";
    patch = ./patches/0001-video-backlight-Add-OCP8178-backlight-driver.patch;
  };
  panelPatch = {
    name = "0002-drm-panel-add-clockwork-cwu50.patch";
    patch = ./patches/0002-drm-panel-add-clockwork-cwu50.patch;
  };
  amplifierPatch = {
    name = "0003-driver-staging-add-uconsole-simple-amplifier-switch.patch";
    patch = ./patches/0003-driver-staging-add-uconsole-simple-amplifier-switch.patch;
  };
  overlayPatch = {
    name = "0004-arm-dts-overlays-add-uconsole.patch";
    patch = ./patches/0004-arm-dts-overlays-add-uconsole.patch;
  };
  powerPatch = {
    name = "0005-drivers-power-axp20x-customize-PMU.patch";
    patch = ./patches/0005-drivers-power-axp20x-customize-PMU.patch;
  };
  dsiErrorPatch = {
    name = "0006-drm-panel-cwu50-expose-dsi-error-status-to-userspace.patch";
    patch = ./patches/0006-drm-panel-cwu50-expose-dsi-error-status-to-userspace.patch;
  };
in {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    initrd = {
      availableKernelModules = [ "vc4" "v3d" ];
    };
    kernelPatches = [
      backlightPatch
      panelPatch
      amplifierPatch
      overlayPatch
      powerPatch
      dsiErrorPatch
    ];
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
