# My Nix Dot files

* Dotfiles managed by [Home Manager](https://nixos.wiki/wiki/Home_Manager)
* Neovim setup with [NixVim](https://github.com/nix-community/nixvim)
* Theming with [Stylix](https://github.com/danth/stylix)


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

## Add secret management

either

https://github.com/ryantm/agenix

or 

https://github.com/Mic92/sops-nix

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

## Neovim config

What is the best way to declare my complex `lua` based `neovim` config? 

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

## Further modularize config

Some of the config and package files can be further broken up, ie. turning science.nix into a directory with .nix files for each discipline.

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
