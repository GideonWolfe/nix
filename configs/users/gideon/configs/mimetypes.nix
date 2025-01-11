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

      # Directories
      "inode/directory" = lib.mkForce [ "thunar.desktop" ];

      # Audio
      "audio/aac" = [ "vlc.desktop" ];
      "audio/mp3" = [ "vlc.desktop" ];
      "audio/ogg" = [ "vlc.desktop" ];
      "audio/wav" = [ "vlc.desktop" ];
      "audio/webm" = [ "vlc.desktop" ];
      "audio/webp" = [ "vlc.desktop" ];
      "application/x-cdf" = [ "vlc.desktop" ];
      "audio/midi" = [ "reaper.desktop" ];

      # Video
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/ogg" = [ "vlc.desktop" ];

      # Images
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/svg+xml" = [ "gimp.desktop" ];
      "image/tiff" = [ "gimp.desktop" ];

      # Docs
      "application/pdf" = [ "zathura.desktop" "ark.desktop" ];
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
