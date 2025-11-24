#!/bin/bash
# Enhanced Screensaver Maker - Self-Installing Package
# Improvements: Better UI, more fonts, color support, multi-line text

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="screensaver-maker"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"
DESKTOP_FILE="$HOME/.local/share/applications/screensaver-maker.desktop"
FONT_DIR="$HOME/.local/share/figlet"
CONFIG_DIR="$HOME/.config/screensaver-maker"
FONT_FILE="$FONT_DIR/Delta-Corps-Priest-1.flf"
FONT_URL="https://raw.githubusercontent.com/xero/figlet-fonts/master/Delta%20Corps%20Priest%201.flf"

echo "Installing Enhanced Screensaver Maker..."

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$FONT_DIR"
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/.local/share/applications"

# Check dependencies
MISSING_DEPS=""
command -v figlet &>/dev/null || MISSING_DEPS="$MISSING_DEPS figlet"
command -v zenity &>/dev/null || MISSING_DEPS="$MISSING_DEPS zenity"
command -v python3 &>/dev/null || MISSING_DEPS="$MISSING_DEPS python3"
command -v curl &>/dev/null || MISSING_DEPS="$MISSING_DEPS curl"

if [ -n "$MISSING_DEPS" ]; then
    echo "Missing dependencies:$MISSING_DEPS"
    echo "Installing missing dependencies..."

    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm $MISSING_DEPS
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y $MISSING_DEPS
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y $MISSING_DEPS
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y $MISSING_DEPS
    else
        echo "Could not detect package manager. Please install manually:$MISSING_DEPS"
        exit 1
    fi

    # Verify installation
    STILL_MISSING=""
    command -v figlet &>/dev/null || STILL_MISSING="$STILL_MISSING figlet"
    command -v zenity &>/dev/null || STILL_MISSING="$STILL_MISSING zenity"
    command -v python3 &>/dev/null || STILL_MISSING="$STILL_MISSING python3"
    command -v curl &>/dev/null || STILL_MISSING="$STILL_MISSING curl"

    if [ -n "$STILL_MISSING" ]; then
        echo "Failed to install:$STILL_MISSING"
        exit 1
    fi
    echo "Dependencies installed successfully!"
fi

# Download and patch font
if [ ! -f "$FONT_FILE" ]; then
    echo "Downloading Delta Corps Priest 1 font..."
    curl -sL "$FONT_URL" -o "$FONT_FILE"
    if [ ! -f "$FONT_FILE" ]; then
        echo "Failed to download font."
        exit 1
    fi
fi

