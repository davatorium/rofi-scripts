# Rofi based scripts

## i3_switch_workspace.sh

### Usage

```bash
./i3_switch_workspace.sh
```

### Screenshot

![I3 Workspace Switcher](i3_switch_workspace.png)

## monitor_layout.sh

### Usage

```bash
./monitor_layout.sh
```

### Screenshot

![Monitor Layout](monitor_layout.png)

## rofi_gtk_colors.py

Tries to generate colors from current Gtk+-3.0 theme.
Based on code in Mate-HUD.

### Screenshot

![Monitor Layout](monitor_layout.png)

## zathist.sh

A shell script to fuzzy find (and open) from `rofi` (or `dmenu`) a PDF file in the history of the zathura viewer.

### Installation

To use this script most conveniently:

1. Save this script, say to `~/bin/zathist.sh` by

    ```sh
    mkdir --parents ~/bin &&
    curl -fLo https://raw.githubusercontent.com/Konfekt/zathist.sh/master/zathist.sh ~/bin/zathist.sh
    ```
  
1. mark it executable by `chmod a+x ~/bin/zathist.sh`,

To launch `zathist.sh` by a global keyboard shortcut, say pressing at the same time the `Microsoft Windows` key and `Z`:

1. install, say, `Xbindkeys` (or `Sxhkd`), (for example, on `openSUSE` by `sudo zypper install xbindkeys` respectively `sudo zypper install sxhkd`)
1. add to `~/.xbindkeysrc` a shortcut that launches `zathist.sh`, say

    ```sh
    "$HOME/bin/zathist.sh"
    Mod4 + z
    ```

1. start `xbindkeys`.

To start `xbindkeys` automatically at login, say on a `KDE` desktop environment, put a file `xbindkeys.sh` reading

```sh
#! /bin/sh
xbindkeys
```

into `~/.config/autostart-scripts/`.

### Configuration

PDFs whose path matches the pattern given by the variable

```sh
    IGNORE_REGEX="^${TMPDIR:-/tmp}/\|_cropped\.pdf$"
```

will not be listed.

`zathist.sh` uses rofi in dmenu mode.
Replace at will by dmenu itself and change its command line arguments by the variables

```sh
MENU_ENGINE=-rofi
MENU_ARGS="-dmenu -i -keep-right"
```

To customize the prompt and theme, adapt the variables

```
THEME='
element{ horizontal-align: 0; }
listview {
    dynamic: true;
    padding: 0px 0px 0px ;
}'
PROMPT='❯ '
```

### Credits

This shell script refines shell code posted on [stackexchange](https://unix.stackexchange.com/questions/467524/open-file-from-history-in-zathura).
