{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.chromium = {
		enable = true;
        extensions = [
            # Ublock Origin
            {
                id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
            }
            # DarkReader
            {
                id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
            }
            # Vimium
            {
                id = "dbepggeogbaibhgnhhndojpepiihcmeb";
            }
            # New Tab Redirect
            {
                id = "fjmejipbaegkajpfkghaapfhdempldpd";
            }
        ];
	};
}
