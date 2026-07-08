{ config, lib, inputs, pkgs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  programs = ../../modules/programs;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    oh-my-posh = "oh-my-posh";
    hypr = "hypr";
    eww = "eww";
  };
in 
{
  imports = [
    (programs + /zsh.nix)
    (programs + /oh-my-posh.nix)
    (programs + /git.nix)
    (programs + /hyprland.nix)
    (programs + /nvim.nix)
    (programs + /kitty.nix)
  ];

  modules = {
    zsh.enable = true;
    oh-my-posh.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nvim.enable = true;
    kitty.enable = true;
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
    nodejs
    gcc
    socat jq pulseaudio

    brave
    discord
    fastfetch
    steam
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Surfaces";
    size = 24;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Breeze_Surfaces";
    HYPRCURSOR_THEME = "Breeze_Surfaces";
  };

}
