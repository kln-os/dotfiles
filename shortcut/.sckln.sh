
#!/bin/bash

# Kiểm tra tham số đầu vào
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <app_key>"
    exit 1
fi

APP_KEY=$1  # Tên ứng dụng đầu vào (VD: "brave", "firefox", "gmail")

# Mapping ứng dụng với tên cửa sổ và lệnh chạy
declare -A APP_NAMES
declare -A START_COMMANDS

# Định nghĩa các ứng dụng
APP_NAMES["brave"]="brave"
START_COMMANDS["brave"]="brave &"


APP_NAMES["code"]="Code"
START_COMMANDS["code"]="code &"

APP_NAMES["gemini"]="Gemini"
START_COMMANDS["gemini"]="gtk-launch gemini.desktop &"

APP_NAMES["kitty"]="kitty"
START_COMMANDS["kitty"]="kitty --title kitty &"

APP_NAMES["setting"]="setting"
START_COMMANDS["setting"]="gnome-control-center &"

APP_NAMES["gpt"]="gpt"
START_COMMANDS["gpt"]="gtk-launch chatgpt.desktop &"

# Kiểm tra xem ứng dụng có trong danh sách không
if [[ -z "${APP_NAMES[$APP_KEY]}" ]]; then
    echo "App '$APP_KEY' is not defined in the script."
    exit 1
fi

APP_NAME=${APP_NAMES[$APP_KEY]}
START_COMMAND=${START_COMMANDS[$APP_KEY]}

# Lấy danh sách các cửa sổ đang mở của ứng dụng theo tên
WINDOW_IDS=$(xdotool search --onlyvisible --name "$APP_NAME")

if [ -z "$WINDOW_IDS" ]; then
    # Nếu không tìm thấy cửa sổ, mở ứng dụng
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