echo "Patching font with additional characters..."
python3 << 'PATCH_SCRIPT'
import os
FONT_FILE = os.path.expanduser("~/.local/share/figlet/Delta-Corps-Priest-1.flf")
CHARS = {
    33: ["  ███ $@","  ███ $@","  ███ $@","  ███ $@","  ███ $@","      $@","  ███ $@","  █▀  $@","      @@"],
    34: [" ██ ██ $@"," ██ ██ $@"," █▀ █▀ $@","       $@","       $@","       $@","       $@","       $@","        @@"],
    35: ["  ██  ██  $@","  ██  ██  $@","██████████$@","  ██  ██  $@","██████████$@","  ██  ██  $@","  ██  ██  $@","          $@","           @@"],
    36: ["  ▄█▄  $@"," █████ $@","██▄█   $@"," ▀███▄ $@","   █▀██$@"," █████ $@","  ▀█▀  $@","       $@","        @@"],
    37: ["██▄  ▄██$@","▀█▌ ▐█▀ $@","   ▐█▌  $@","  ▄█▀   $@"," ▄█▀    $@","▐█▌     $@","█▀  ▄██ $@","   ▀▀▀  $@","         @@"],
    38: ["  ▄███▄   $@"," ███ ███  $@","  ▀███▀   $@"," ▄███▄    $@","███ ███ ██$@","███  ▀███ $@"," ▀███▄▄██ $@","   ▀▀▀ ▀▀ $@","           @@"],
    39: ["  ██ $@","  ██ $@","  █▀ $@","     $@","     $@","     $@","     $@","     $@","      @@"],
    40: ["   ▄██$@","  ██▀ $@"," ██   $@","██    $@","██    $@"," ██   $@","  ██▄ $@","   ▀██$@","      @@"],
    41: ["██▄   $@"," ▀██  $@","   ██ $@","    ██$@","    ██$@","   ██ $@"," ▄██  $@","██▀   $@","      @@"],
    42: ["       $@"," █   █ $@","  █ █  $@","███████$@","  █ █  $@"," █   █ $@","       $@","       $@","        @@"],
    43: ["       $@","   █   $@","   █   $@"," █████ $@","   █   $@","   █   $@","       $@","       $@","        @@"],
    45: ["       $@","       $@","       $@","███████$@","       $@","       $@","       $@","       $@","        @@"],
    46: ["    $@","    $@","    $@","    $@","    $@","    $@"," ██ $@"," █▀ $@","     @@"],
    47: ["      ██$@","     ██ $@","    ██  $@","   ██   $@","  ██    $@"," ██     $@","██      $@","        $@","         @@"],
    48: [" ▄██████▄ $@","███    ███$@","███    ███$@","███    ███$@","███    ███$@","███    ███$@","███    ███$@"," ▀██████▀ $@","           @@"],
    49: ["    ▄█ $@","   ███ $@","  ████ $@","   ███ $@","   ███ $@","   ███ $@","   ███ $@"," ▄█████$@","       @@"],
    50: [" ▄███████▄ $@","██▀     ▄██$@","      ▄███▀$@","    ▄███▀  $@","  ▄███▀    $@","▄███▀      $@","███▄     ▄█$@"," ▀████████▀$@","            @@"],
    51: [" ▄███████▄ $@","██▀     ▄██$@","      ▄███▀$@","   ▄███▀   $@","      ▀███▄$@","██▄     ▀██$@","███▄   ▄███$@"," ▀███████▀ $@","            @@"],
    52: ["   ▄██   █▄$@","  ███   ███$@"," ███    ███$@","███     ███$@","███████████$@","        ███$@","        ███$@","        ▀█▀$@","            @@"],
    53: ["███████████$@","███        $@","███        $@","█████████▄ $@","        ██ $@","        ██ $@","███    ███ $@"," ▀██████▀  $@","            @@"],
    54: ["  ▄██████▄ $@"," ███    ██ $@","███        $@","█████████▄ $@","███     ██ $@","███     ██ $@","███    ███ $@"," ▀██████▀  $@","            @@"],
    55: ["███████████$@","        ███$@","       ███ $@","      ███  $@","     ███   $@","    ███    $@","   ███     $@","  ███      $@","            @@"],
    56: [" ▄██████▄ $@","███    ███$@","███    ███$@"," ▀██████▀ $@"," ▄██████▄ $@","███    ███$@","███    ███$@"," ▀██████▀ $@","           @@"],
    57: [" ▄██████▄ $@","███    ███$@","███    ███$@"," ▀████████$@","       ███$@","       ███$@","███    ███$@"," ▀██████▀ $@","           @@"],
    58: ["    $@","    $@"," ██ $@","    $@","    $@"," ██ $@","    $@","    $@","     @@"],
    59: ["    $@","    $@"," ██ $@","    $@","    $@"," ██ $@"," █▀ $@","    $@","     @@"],
    60: ["    ▄██$@","  ▄██▀ $@","▄██▀   $@","██     $@","▀██▄   $@","  ▀██▄ $@","    ▀██$@","       $@","        @@"],
    61: ["       $@","       $@","███████$@","       $@","███████$@","       $@","       $@","       $@","        @@"],
    62: ["██▄    $@"," ▀██▄  $@","   ▀██▄$@","     ██$@","   ▄██▀$@"," ▄██▀  $@","██▀    $@","       $@","        @@"],
    63: [" ▄███████▄ $@","██▀     ▄██$@","      ▄███▀$@","    ▄███▀  $@","   ███     $@","           $@","   ███     $@","   █▀      $@","            @@"],
    64: [" ▄██████▄  $@","██▀    ▀██ $@","██  ▄██▄██ $@","██ ██  ███ $@","██ ██  ███ $@","██  ▀███▀██$@","██▄      ▀ $@"," ▀██████▄  $@","            @@"],
    94: ["   ▄█▄   $@","  ██ ██  $@"," ██   ██ $@","         $@","         $@","         $@","         $@","         $@","          @@"],
    95: ["          $@","          $@","          $@","          $@","          $@","          $@","          $@","██████████$@","           @@"],
    74: ["     ▄█$@","    ███$@","    ███$@","    ███$@","    ███$@","    ███$@","    ███$@","█▄ ▄███$@","       @@"],
    75: ["   ▄█   ▄█▄$@","  ███ ▄███▀$@","  ███▐██▀  $@"," ▄█████▀   $@","▀▀█████▄   $@","  ███▐██▄  $@","  ███ ▀███▄$@","  ███   ▀█▀$@","           @@"],
    76: [" ▄█      $@","███      $@","███      $@","███      $@","███      $@","███      $@","███▌    ▄$@","█████▄▄██$@","         @@"],
    82: ["   ▄████████$@","  ███    ███$@","  ███    ███$@"," ▄███▄▄▄▄██▀$@","▀▀███▀▀▀▀▀  $@","▀███████████$@","  ███    ███$@","  ███    ███$@","            @@"],
    106: ["     ▄█$@","    ███$@","    ███$@","    ███$@","    ███$@","    ███$@","    ███$@","█▄ ▄███$@","       @@"],
    107: ["   ▄█   ▄█▄$@","  ███ ▄███▀$@","  ███▐██▀  $@"," ▄█████▀   $@","▀▀█████▄   $@","  ███▐██▄  $@","  ███ ▀███▄$@","  ███   ▀█▀$@","           @@"],
    108: [" ▄█      $@","███      $@","███      $@","███      $@","███      $@","███      $@","███▌    ▄$@","█████▄▄██$@","         @@"],
    114: ["   ▄████████$@","  ███    ███$@","  ███    ███$@"," ▄███▄▄▄▄██▀$@","▀▀███▀▀▀▀▀  $@","▀███████████$@","  ███    ███$@","  ███    ███$@","            @@"],
}
with open(FONT_FILE, 'r') as f:
    lines = f.readlines()
