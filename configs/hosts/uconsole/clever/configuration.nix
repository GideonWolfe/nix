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

  # fix for missing modules in rpi kernel
  # nixpkgs.overlays = [
  #   (self: super: {
  #     makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
  #   })
  # ];

  boot = {
    initrd = {
      availableKernelModules = [ "vc4" "v3d" ];
      # should make above overlay unnecessary
      includeDefaultModules = false;
    };
    kernelPatches = [
      backlightPatch
      panelPatch
      amplifierPatch
      overlayPatch
      powerPatch
      dsiErrorPatch
    ];
    # TODO enable when migrating to new system
    # loader.rpi.config_txt = ''
        # initramfs initrd followkernel
        # gpu_mem=16

        # # CM4 specific settings
        # [cm4]
        # arm_boost=1
        # max_framebuffers=2
        # dtoverlay=vc4-kms-v3d-pi4
        # dtoverlay=uconsole,cm4,hwi2c
        # dtoverlay=dwc2,dr_mode=host
    # '';
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
