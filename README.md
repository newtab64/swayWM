# Fern for Fedora Sway Atomic

A minimal, pastel-fern desktop theme for **Fedora Sway Atomic 45**, in the spirit of
[mubin-thinks/minimal-wm-config](https://github.com/mubin-thinks/minimal-wm-config).
Pure dotfiles: **nothing is layered** onto the base image and no package is installed.

- Sway, Waybar (icon-only bar), foot, rofi, swaylock and Thunar share one six-colour palette.
- One font, JetBrainsMono Nerd Font Mono Regular. No bold anywhere.
- One-line prompt: `user@PC:~$`.
- Fedora's stock keybindings and `config.d` files are kept; only the look is changed.
- Wayland only: Xwayland is disabled, with no X11 fallback.

## Install

On a fresh Fedora Sway Atomic session:

```bash
git clone https://github.com/newtab64/swayWM.git && cd swayWM
bash install.sh --dry-run   # list what will be copied
bash install.sh             # copy it into $HOME
```

Then **log out and back in** (the Wayland-only settings need a new session).

`install.sh` copies `home/` over `$HOME`, **overwriting same-named files with no backup**.
Files that are not in this repo are left alone. It also closes Thunar first and sets
`XDG_DESKTOP_DIR="$HOME"` in `~/.config/user-dirs.dirs` (this hides Desktop from Thunar's sidebar).

## What is in `home/`

| Path | Purpose |
|---|---|
| `.config/sway/config` | Fedora's stock sway config with one edit: the rofi theme. |
| `.config/sway/config.d/10-fern.conf` | Font, borders, gaps, GTK icon theme and dark mode, `xwayland disable`. |
| `.config/sway/environment` | Forces Wayland backends (GTK, Qt, SDL, Firefox, Electron). |
| `.config/waybar/` | Bar: workspaces, tray (Fedora's network applet lives here), battery, volume, clock. |
| `.config/foot/foot.ini` | Terminal colours, blinking sand cursor, 80% opaque background, 32px padding. |
| `.config/rofi/fern.rasi` | Launcher theme. |
| `.config/swaylock/config` | Lock screen colours. |
| `.config/gtk-3.0/`, `.config/xfce4/…/thunar.xml` | Thunar theme and a plain list view (Name, Size). |
| `.local/share/icons/Fern/` | Minimal outline icon theme for files and folders. |
| `.local/share/fonts/` | JetBrainsMono Nerd Font Mono Regular. |
| `.bashrc.d/prompt.sh` | `PS1='\u@PC:\w\$ '` (Fedora's `.bashrc` already sources this folder). |

## Palette

| Role | Hex |
|---|---|
| background | `#0d1512` |
| text | `#b5d1b0` |
| dim (inactive, borders) | `#6a8a72` |
| accent (bar, selection) | `#9cc79a` |
| bright (focused border) | `#dff0d6` |
| sand (active workspace, cursor, selected launcher entry) | `#e6d98a` |

## Keybindings

Fedora's defaults: `Super+Enter` terminal, `Super+D` launcher, `Super+Shift+Q` close window,
`Super+Shift+C` reload, `Super+Shift+E` exit, `Super+1…0` workspaces, `Print` screenshot.

## Thunar sidebar

Thunar's Places (Home, Desktop, Trash) cannot be removed or reordered; only shortcuts you add
can. Drag Documents, Music, Pictures, Videos and Downloads onto the side pane, and
right-click an empty spot to untick entries you don't want. Separator lines are not possible.

## Notes

- **X11-only apps will not start.** To allow them, delete `xwayland disable` from
  `10-fern.conf` and remove `.config/sway/environment`.
- Tested on Thunar 4.20 and, with older versions, sway, Waybar and foot in a headless
  Wayland session. See `NOTICE.md` for third-party credits.

## License

MIT, see `LICENSE`. Third-party material is listed in `NOTICE.md`.
