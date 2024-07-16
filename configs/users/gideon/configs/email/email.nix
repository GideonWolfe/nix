{ pkgs, lib, config, ... }: {
  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/mail";
    accounts = {
      # Definition for my gmail account
      gmail = {
        address = "wolfegideon@gmail.com";
        flavor = "gmail.com"; # may set some settings automatically
        primary = true; # set as primary account
        realName = "Gideon Wolfe";
        userName = "wolfegideon";
        passwordCommand =
          "cat ${config.age.secrets.mbsync_google_wolfegideon_app_password.path}";

        #TODO: delete? the imap settings are covered by "flavor" so these probably are too
        smtp = {
          host = "smtp.gmail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };

        folders = {
          # Prepended by the configured maildirBasePath
          drafts = "drafts/";
          inbox = "inbox/";
          sent = "sent/";
          trash = "trash/";
        };
        # Account settings for neomutt
        neomutt = {
          enable = true;
          extraMailboxes = [ "sent" "spam" "all" "drafts" "starred" "trash" ];
        };

        mbsync = {
          enable = true;
          extraConfig = {
            account = {
              Host = "imap.gmail.com";
              Port = 993;
              SSLType = "IMAPS";
              AuthMechs = "LOGIN";
              Pipelinedepth = 1;
              PassCmd =
                "cat ${config.age.secrets.mbsync_google_wolfegideon_app_password.path}";
            };
            local = {
              Path = "${config.home.homeDirectory}/mail/gmail/";
              Inbox = "${config.home.homeDirectory}/mail/gmail/inbox";
              Subfolders = "Verbatim";
            };
            remote = { Account = "gmail"; };
          };
          groups = {
            gmail = {
              channels = {
                gmail-inbox = {
                  patterns = [ "INBOX" ];
                  extraConfig = {
                    MaxMessages = 1000;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Near";
                    #SyncState = "*";
                  };
                };
                gmail-sent = {
                  farPattern = "[Gmail]/Sent Mail";
                  nearPattern = "/sent";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gmail-all = {
                  farPattern = "[Gmail]/All Mail";
                  nearPattern = "/all";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gmail-starred = {
                  farPattern = "[Gmail]/Starred";
                  nearPattern = "/starred";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gmail-trash = {
                  farPattern = "[Gmail]/Trash";
                  nearPattern = "/trash";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gmail-spam = {
                  farPattern = ''"[Gmail]/Spam"'';
                  nearPattern = "/spam";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gmail-drafts = {
                  farPattern = ''"[Gmail]/Drafts"'';
                  nearPattern = "/drafts";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
