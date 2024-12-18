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
          mailboxName = " Gmail";
          extraMailboxes = [ "sent" "spam" "all" "drafts" "starred" "trash" ];
          extraConfig = ''
            #named-mailboxes " Gmail" =gmail
            #named-mailboxes "   Inbox" =inbox
            named-mailboxes "   Sent" =sent
            named-mailboxes "   Drafts" =drafts
            named-mailboxes "   Spam" =spam
            named-mailboxes "   Trash" =trash
            named-mailboxes "   All Mail" =all
            named-mailboxes "   Starred" =starred
          '';
        };

        thunderbird = {
            enable = true;
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

      gideonwolfexyz = {
        address = "gideon@gideonwolfe.xyz";
        flavor = "plain";
        primary = false;
        realName = "Gideon Wolfe";
        userName = "gideon@gideonwolfe.xyz";
        passwordCommand =
          "cat ${config.age.secrets.mbsync_gideonwolfexyz_password.path}";

        smtp = {
          host = "mail.privateemail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };

        imap = {
          host = "mail.privateemail.com";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
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
          mailboxName = " .xyz";
          extraMailboxes = [ "sent" "spam" "drafts" "trash" ];
          extraConfig = ''
            named-mailboxes "   Sent" =sent
            named-mailboxes "   Drafts" =drafts
            named-mailboxes "   Spam" =spam
            named-mailboxes "   Trash" =trash
          '';
        };
        
        thunderbird = {
            enable = true;
        };

        mbsync = {
          enable = true;
          extraConfig = {
            account = {
              Host = "mail.privateemail.com";
              Port = 993;
              PassCmd =
                "cat ${config.age.secrets.mbsync_gideonwolfexyz_password.path}";
            };
            local = {
              Path = "${config.home.homeDirectory}/mail/gideonwolfexyz/";
              Inbox = "${config.home.homeDirectory}/mail/gideonwolfexyz/inbox";
              Subfolders = "Verbatim";
            };
            remote = { Account = "gideonwolfexyz"; };
          };
          groups = {
            gideonwolfexyz = {
              channels = {
                gideonwolfexyz-inbox = {
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
                gideonwolfexyz-sent = {
                  farPattern = "Sent";
                  nearPattern = "/sent";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfexyz-drafts = {
                  farPattern = "Drafts";
                  nearPattern = "/drafts";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfexyz-trash = {
                  farPattern = "Trash";
                  nearPattern = "/trash";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfexyz-spam = {
                  farPattern = "Spam";
                  nearPattern = "/spam";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
              };
            };
          };
        };
      };
      gideonwolfecom = {
        address = "gideon@gideonwolfe.com";
        flavor = "plain";
        primary = false;
        realName = "Gideon Wolfe";
        userName = "gideon@gideonwolfe.com";
        passwordCommand =
          "cat ${config.age.secrets.mbsync_gideonwolfecom_password.path}";

        smtp = {
          host = "mail.privateemail.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };

        imap = {
          host = "mail.privateemail.com";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
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
          mailboxName = " .com";
          mailboxType = "maildir";
          showDefaultMailbox = true;
          extraMailboxes = [ "sent" "spam" "drafts" "trash" ];
          extraConfig = ''
            named-mailboxes "   Sent" =sent
            named-mailboxes "   Drafts" =drafts
            named-mailboxes "   Spam" =spam
            named-mailboxes "   Trash" =trash
          '';
        };

        thunderbird = {
            enable = true;
        };

        mbsync = {
          enable = true;
          extraConfig = {
            account = {
              Host = "mail.privateemail.com";
              Port = 993;
              PassCmd =
                "cat ${config.age.secrets.mbsync_gideonwolfecom_password.path}";
            };
            local = {
              Path = "${config.home.homeDirectory}/mail/gideonwolfecom/";
              Inbox = "${config.home.homeDirectory}/mail/gideonwolfecom/inbox";
              Subfolders = "Verbatim";
            };
            remote = { Account = "gideonwolfecom"; };
          };
          groups = {
            gideonwolfecom = {
              channels = {
                gideonwolfecom-inbox = {
                  patterns = [ "INBOX" ];
                  extraConfig = {
                    MaxMessages = 5000;
                    ExpireUnread = true;
                    Create = "Near";
                    Remove = "Near";
                    Expunge = "Near";
                    #SyncState = "*";
                  };
                };
                gideonwolfecom-sent = {
                  farPattern = "Sent";
                  nearPattern = "/sent";
                  extraConfig = {
                    MaxMessages = 500;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfecom-drafts = {
                  farPattern = "Drafts";
                  nearPattern = "/drafts";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfecom-trash = {
                  farPattern = "Trash";
                  nearPattern = "/trash";
                  extraConfig = {
                    MaxMessages = 1000;
                    ExpireUnread = true;
                    Create = "Near";
                    Expunge = "Both";
                    SyncState = "*";
                  };
                };
                gideonwolfecom-spam = {
                  farPattern = "Spam";
                  nearPattern = "/spam";
                  extraConfig = {
                    MaxMessages = 100;
                    ExpireUnread = true;
                    Create = "Near";
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
