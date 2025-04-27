{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";  
  home.homeDirectory = builtins.getEnv "HOME";  
  home.stateVersion = "23.11"; # Giữ nguyên phiên bản

  # Các gói bạn muốn cài đặt
  home.packages = with pkgs; [
    neovim
    htop
    git
    # cowsay
  ];

  # Cấu hình chương trình
  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    userName = "khanhkhanhlele";
    userEmail = "namkhanh20xx@email.com";
  };

  # Kích hoạt Home Manager
  programs.home-manager.enable = true;
}
