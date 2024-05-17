{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# Greeter daemon for login sessions
		greetd.greetd
		# actual greeter
		greetd.tuigreet

		# Terminals
		alacritty
		foot # default wayland/sway term
		kitty

		# Navigation
		tree
		eza # better ls (formerly exa)
		zoxide # better cd
		tmux

		# File Operations
		#unrar
		unzip
		zip
		czkawka # duplicate file finding GUI

		# Monitors
		atop # system/process monitor
		htop # system/process monitor
		iotop # IO monitor
		dnstop # DNS traffic monitor
		bandwhich # bandwidth monitor
		ktop # kernel monitor
		glances # system/process monitor
		bmon # bandwidth monitor
		nload # network load monitor
		nmon # system monitor
		powertop # power analyzer (intel laptops)
		lm_sensors # hardware sensors
		pkgtop # TUI package monitor


		# Utilities
		bc # calculator
		bat # better cat
		fd # better find
		lnav # logfile viewer
		moreutils # additional unix tools
		s-tui # TUI stress tester
		#rofi
		wofi
		bemenu # like dmenu, required by sth
		scrot # screenshot
		speedtest-cli
		xdg-user-dirs # change default user directoryies
		xdg-utils
		fzf
		gnome.gucharmap # Unicode character viewer
		gnome.gnome-font-viewer
		tldr # better man pages with examples
		espeak


		# Notification daemon
		libnotify
		#dunst
		mako

		# Disk Automount daemon
		udiskie

		# Print daemon
		cups

		# Alternate shells
		fish
		fishPlugins.done

		# Filesystem Utilities
		ntfs3g # NTFS driver
		gparted
		gnome.gnome-disk-utility
		diskonaut # disk usage analyzer TUI
		baobab # disk usage analyzer GUI
		ventoy # create bootable USBs
		simple-mtpfs # mount cell phone filesystems
		dosfstools # drivers for DOS filesystems

		# Hardware 
		piper # GTK frontend to configure mice
		antimicrox # GUI for mapping buttons on input devices

		# File managers
		ranger

		# Replacements for various X utils
		wev # wayland xev
		ydotool # (wayland xdotool)
		wl-clipboard # wayland xclip
		
	];

	fonts.packages = with pkgs; [
		# collection of patched fonts
		nerdfonts
		# symbols and emoji (outlined)
		symbola
		noto-fonts
		# chinese, japanese, korean
		noto-fonts-cjk 
	];
}
