{ pkgs, inputs ? null, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "portapack-prep";
      runtimeInputs = [ pkgs.curl pkgs.jq pkgs.unzip ];
      text = ''
        set -e

        echo "Preparing Portapack SD card contents..."

        # Create a folder in the current working directory called "portapack"
        mkdir -p portapack

        # Go into the portapack folder
        cd portapack

        # Discover what the most recent release of the Portapack firmware is
        echo "Fetching latest release information..."
        LATEST_RELEASE=$(${pkgs.curl}/bin/curl -s https://api.github.com/repos/portapack-mayhem/mayhem-firmware/releases/latest | ${pkgs.jq}/bin/jq -r '.tag_name')

        if [ -z "$LATEST_RELEASE" ] || [ "$LATEST_RELEASE" = "null" ]; then
          echo "Error: Could not fetch latest release information"
          exit 1
        fi

        echo "Latest firmware version: $LATEST_RELEASE"

        # Remove 'v' prefix if present
        VERSION_NUMBER=''${LATEST_RELEASE#v}

        # Using that firmware number, grab the latest release files
        # The URL format is https://github.com/portapack-mayhem/mayhem-firmware/releases/download/v<firmware-version>/mayhem_v<firmware-version>_COPY_TO_SDCARD.zip
        DOWNLOAD_URL="https://github.com/portapack-mayhem/mayhem-firmware/releases/download/$LATEST_RELEASE/mayhem_v''${VERSION_NUMBER}_COPY_TO_SDCARD.zip"
        ZIP_FILE="mayhem_v''${VERSION_NUMBER}_COPY_TO_SDCARD.zip"

        echo "Downloading $ZIP_FILE..."
        ${pkgs.curl}/bin/curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"

        if [ ! -f "$ZIP_FILE" ]; then
          echo "Error: Failed to download $ZIP_FILE"
          exit 1
        fi

        # Extract the contents of the ZIP file into the portapack folder
        echo "Extracting contents..."
        ${pkgs.unzip}/bin/unzip -o "$ZIP_FILE"

        # Clean up the zip file
        rm "$ZIP_FILE"

        # Download the FlipperZero-Subghz-DB repository for additional subghz files
        echo "Downloading FlipperZero-Subghz-DB repository..."
        SUBGHZ_REPO_URL="https://github.com/Zero-Sploit/FlipperZero-Subghz-DB/archive/refs/heads/main.zip"
        SUBGHZ_ZIP="FlipperZero-Subghz-DB-main.zip"

        ${pkgs.curl}/bin/curl -L -o "$SUBGHZ_ZIP" "$SUBGHZ_REPO_URL"

        if [ ! -f "$SUBGHZ_ZIP" ]; then
          echo "Warning: Failed to download FlipperZero-Subghz-DB repository"
        else
          echo "Extracting FlipperZero-Subghz-DB..."
          ${pkgs.unzip}/bin/unzip -o "$SUBGHZ_ZIP"

          # Copy subghz directory contents to SUBGHZ directory in firmware
          if [ -d "FlipperZero-Subghz-DB-main/subghz" ] && [ -d "SUBGHZ" ]; then
            echo "Copying subghz files to SUBGHZ directory..."
            cp -r FlipperZero-Subghz-DB-main/subghz/* SUBGHZ/
            echo "Successfully copied subghz files"
          else
            echo "Warning: Could not find source subghz directory or target SUBGHZ directory"
          fi

          # Clean up the subghz repo files
          rm -rf FlipperZero-Subghz-DB-main
          rm "$SUBGHZ_ZIP"
        fi

        echo "Portapack SD card contents ready in ./portapack/"
        echo "Copy the contents of this folder to your SD card root directory."
      '';
    })
  ];
}
