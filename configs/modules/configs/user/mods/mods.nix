{ pkgs, lib, ... }:

{
  programs.mods = {
    enable = true;
    #enableFishIntegration = true;
    enableBashIntegration = true;
    #enableZshIntegration = true;

    #TODO : parameterize the LocalAI settings (ports, etc) so they can be referenced directly here
    # and only enable that API if LocalAI is enabled
    settings = {
      theme = "charm";
      fanciness = 10;
      default-model = "gpt-4o";
      apis = {
        localai = {
          base-url = "http://localhost:6767/v1";
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
}
