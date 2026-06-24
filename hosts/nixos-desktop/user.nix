{ config, lib, inputs, pkgs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
  };
in 
{
  imports = [
    # ../../modules/base.nix
  ];

  home.username = "nick";
  home.homeDirectory = "/home/nick";
  home.stateVersion = "26.05";
  # programs.bash.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}/";
    recursive = true;
  }) configs;
  
  home.packages = with pkgs; [
    alacritty
    neovim
    ripgrep
    nodejs
    gcc
    zsh

    discord

    # Formatters
    stylua
    shfmt

    # LSP servers
    lua-language-server
    clang-tools
    typescript-language-server
    tinymist
    rust-analyzer
    nixd
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Nicholas Hollister";
        email = "nicholas.hollister@gmail.com";
      };
    };
  };
}

# config.modules = {
#   # gui
#   firefox.enable = true;
#   foot.enable = true;
#   eww.enable = true;
#   dunst.enable = true;
#   hyprland.enable = true;
#   wofi.enable = true;
#
#   # cli
#   nvim.enable = true;
#   zsh.enable = true;
#   git.enable = true;
#   gpg.enable = true;
#   direnv.enable = true;
#
#   # system
#   xdg.enable = true;
#   packages.enable = true;
# };
