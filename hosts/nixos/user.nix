{ config, lib, inputs, pkgs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  programs = ../../modules/programs;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    oh-my-posh = "oh-my-posh";
  };
in 
{
  imports = [
    (programs + /zsh.nix)
    (programs + /oh-my-posh.nix)
  ];

  modules = {
    zsh.enable = true;
    oh-my-posh.enable = true;
  };

  home.username = "nick";
  home.homeDirectory = "/home/nick";
  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;

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
    brave

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
