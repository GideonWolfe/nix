{ config, lib, pkgs, ... }:

{
  # Enable docker daemon
  services.snapraid = {

    enable = true;

    dataDisks = { 
        d1 = "/drives/data/data1/"; 
        d2 = "/drives/data/data2/"; 
    };

    parityFiles = [ "/drives/parity/parity1/snapraid.1-parity" ];

    contentFiles = [
      "/drives/data/data1/snapraid/content/snapraid.content"
      "/snapraid/content/snapraid.content"
    ];

    sync = {
      interval = "01:00"; # this is default
    };

  };

}
