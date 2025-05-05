{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
    environment = {
      systemPackages = with pkgs; [
        nautilus-python # enable plugins
        nautilus-open-any-terminal # terminal-context-entry
      ];
      pathsToLink = [ "/share/nautilus-python/extensions" ];
    };
    # extension to open terminals
    #BUG: this doesn't work?
	programs.nautilus-open-any-terminal = {
		enable = true;
		terminal = "kitty";
	};

    #sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";

    # enable previewing service
    services.gnome.sushi.enable = true;
}