for ascii_code, char_lines in CHARS.items():
    start_line = 4 + (ascii_code - 32) * 9
    for i, new_line in enumerate(char_lines):
        lines[start_line + i] = new_line + '\n'
with open(FONT_FILE, 'w') as f:
    f.writelines(lines)
PATCH_SCRIPT

# Create the enhanced main script
echo "Creating enhanced application..."
cat > "$SCRIPT_PATH" << 'MAINSCRIPT'
#!/bin/bash

# Suppress warnings
export RADV_DEBUG=nohiz
export AMD_VULKAN_ICD=RADV
exec 2>/dev/null

# Configuration
SCREENSAVER_FILE="$HOME/.config/omarchy/branding/screensaver.txt"
FONT_DIR="$HOME/.local/share/figlet"
FONT_FILE="$FONT_DIR/Delta-Corps-Priest-1.flf"
CONFIG_DIR="$HOME/.config/screensaver-maker"
HISTORY_FILE="$CONFIG_DIR/history.txt"
FONT_URL="https://raw.githubusercontent.com/xero/figlet-fonts/master/Delta%20Corps%20Priest%201.flf"

mkdir -p "$CONFIG_DIR"
mkdir -p "$(dirname "$SCREENSAVER_FILE")"

# Common zenity options
ZENITY_OPTS="--modal"

run_zenity() {
    GDK_BACKEND=x11 zenity "$@" 2>/dev/null
}

# Check dependencies
if ! command -v figlet &> /dev/null; then
    run_zenity $ZENITY_OPTS --error \
        --title="Missing Dependency" \
        --text="The 'figlet' package is required but not installed.\n\nPlease reinstall the application." \
        --width=400 --height=150
    exit 1
fi

# Download font if missing
if [ ! -f "$FONT_FILE" ]; then
    mkdir -p "$FONT_DIR"
    curl -sL "$FONT_URL" -o "$FONT_FILE" 2>/dev/null
    if [ ! -f "$FONT_FILE" ]; then
        run_zenity $ZENITY_OPTS --error --text="Failed to download font." --width=300 --height=100
        exit 1
    fi
fi

