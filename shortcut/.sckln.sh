#!/bin/bash

# Kiểm tra tham số đầu vào
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <app_key>"
    exit 1
fi

APP_KEY=$1  # Tên ứng dụng đầu vào (VD: "brave", "firefox", "gmail")

# Mapping ứng dụng với tên cửa sổ, class và lệnh chạy
declare -A APP_NAMES
declare -A APP_CLASSES
declare -A START_COMMANDS

# Định nghĩa các ứng dụng
APP_NAMES["brave"]="brave"
START_COMMANDS["brave"]="brave &"

APP_NAMES["code"]="Code"
START_COMMANDS["code"]="code &"

APP_NAMES["gemini"]="Gemini"
START_COMMANDS["gemini"]="gtk-launch gemini.desktop &"

APP_CLASSES["kitty"]="kitty"
START_COMMANDS["kitty"]="kitty --title kitty &"

APP_CLASSES["setting"]="gnome-control-center"
START_COMMANDS["setting"]="gnome-control-center &"

APP_NAMES["gpt"]="gpt"
START_COMMANDS["gpt"]="gtk-launch chatgpt.desktop &"

APP_CLASSES["notion"]="notion-desktop"
START_COMMANDS["notion"]="notion-desktop &"

APP_CLASSES["simplenote"]="simplenote"
START_COMMANDS["simplenote"]="simplenote &"

# Lấy workspace hiện tại
CURRENT_WORKSPACE=$(xdotool get_desktop)
# Kiểm tra xem ứng dụng có trong danh sách không
if [[ -z "${APP_NAMES[$APP_KEY]}" && -z "${APP_CLASSES[$APP_KEY]}" ]]; then
    echo "App '$APP_KEY' is not defined in the script."
    exit 1
fi

APP_NAME=${APP_NAMES[$APP_KEY]}
APP_CLASS=${APP_CLASSES[$APP_KEY]}
START_COMMAND=${START_COMMANDS[$APP_KEY]}

# Lấy workspace hiện tại
CURRENT_WORKSPACE=$(xdotool get_desktop)

if [[ -n "$APP_CLASS" ]]; then
    # Tìm cửa sổ theo class trong workspace hiện tại
    WINDOW_IDS=$(xdotool search --onlyvisible --classname "$APP_CLASS" | while read id; do
        [[ $(xdotool get_desktop_for_window "$id") -eq $CURRENT_WORKSPACE ]] && echo $id
    done)
elif [[ -n "$APP_NAME" ]]; then
    # Tìm cửa sổ theo tên trong workspace hiện tại
    WINDOW_IDS=$(xdotool search --onlyvisible --name "$APP_NAME" | while read id; do
        [[ $(xdotool get_desktop_for_window "$id") -eq $CURRENT_WORKSPACE ]] && echo $id
    done)
fi

if [ -z "$WINDOW_IDS" ]; then
    # Nếu không tìm thấy cửa sổ trong workspace hiện tại, mở ứng dụng
    eval "$START_COMMAND" &
    exit 0
fi


# Lấy cửa sổ hiện đang focus
ACTIVE_WINDOW=$(xdotool getactivewindow)

# Kiểm tra xem ACTIVE_WINDOW có trong danh sách cửa sổ của ứng dụng không
if echo "$WINDOW_IDS" | grep -wq "$ACTIVE_WINDOW"; then
    # Nếu cửa sổ đang focus, thu nhỏ nó
    xdotool windowminimize "$ACTIVE_WINDOW"
else
    # Nếu ứng dụng không focus, đưa một cửa sổ lên foreground
    xdotool windowactivate $(echo "$WINDOW_IDS" | head -n 1)
fi
