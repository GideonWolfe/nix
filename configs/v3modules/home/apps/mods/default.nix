{ config, lib, pkgs, osConfig ? {}, ... }:

{
  options.mods = {
    enable = lib.mkEnableOption "Mods AI CLI tool configuration";
  };

  config = lib.mkIf config.mods.enable {
    programs.mods = {
      enable = true;
      #enableFishIntegration = true;
      enableBashIntegration = true;
      #enableZshIntegration = true;

      settings = {
        theme = "charm";
        fanciness = 10;
        default-model = "gpt-4o";
        
        # APIs block always exists, but LocalAI is conditional
        apis = lib.optionalAttrs (osConfig.ai.localai.enable or false) {
          localai = {
            base-url = "http://localhost:${toString (osConfig.ai.localai.port or 6767)}/v1";
            models = {
              "gpt-4o" = {
                max-input-chars = 392000;
                aliases = [ "4o" ];
              };
            };
          };
        };
        
        roles = {
          shell = [
            "you are a shell expert"
            "you do not explain anything"
            "you simply output one liners to solve the problems you're asked"
            "you do not provide any explanation whatsoever, ONLY the command"
          ];
        };
      };
    };
    # fix https://github.com/charmbracelet/mods/issues/316
    home.sessionVariables = { OPENAI_API_KEY = "blah"; };
  };
}