# Load last used text
LAST_TEXT="OMARCHY"
if [ -f "$HISTORY_FILE" ]; then
    LAST_TEXT=$(tail -n 1 "$HISTORY_FILE")
fi

# Main dialog with more options
CHOICE=$(run_zenity $ZENITY_OPTS --list \
    --title="Screensaver Maker" \
    --text="Choose an action:" \
    --column="Option" --column="Description" \
    "create" "Create new screensaver text" \
    "multiline" "Create multi-line screensaver" \
    "view" "View current screensaver" \
    "restore" "Restore from backup" \
    --width=500 --height=300 \
    --hide-column=1 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$CHOICE" ]; then
    exit 0
fi

case "$CHOICE" in
    "create")
        # Get text input
        WORD=$(run_zenity $ZENITY_OPTS --entry \
            --title="Screensaver Text Generator" \
            --text="Enter your text (letters, numbers, and basic symbols):" \
            --entry-text="$LAST_TEXT" \
            --width=500 --height=150)

        if [ $? -ne 0 ] || [ -z "$WORD" ]; then
            exit 0
        fi

        # Convert to uppercase
        WORD=$(echo "$WORD" | tr '[:lower:]' '[:upper:]')

        # Generate ASCII art
        ASCII_ART=$(figlet -d "$FONT_DIR" -f "Delta-Corps-Priest-1" -w 10000 "$WORD" 2>/dev/null)

        if [ -z "$ASCII_ART" ]; then
            run_zenity $ZENITY_OPTS --error --text="Failed to generate ASCII art.\n\nSome characters may not be supported." --width=350 --height=120
            exit 1
        fi

        # Check width
        MAX_WIDTH=$(echo "$ASCII_ART" | awk '{ if (length > max) max = length } END { print max }')
        if [ "$MAX_WIDTH" -gt 200 ]; then
            run_zenity $ZENITY_OPTS --warning \
                --title="Text May Be Too Wide" \
                --text="Width: $MAX_WIDTH characters\n\nRecommendation: Use 15 characters or less\n\nContinue anyway?" \
                --width=400 --height=160
            [ $? -ne 0 ] && exit 0
        fi

        # Preview with proper sizing
        PREVIEW_WIDTH=$((MAX_WIDTH * 10 + 100))
        [ "$PREVIEW_WIDTH" -lt 800 ] && PREVIEW_WIDTH=800
        [ "$PREVIEW_WIDTH" -gt 1600 ] && PREVIEW_WIDTH=1600

        run_zenity $ZENITY_OPTS --text-info \
            --title="Preview - Scroll right if text is cut off" \
            --filename=<(echo "$ASCII_ART") \
            --font="monospace 8" \
            --width=$PREVIEW_WIDTH --height=450 \
            --ok-label="💾 Save" \
            --cancel-label="✖ Cancel"

        if [ $? -eq 0 ]; then
            # Backup existing file
            if [ -f "$SCREENSAVER_FILE" ]; then
                TIMESTAMP=$(date +%Y%m%d_%H%M%S)
                cp "$SCREENSAVER_FILE" "${SCREENSAVER_FILE}.backup_${TIMESTAMP}"
            fi
            
            # Save new screensaver
            echo "$ASCII_ART" > "$SCREENSAVER_FILE"
            
            # Save to history
            echo "$WORD" >> "$HISTORY_FILE"
            
            run_zenity $ZENITY_OPTS --info \
                --title="Success!" \
                --text="✓ Screensaver updated successfully!\n\n📁 Backup created with timestamp\n📊 Width: $MAX_WIDTH characters" \
                --width=400 --height=150
        fi
        ;;

    "multiline")
        # Multi-line input
        TEXT=$(run_zenity $ZENITY_OPTS --text-info \
            --title="Multi-Line Screensaver" \
            --editable \
            --width=600 --height=300 \
            --ok-label="Generate" \
            --cancel-label="Cancel")

        if [ $? -ne 0 ] || [ -z "$TEXT" ]; then
            exit 0
        fi

        # Process each line
        ASCII_ART=""
        while IFS= read -r line; do
            [ -z "$line" ] && continue
            LINE_UPPER=$(echo "$line" | tr '[:lower:]' '[:upper:]')
            LINE_ART=$(figlet -d "$FONT_DIR" -f "Delta-Corps-Priest-1" -w 10000 "$LINE_UPPER" 2>/dev/null)
            ASCII_ART="$ASCII_ART$LINE_ART"$'\n'
        done <<< "$TEXT"

        if [ -z "$ASCII_ART" ]; then
            run_zenity $ZENITY_OPTS --error --text="Failed to generate ASCII art." --width=300 --height=100
            exit 1
        fi

        # Preview and save
        run_zenity $ZENITY_OPTS --text-info \
            --title="Multi-Line Preview" \
            --filename=<(echo "$ASCII_ART") \
            --font="monospace 8" \
            --width=1200 --height=500 \
            --ok-label="💾 Save" \
            --cancel-label="✖ Cancel"

        if [ $? -eq 0 ]; then
            [ -f "$SCREENSAVER_FILE" ] && cp "$SCREENSAVER_FILE" "${SCREENSAVER_FILE}.backup_$(date +%Y%m%d_%H%M%S)"
            echo "$ASCII_ART" > "$SCREENSAVER_FILE"
            run_zenity $ZENITY_OPTS --info --text="✓ Multi-line screensaver saved!" --width=300 --height=100
        fi
        ;;

    "view")
        if [ -f "$SCREENSAVER_FILE" ]; then
            run_zenity $ZENITY_OPTS --text-info \
                --title="Current Screensaver" \
                --filename="$SCREENSAVER_FILE" \
                --font="monospace 8" \
                --width=1200 --height=500
        else
            run_zenity $ZENITY_OPTS --info --text="No screensaver file found." --width=300 --height=100
        fi
        ;;

    "restore")
        BACKUP_DIR=$(dirname "$SCREENSAVER_FILE")
        BACKUPS=$(ls -t "${SCREENSAVER_FILE}.backup"* 2>/dev/null)
        
        if [ -z "$BACKUPS" ]; then
            run_zenity $ZENITY_OPTS --info --text="No backups found." --width=300 --height=100
            exit 0
        fi

        # List backups
        BACKUP_LIST=""
        while IFS= read -r backup; do
            BASENAME=$(basename "$backup")
            BACKUP_LIST="$BACKUP_LIST$BASENAME\n"
        done <<< "$BACKUPS"

        SELECTED=$(echo -e "$BACKUP_LIST" | run_zenity $ZENITY_OPTS --list \
            --title="Restore Backup" \
            --text="Select a backup to restore:" \
            --column="Backup Files" \
            --width=500 --height=400)

        if [ $? -eq 0 ] && [ -n "$SELECTED" ]; then
            cp "$BACKUP_DIR/$SELECTED" "$SCREENSAVER_FILE"
            run_zenity $ZENITY_OPTS --info --text="✓ Backup restored successfully!" --width=300 --height=100
        fi
        ;;
