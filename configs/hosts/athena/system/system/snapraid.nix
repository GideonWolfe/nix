{ config, lib, pkgs, ... }:

{
  # Enable docker daemon
  services.snapraid = {

    enable = true;

    # dataDisks = {
    #     d1 = "";
    # };

    sync = {
      interval = "01:00"; # this is default
    };

  };

}
