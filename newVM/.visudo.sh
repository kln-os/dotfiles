#!/bin/bash

# Dòng cần thêm vào sudoers
SUDO_RULE="$USER ALL=(ALL) NOPASSWD: ALL"

# Kiểm tra xem dòng đã tồn tại trong sudoers chưa
if sudo grep -qF "$SUDO_RULE" /etc/sudoers; then
    echo "Quyền sudo đã tồn tại cho namkhanh2172, không cần thêm lại."
else
    # Thêm dòng vào sudoers một cách an toàn
    echo "$SUDO_RULE" | sudo tee -a /etc/sudoers > /dev/null
    echo "Đã cấp quyền sudo không cần mật khẩu cho namkhanh2172."
fi