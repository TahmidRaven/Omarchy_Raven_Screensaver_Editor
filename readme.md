
# Omarchy Raven Screensaver Editor

Omarchy Raven Screensaver Editor is a customizable text editor for the Omarchy Linux screensaver. It allows you to modify the default screensaver text and display your own custom messages, enhancing the default Omarchy screensaver experience.
---

## Features

- Generates ASCII art screensavers using `figlet`
- Dark theme Zenity GUI dialogs
- Multi-line and single-line text input
- Font patching for extended character support
- Preview before saving
- Automatic backup of previous screensaver
- Restore backups
- Uninstall option preserving fonts and screensaver files

---

## Installation

Run the self-installing script:

```bash
chmod +x omarchy-raven-screensaver-install.sh
./omarchy-raven-screensaver-install.sh
```

The script will:

1. Create necessary directories:
   - `~/.local/bin`
   - `~/.local/share/figlet`
   - `~/.config/screensaver-maker`
2. Check and install dependencies (`figlet`, `zenity`, `python3`, `curl`) automatically if missing
3. Download and patch the `Delta-Corps-Priest-1` font
4. Create the main launcher script
5. Create a desktop entry for application menus
6. Create an uninstaller

---

## Usage

Launch via terminal:

```bash
omarchy-raven-screensaver
```

Or via desktop menu: **Omarchy Raven Screensaver**

### Options

- **🆕 Create New Text** – Enter single-line text for the screensaver
- **📝 Multi-Line Text** – Enter multiple lines of text
- **👁️ View Current** – Preview the current screensaver
- **♻️ Restore Backup** – Restore previous screensaver backups
- **🗑️ Uninstall App** – Remove the application while preserving screensaver and font files

---

## Configuration Files

- Screensaver text: `~/.config/omarchy/branding/screensaver.txt`
- App config & history: `~/.config/omarchy-raven-screensaver/history.txt`
- Fonts: `~/.local/share/figlet/Delta-Corps-Priest-1.flf`

---

## Dependencies

- `figlet` – ASCII art generation
- `zenity` – GUI dialogs
- `python3` – Font patching script
- `curl` – Download font if missing

Dependencies will be auto-installed by the script if available package manager is detected (`pacman`, `apt`, `dnf`, `zypper`).

---

## Uninstallation

Run:

```bash
~/.local/bin/omarchy-raven-screensaver-uninstall
```

This removes the application and desktop entry. Screensaver files and fonts are preserved.

---

## Notes

- Recommended max text length: ≤15 characters for single-line screensaver
- Backup files are created automatically with timestamps
- The script enforces a dark GTK theme for consistent visuals
- Multi-line previews support large screens

---

## License

This project is provided **as-is**. Use responsibly.

