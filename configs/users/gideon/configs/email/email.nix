{ pkgs, lib, config, ... }: {
  accounts.email = {
    accounts = {
      # Definition for my gmail account
      gmail = {
        address = "SECRET@SECRET.com";
        name = "gmail";
        flavor = "gmail.com"; # may set some settings automatically
        primary = true; # set as primary account
        realName = "Gideon Wolfe";
        userName = "SECRET";
        passwordCommand = "agenix -d /path/to/secret/google/app/pswd";
        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        folders = {
          drafts = "${config.home.homeDirectory}/mail/gmail/drafts/";
          inbox = "${config.home.homeDirectory}/mail/gmail/inbox/";
          sent = "${config.home.homeDirectory}/mail/gmail/sent/";
          trash = "${config.home.homeDirectory}/mail/gmail/trash/";
        };
        # Account settings for neomutt
        neomutt = {
          # TODO: change to true
          enable = false;
          mailboxType = "imap";

        };
      };
    };
  };
}
