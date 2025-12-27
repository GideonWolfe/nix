{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;
{
	programs.khal = {
		enable = true;
        settings = {
            default = {
                highlight_event_days = true;
                show_all_days = true;
            };
            view = {
                frame = "color";
                theme = "dark";
            };
        };
	};
}