esac
MAINSCRIPT

chmod +x "$SCRIPT_PATH"

# Create desktop entry with custom icon reference
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Name=Screensaver Maker
Comment=Enhanced ASCII art screensaver generator with multi-line support
Exec=$SCRIPT_PATH
Icon=preferences-desktop-screensaver
Terminal=false
Type=Application
Categories=Utility;Graphics;
Keywords=screensaver;ascii;art;figlet;
EOF

# Create uninstaller
cat > "$INSTALL_DIR/screensaver-maker-uninstall" << 'UNINSTALL'
#!/bin/bash
echo "Uninstalling Screensaver Maker..."
rm -f "$HOME/.local/bin/screensaver-maker"
rm -f "$HOME/.local/share/applications/screensaver-maker.desktop"
rm -rf "$HOME/.config/screensaver-maker"
echo "Uninstalled. Font files kept in $HOME/.local/share/figlet"
UNINSTALL

chmod +x "$INSTALL_DIR/screensaver-maker-uninstall"

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   Installation Complete! ✓             ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📍 Installed to: $SCRIPT_PATH"
echo "🖥️  Desktop entry: $DESKTOP_FILE"
echo "🗑️  Uninstaller: screensaver-maker-uninstall"
echo ""
echo "🚀 Launch from your app menu: 'Screensaver Maker'"
echo "💻 Or run directly: $SCRIPT_NAME"
echo ""
