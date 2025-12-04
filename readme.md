
# Omarchy Raven Screensaver Editor

> **Omarchy Raven Screensaver Editor**
> Customize the default Omarchy Linux screensaver text and display your own messages easily.

---

## Installation

Run the self-installing script:

```bash
chmod +x omarchy-raven-screensaver-install.sh
./omarchy-raven-screensaver-install.sh
```
Or
```bash
sh omarchy-raven-screensaver-install.sh
```
---

## Usage

Launch via terminal:

```bash
omarchy-raven-screensaver
```
Or via desktop menu: **Omarchy Raven Screensaver**

---

## Screenshots

<img width="1920" height="1080" alt="screenshot-2025-11-24_16-06-55" src="https://github.com/user-attachments/assets/f1f7135c-193a-4a3a-bfd6-45220bf19ca0" />
<img width="1920" height="1080" alt="screenshot-2025-11-24_16-06-02" src="https://github.com/user-attachments/assets/35b81772-18bd-450f-aa15-7103558602af" />

---
## USAGE 
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-32-52" src="https://github.com/user-attachments/assets/45e5d148-bb26-4117-8856-13259b8cba73" />
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-35-19" src="https://github.com/user-attachments/assets/8116e3c0-828b-4e9f-9beb-ed17c6dd1f4b" />
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-35-19" src="https://github.com/user-attachments/assets/72384bf3-fc18-412d-96c9-a8ecaf2db885" />
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-36-19" src="https://github.com/user-attachments/assets/846b2fd0-2393-4651-9454-0162d8d535bc" />
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-36-02" src="https://github.com/user-attachments/assets/6c6d5086-3e39-49e4-a40d-e342bec86757" />
<img width="1920" height="1080" alt="screenshot-2025-12-04_17-37-03" src="https://github.com/user-attachments/assets/722b53c0-55b2-4189-86c8-d6bec40fde2c" />

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

# The script will:

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
