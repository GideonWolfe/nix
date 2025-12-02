# Home modules (v3)

This directory contains the home-manager layer for the third-generation module stack. It pulls together per-application settings, desktop session orchestration, and external inputs (for example `nixvim` and `spicetify-nix`) so that a single `imports` list in `common.nix` can describe an entire workstation experience.

## Rationale for the layout

- **`apps/` keeps software-specific tweaks together.** Each application, tool, or theme gets its own folder so the module stays focused on that program (e.g. `apps/kitty/kitty.nix`, `apps/nixvim/nixvim.nix`). This keeps updates small and makes it easy to reuse a single app config across machines.
- **`sessions/` owns the desktop environment.** Window-manager helpers, shared Wayland/XDG environment variables, login services, and UI layers that span multiple apps live here. Breaking those pieces out means you can swap Hyprland for Sway (or any future session) without touching the app configs.
- **`common.nix` is the glue.** It wires the two sets together alongside upstream inputs so a host can opt-in to exactly the bits it needs.

## Directory map

```
configs/v3modules/home/
├── README.md              ← This document
├── common.nix             ← Aggregates every module
├── apps/                  ← Program-level modules & themes
│   ├── shell/             ← Fish, Bash, Starship, helpers
│   ├── kitty/             ← Terminal config
│   ├── ...                ← Other applications
│   └── (one folder per app)
└── sessions/              ← Desktop/session building blocks
    ├── global/            ← Env vars, XDG dirs, UI primitives
    │   ├── blueman-applet.nix
    │   ├── session-variables.nix
    │   └── ui/ (cursor, GTK/Qt, waybar, etc.)
    ├── hypr/              ← Hyprland + companion daemons
    └── sway/              ← Sway + related services
```

## Working with apps

1. Create a new folder under `apps/<name>/`.
2. Define the module (usually `<name>.nix`; additional files like themes or data are welcome).
3. Import the module from `common.nix` so every Home Manager profile that uses the bundle picks it up.

Because each module is self-contained, you can remove or override a single app by tweaking just one import line.

## Working with sessions

- Place global, session-agnostic resources in `sessions/global` (environment variables, shared UI defaults, background services such as `blueman-applet`).
- Keep desktop or compositor specific pieces in their own subdirectory (`sessions/hypr`, `sessions/sway`, etc.). Each folder can expose multiple modules (e.g. Hyprland, Hyprpaper, Hyprpanel) so compose only what a host needs.
- Shared UI helpers (Stylix, cursor, GTK/Qt theming) live under `sessions/global/ui` so they can be re-used by every session.

## Adding new structure

If you need a new category:

- Prefer adding folders beneath `apps/` or `sessions/` rather than creating more top-level directories. This keeps the mental model simple: **apps** are program-scoped, **sessions** are desktop-scoped.
- Update `common.nix` once so the change propagates everywhere. Where possible, keep secrets or host-specific overrides out of these modules and in higher-level overlays.

Keeping these boundaries sharp lets you iterate quickly on either half (program configs vs. desktop experience) without surprising regressions elsewhere.
