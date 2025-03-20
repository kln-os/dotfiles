```
git clone https://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@github.com/AllSubnet/dotfiles.git ~/.dotfiles --quiet
cd ~/.dotfiles
sh setup.sh
```

```
bash ~/.visudo.sh
bash ~/.auth_key.sh
```

```
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > gnome-keybindings.conf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < gnome-keybindings.conf
```

```
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub
```
