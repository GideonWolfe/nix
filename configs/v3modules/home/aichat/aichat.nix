{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.aichat = {
    enable = true;
    target = "aichat/config.yaml";

    # Generates a plain YAML config file for aichat
    text = pkgs.lib.generators.toYAML { } {
      model = "LocalAI:gpt-4o";
      clients = [{
        type = "openai-compatible";
        name = "LocalAI";
        api_base = "http://localhost:6767/v1";
        models = [ { name = "gpt-4"; } { name = "gpt-4o"; } ];
      }];
    };
  };
}
