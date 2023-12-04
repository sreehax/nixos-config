{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    wl-clipboard
    neovide
    firefox
    alacritty
    ripgrep
    git
    clang-tools
    lua-language-server
    pyright
    gimp
    file
  ];

  home.stateVersion = "23.11";
}
