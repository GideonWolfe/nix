{ pkgs, lib, config, ... }:

let
  inherit (pkgs.lib) toUpper stringToCharacters fromHexString;

  # Function to check if the hex value represents a negative signed 32-bit int
  isNegative = hex:
    let
      prefix = builtins.elemAt (stringToCharacters (toUpper hex)) 0;
      negativePrefix = [ "8" "9" "A" "B" "C" "D" "E" "F" ];
    in builtins.elem prefix negativePrefix;

  u32Max = 4294967295;

  # Ensure it's a 32-bit hex string
  is32Bit = hex: builtins.length (stringToCharacters hex) == 8;

  # The conversion function
  conversionFunc = hex:
    assert is32Bit hex;
    if isNegative hex then
      (fromHexString hex) - (u32Max + 1)
    else
      fromHexString hex;

in {
  # Example usage:
  xdg.configFile."gpredictTest/config".text = ''
    # Example color value
    color = ${toString (conversionFunc "FF336699")}
  '';
}
