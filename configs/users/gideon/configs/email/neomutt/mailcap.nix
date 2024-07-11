{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile = {
    mailcap = {
      enable = true;
      target = "neomutt/mailcap";
      text = ''

        # HTML
        # Opens HTML in w3m in separate window but unsupported in pager
        # text/html; w3m -I %{charset} -T text/html; 
        # Opens HTML as plaintext 
        text/html; w3m -I %{charset} -T text/html; copiousoutput;
        text/plain; nvim %s

        #PDFs
        application/pdf; ${pkgs.zathura}/bin/zathura %s pdf

        #Images
        image/png; ${pkgs.imv}/bin/imv %s
        image/jpeg; ${pkgs.imv}/bin/imv %s

        			'';
    };
  };
}
