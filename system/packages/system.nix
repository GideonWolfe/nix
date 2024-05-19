{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# Greeter daemon for login sessions
		greetd.greetd
		# actual greeter
		greetd.tuigreet
		# Lockscreen
		swaylock

		# Terminals
		alacritty
		foot # default wayland/sway term
		kitty

		# Navigation
		tree
		eza # better ls (formerly exa)
		zoxide # better cd
		tmux
		screen

		# File Operations
		#unrar
		unzip
		zip
		czkawka # duplicate file finding GUI
		file

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
		cpupower-gui # GUI for tweaking CPU
		hardinfo # GUI for devices/hardware
		psensor # hardware monitoring GUI


		# Utilities
		bc # calculator
		bat # better cat
		imv # like mpv for images
		fd # better find
		lnav # logfile viewer
		moreutils # additional unix tools
		s-tui # TUI stress tester
		#rofi
		wofi
		bemenu # like dmenu, required by sth
		scrot # screenshot
		flameshot #screenshot GUI
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

		# Collection of colorschemes
		base16-schemes

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
		openrgb-with-all-plugins # OpenRGB
		ckb-next # Corsair keyboards

		# File managers
		ranger
		xfce.thunar

		# Replacements for various X utils
		wev # wayland xev
		ydotool # (wayland xdotool)
		wl-clipboard # wayland xclip

		# Icon set
		#papirus-icon-theme
		#papirus-folders
		
	];

	fonts.packages = with pkgs; [
		# collection of patched fonts
		nerdfonts
		noto-fonts
		# symbols and emoji (outlined)
		symbola
		noto-fonts-monochrome-emoji
		# chinese, japanese, korean
		noto-fonts-cjk 
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		# Font Awesome
		font-awesome
		font-awesome_5
	];
}
