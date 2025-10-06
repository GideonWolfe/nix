{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.mimeApps = {

    enable = true;

    defaultApplications = {

      # Web
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];

      # Archives
      "application/gzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zip-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-freearc" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip2" = [ "org.gnome.FileRoller.desktop" ];

      "x-scheme-handler/magnet" = [ "transmission-gtk.desktop" ];
      "application/x-bittorent" = [ "transmission-gtk.desktop" ];

      # Directories
      "inode/directory" = lib.mkForce [ "org.gnome.Nautilus.desktop" ];

      # Audio
      "audio/aac" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/mp3" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/mpeg" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/ogg" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/wav" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/webm" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/webp" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "application/x-cdf" = ["org.gnome.Decibels.desktop" "vlc.desktop" ];
      "audio/midi" = [ "reaper.desktop" ];

      # Video 
      "video/mp4" = [ "mpv.desktop" "vlc.desktop" ];
      "video/mpeg" = [ "mpv.desktop" "vlc.desktop" ];
      "video/ogg" = [ "mpv.desktop" "vlc.desktop" ];

      # Images
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/svg+xml" = [ "gimp.desktop" ];
      "image/tiff" = [ "gimp.desktop" ];

      # Docs
      "application/pdf" = [ "org.pwmt.zathura.desktop" "org.gnome.Evince-previewer.desktop" ];
      "application/msword" = [ "writer.desktop" ]; # TODO setup libre office
      "application/vnd.ms-excel" = [ "calc.desktop" ]; # .xls
      "application/vnd.ms-powerpoint" = [ "impress.desktop" ]; # .xls
      #"application/vnd.openxmlformats-officedocument.wordprocessingml.document" = []; # docx
      #"application/vnd.openxmlformats-officedocument.presentationml.presentation" = []; # pptx
      #"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = []; # .xlsx
      #"application/vnd.oasis.opendocument.presentation" = []; # openoffice presentation
      #"application/vnd.oasis.opendocument.spreadsheet" = []; # openoffice spreadsheet
      #"application/vnd.oasis.opendocument.text" = []; # openoffice text doc

      # All libreoffice file formats
      "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
      "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
      "application/vnd.oasis.opendocument.presentation" = [ "impress.desktop" ];
      "application/vnd.oasis.opendocument.graphics" = [ "draw.desktop" ];
      "application/vnd.oasis.opendocument.formula" = [ "math.desktop" ];

      # Ebooks
      "application/vnd.amazon.ebook" = [ "foliate.desktop" ];
      "application/epub+zip" = [ "foliate.desktop" ];

      #Fonts
      "font/otf" = [ "org.gnome.font-viewer.desktop" ];
      "font/ttf" = [ "org.gnome.font-viewer.desktop" ];
      "font/woff" = [ "org.gnome.font-viewer.desktop" ];
      "font/woff2" = [ "org.gnome.font-viewer.desktop" ];

      # TODO: "unable to find terminal required for this application"
      # Text
      #"text/css" = ["nvim.desktop"];
      #"text/javascript" = ["nvim.desktop"];
      #"text/json" = ["nvim.desktop"];
      #"text/csv" = ["nvim.desktop"];
      "text/plain" = [ "nvim.desktop" ];
    };

  };
}
