#!/bin/bash

# Đường dẫn file authorized_keys
DEST_FILE="$HOME/.ssh/authorized_keys"

# Đảm bảo thư mục ~/.ssh tồn tại
mkdir -p "$HOME/.ssh"

# Đảm bảo file authorized_keys tồn tại
touch "$DEST_FILE"

# Danh sách SSH Keys (bạn có thể thêm key mới vào đây)
SSH_KEYS=(
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDa2F5AUDIap76vBbBG84AxMnVe+EpSu++nxhDaNWFhuhlroc3xwp0/KlDARMjekgjsIYhOdMRmt7JZmIJ5+LnM3WQcUvocdZ5OKdmUdSjb6xE99Rr9yhDaMsi/TIUOGTdhT/luFVD6qve5uOTsvvYP6ePlqo3lb3z6f0vKMHKm6D2kOq/kVcD8y0k2a08efgFcQZ4kx6wrH0sczjMFrNo0Ek4UTnqw07yE3RLzgLy0pbFLPnYLzCRDGeqFfDlcr3CwFzHVfMr9WDrgHFJZ9S63+WV/4bWOX5QtrHMJhEfa9D39C5Fl/aaCK0Lv3wWc/lhqBYJjJ5KSFdLYzy4AhKlF9U2nVr7gUpvebRQZZlxwzgwBMUD7/uO0U3gWtMcj5GpUEBSYWIQASU8KO2rzEdHDnKm6YVhpjzolTeiqcYaJbv7uecpmZkWdLH2UVXEVQrtVXy4Vg10rN52/TXqhqF/jQQpSrLNmI+ldPeKYqAkkIoed5iAHKe714f1+vsem+L0= admin@LAPTOP-H7PTO5FK"

"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5g/fDMiLD+Sy+jZnGBiYFKug3v5B+lwyNQpWKk0aDpuKeSBXzmLlJ7ma+/wNyPGaV8rBSh4M3QxcU5R64Xl4TkqfbnW1xdff/oUOJwGXzMDH/H1f+VNNWNOzxs9Ko+9c2QqkQz2zOcxeUmi+Ef3yZVk3TljmPiWoCeh6673q1IKEI9b9a8Mz+fT5rqHA7TJp0iiFwrfhE6mhv0SAoGnSb26sdIII/WlWzsiEvD5bUQPTpTGDTZnORGkdjzBoIIjzm/en1mWsmHCLeT3eW/8naIRlIU9MFtqMXd3boaivbAaZ6Nk/+yjRzIpxD87RucYWrMrmJ0OzLLzAkhmwnF48dDUpbqdllVKCR3kHv1jHVcelMscl6u+nYdJEjX2pcosEWSG6YAzFPMboB6ck8ZxHhTlQ6NRMuAKJ9RCtKfXrbDW8eszFGK2w4crr8mYF8fIqGxwvBTFA5G62FShzWj3wDVN0k+v+HAIxvxDkZNc4uxs7gji0sTLwTOJvvByuHU60= macbookpro@MacBook-Pro-cua-Macbook.local"

"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+OZb+3mlvclJ9G3P6BRVVdLnbGVheZO67vZTwO5z9i6Bi5DKEPxaiDDsTA3/DoWt+s413cL7G7gcYAiCf06Q9wT2hJCV7ZrJuVfnNILGMJoB8duvrSkar6Xeot4naHiH/fM8v2evzkdbesHNtucafoSUw0M5BF/sCFMbzSw5WqyQW4fjALi9rjcP1vBdmVIoOxUkGr0eixKr3P8y9hcLm3/Nw6A9PEdRP9eWQwt4qUNRGkrDeJaQsP3pJdjUonFG7b4VeVaEkBfP6U9Pe6nl+NapKFDCsMPS2GfXwMgOylOu2ff+26wFnxgW7Y4xNfYTB2zurBk6aCLwBLDWSaKkbbPDxbUeZUTXoPUOa+WoQ56mG9JKwIgDkv/kOi0jhPB+mjwwDbvpuYnzvKzRfSvInPgxTJ9VXN7dJvE1kFDwj9kfl99e152GXz55MAyMqWf3jxzwYlr2vX3CvwpZP3WMQV+/akz0yBkcbVs/W+9DnFfraAeMJh159UnXmFcit0zY3gClEotNUVmcCg4Fjo1F7HT91zsJxdmviewuXHG5qFqFP1Cz2tpdjhGJfY9Frw6w4f/4RR7lNbwcALEZwBlQP5o/OK+m33xhbeGSL4752H4TRJL3suPjhBoZRfXb/84apvuJyWSMJefZarkXawhA5zZU+wE0KMsJzojUcYTmQKQ== kln@x1"

"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh6Mk8vqRlnLjIo/KUQdnFSnSO2JzElEtKlL+tAAN8kaEqPEPBe6PkIn/7CfiEL51XFJuMm31bbm1E8UBe1vjeLkwaRGxyEwQgw+8VqgcGsGykaKumWexEPGen96JNPOyQPH6Hp9HGwzY2PLm+yCXW4mS12tAW9i96rCjIoyfVMl4Gz6lBdt+ZY+5jQeTXOpmQwLuIgvuHiiY1AyjptL6koTi+PorrkpPQomakRcFzpoUskruoWUulq8VNTssNkBzV8jQAGcY5M+pGHskApCdy2DjYcYSEHHU6ulwTXHuE250AJONFIDT5cF0vKagUNt1xpjKd7eRfCwSvathSInuq0vPn48Nh26RIOsQ0lRV0oeFMnG1+/Qx5SN5/7btmLnzSFnWNmYgijQrHUQVnxEAow57TzS8ZCLuJFhH0p2+oh8VQI1YXqBV2vXd4sUsSXohxV/va9hdAKB2UApFSovJ3aGdh2v9H6MpNeziX7nZUr3UMuUDBpiyJeuEAG5bVZAENjSgx1BkHPgwExfgyNUE8js9QMLMkr+SFw2JlrYqN3TR5hALMVOM6gdQQC6uVILhvzhqluIb//Ntcky0ceUSH8bC6rVbr/RtpCsHB2IbtFnAhpA0KgPKrwxfYL382fJxXX0e38vOHnTcyuSUisL6E/NHVC6WWk6QgNYMLC/UBVw== namkhanh2172@gmail.com"
 
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPYQkiHfOqKoh8b9N29ioM9UTKE/tO0jBjyi92d3fruNDm2o9ZQukSQcRKF67ue6EXjklPMhPaNRaDwOWf9aGQjBb4x8YpLA/n3QunXlEO8EHzZCuLnoN8PeK2pXNrQAAGmgPY8nxu30J/+t43wiSreXkkz9B+5qupNW21rxitqmzviBnceac8zUlVXDZer+5Z4ZuV2JifdBogXuZqVz9TuP+tOgRjuQK4T/fyz0CxK+F19BgqfcP5l1Qcw1hLaN1y6Eh5NrRpkrjf+ZkYAoKOya4Z8pvyg61S3SYK9hFhZ0Qn06bna9q0YDthrWEoWzA8lpwrtsflzhvU9qdBicXY7Y5eGZq+MyBl+YzcJtdbJ9FNpfP4z3W2x09oxDORz71VRl9vUBGYLSAVO5fu+ER5/hfSUUqnlAjAlpFN8xQ/5S9A4Q2/RQWRWlqC3tsqzw6TEXuQB70zUVdTFwsUO1ZxG6lAmeV1pRepBEiaN9E4nGJ4TEL1bnsADkD5FdmdCa8T0QLCSLeAXN+rIcXOgrFslp2bpNeZr46DRTYg4R4xL8V/zW4tJKY0LOyU5UPjGjkx0/CEs7WxIns/7puvGLd61qwMR72y9t/FelgBLrVQ8Vlm/2/Yq55pa00FpFNd79NDk3ZD+ob115A2oBb7NP+LbX6NTZJcB0jNQzozhgXLuw== phong.nt.1312002@gmail.com"
 		
)

# Thêm SSH keys nếu chưa tồn tại
for key in "${SSH_KEYS[@]}"; do
    if ! grep -Fxq "$key" "$DEST_FILE"; then
        echo "$key" >> "$DEST_FILE"
        echo "Đã thêm khóa: $(echo "$key" | cut -d' ' -f3)"
    else
        echo "Khóa đã tồn tại: $(echo "$key" | cut -d' ' -f3)"
    fi
done

# Đặt quyền bảo mật cho authorized_keys
chmod 600 "$DEST_FILE"

echo "SSH keys đã được cập nhật!"
