# Setup

## Home manager

`nix run #.homeConfigurations.gideon.activationPackage`

## SSH

to switch this repo over to SSH to push any changes and be authed
SSH keys must exist

`git remote set-url origin github:gideonwolfe/nix`


# TODO

## Emoji fonts rendering as colored emoji

I have emoji font specified in `stylix` as `Symbola`, and `fonts.fontconfig.defaultFonts.emoji = ["Symbola"]`

I have `symbola` and `noto-fonts-monochrome-emoji` installed, which both seem to be showing in `gucharmap`

It's just not changing the system emoji font :(


## Mako won't run anymore

Running `mako 'sometext'` gives me

```

Failed to acquire service name: File exists
Is a notification daemon already running?
```

This service used to work fine, not sure what the issue is now.


## Neovim config

What is the best way to declare my complex `lua` based `neovim` config? 


## Build UI Elements

### Fancy logout/shortcut/power menu

on old system it was build with rofi, but this will change

### Set up Hyprland

hard to do in a VM since it runs like shite

## Further modularize config

Some of the config and package files can be further broken up, ie. turning science.nix into a directory with .nix files for each discipline.


