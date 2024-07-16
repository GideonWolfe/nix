# My Nix Dot files

* Dotfiles managed by [Home Manager](https://nixos.wiki/wiki/Home_Manager)
* Neovim setup with [NixVim](https://github.com/nix-community/nixvim)
* Theming with [Stylix](https://github.com/danth/stylix)
* Secret management with [Agenix](https://github.com/ryantm/agenix)

## Repo Structure

* `flake.nix` the sources for all software, eg. `nixpkgs`, `home-manager`, and `stylix`.
* `wallpapers` my collection of wallpapers. I haven't found a cleaner solution than including them in the repo 🤷
* `configs` all the possible configurations
    * `hosts` the configs for individual systems such as laptops, desktops, servers
        * `hostname`
            * `configuration.nix` some basic configs option for the system (bootloader, timezone, etc) TODO move configs out of here
            * `hardware-configuration.nix` config for the system's hardware
            * `system` contains all system configurations
                * `graphics` configs for wayland, stylix
                * `packages` system level packages that should be installed
                * `services` configs for services that run on the system (greeter, CUPS, etc)
                * `system` system level configs (timezone, hostname, bootloader, etc)
    * `uses` configs for individual users on these system and their dotfiles
        * `username`
            * `home.nix` the basic setup for the user, and where all other HM configs are imported
            * `configs` config files for various programs
            * `packages` the packages to be installed for that user
            * `scripts` helper scripts with various functionality
            * `secrets` encrypted secrets and their configuration


<details>

<summary style="display:inline;"><h3>Setup Instructions</h3></summary>

## Home manager

`nix run #.homeConfigurations.gideon.activationPackage`

## SSH

to switch this repo over to SSH to push any changes and be authed
SSH keys must exist

`git remote set-url origin github:gideonwolfe/nix`

</details>

<details>

<summary style="display:inline;"><h3>TODO</h3></summary>

## Initial steps required for setup
    * Calendars and Contacts
        * `vdirsyncer discover calendar_gmail` to initialize auth to vdirsyncer
        * `vdirsyncer discover contacts_gmail` to initialize auth to vdirsyncer
        * there's a couple things you have to agree too, like creating the local calendar files, how to automate this?

    * Set up browser plugins
        * ~/.config/darkreader.darkreader.json needs to be manually imported via darkreader settings (FF and Chromium)
        * New Tab Override (FF) and New Tab URL (Chromium) needs to be set to point at http://localhost:9876



## Real Time Audio (for music production)

https://github.com/musnix/musnix

## Refactoring

* move the git commit script thats floating around
* move the service definition for the startpage into the user dir, its ugly defined in system and reaching into hardcoded user dir for config files

## Add theme to cli-visualizer

command is `vis`, takes a config file with a theme 

https://github.com/dpayne/cli-visualizer?tab=readme-ov-file#configuration

## Add custom icons of some sort

## Change workspace icon when new window opened

like if I click a link and it opens a tab in FF in another workspace, that workspace icon should get a highlight.
I think its called urgent or something


## Add theme to audacity
seems to have a "Custom" option for theme

## Configure spicetify

https://github.com/the-argus/spicetify-nix lets you specify custom colors in nix

Already installed this, works well with preset themes. Now need to make a stylix theme


## Hardware only stuff (can't really config in VM)

* Multi monitor outputs
* Bluetooth (should be configured already)
* Virtual machines (should be configured already)
* Backlight control (already have module but need to test)
* Hibernation/sleep

## Seahorse won't import SSH key

```
Could not display “<key_name>”
Reason:	Unrecognized or unsupported data.
```

is it because the keys aren't in `.ssh`? I don't think that's been an issue before

## Emoji fonts rendering as colored emoji

I have emoji font specified in `stylix` as `Symbola`, and `fonts.fontconfig.defaultFonts.emoji = ["Symbola"]`

I have `symbola` and `noto-fonts-monochrome-emoji` installed, which both seem to be showing in `gucharmap`

It's just not changing the system emoji font :(

## Qt Theming

Ongoing discussion on Stylix github, how to access these new features?

https://github.com/danth/stylix/pull/367

## Build UI Elements

### Window switcher

to switch between windows on all workspaces

### Fancy logout/shortcut/power menu

on old system it was build with rofi, but this will change

### Set up Hyprland

hard to do in a VM since it runs like shite

### Improve waybar media playing module

maybe this third party one https://github.com/raffaem/waybar-mediaplayer
or just hack on it

### Add waybar desktop notification toggle 

maybe adapt https://github.com/vkraven/swankybar to toggle notifications instead of adaptive sync

## Misc

* `cava` continues to hear audio even when system vol is muted

</details>


<details>

<summary style="display:inline;"><h3>Wanted Packages</h3></summary>

* https://github.com/joouha/euporie - TUI Jupyter notebooks
* https://github.com/Julien-cpsn/ATAC - TUI API Client (like postman)
* https://github.com/cyring/CoreFreq - CPU monitoring module
* https://github.com/tconbeer/harlequin - TUI Database IDE
* https://github.com/dewberryants/asciiMol - TUI molecular viewer
* https://github.com/darrenburns/elia - TUI for LLMs
* https://github.com/nadrad/h-m-m - TUI for making mind maps
* https://github.com/Chleba/netscanner - TUI for scanning networks


</details>
