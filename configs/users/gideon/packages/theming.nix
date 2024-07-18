{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.pywal
		pkgs.spicetify-cli
		#pkgs.themix-gui
		# QT utils
		pkgs.qt5ct
		pkgs.qt6ct
		pkgs.qtcurve
		pkgs.libsForQt5.qtstyleplugins
        pkgs.libsForQt5.qtquickcontrols #HACK: could be sorted better, required for flameshot to work
		# GTK utils
		pkgs.wpgtk
		pkgs.lxappearance
		#pkgs.python311Packages.colorthief
		#pkgs.python312Packages.colorthief
		pkgs.colorz

		pkgs.papirus-icon-theme
		pkgs.papirus-folders
		pkgs.material-icons

		#pkgs.pywalfox-native
	];

	

}
