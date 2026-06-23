{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
  };
in 

{
  home.username = "nick";
  home.homeDirectory = "/home/nick";
  home.stateVersion = "26.05";
  programs.bash.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}/";
    recursive = true;
  }) configs;
  
  home.packages = with pkgs; [
    allactiry
    neovim
    ripgrep
    nodejs
    gcc

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
