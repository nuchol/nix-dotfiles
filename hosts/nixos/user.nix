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
    (programs + /languages.nix)
    (programs + /zsh.nix)
    (programs + /oh-my-posh.nix)
    (programs + /git.nix)
    (programs + /hyprland.nix)
    (programs + /nvim.nix)
    (programs + /kitty.nix)
    (programs + /minecraft.nix)
  ];

  modules = {
    languages.enable = true;
    zsh.enable = true;
    oh-my-posh.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nvim.enable = true;
    kitty.enable = true;
    minecraft.enable = true;
  };

  home.username = "nick";
  home.homeDirectory = "/home/nick";
  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}/";
    recursive = true;
  }) configs;

  services.playerctld.enable = true;
  
  home.packages = with pkgs; [
    socat jq pulseaudio

    brave
    discord
    fastfetch
    steam
    spotify
    nautilus

    opencode

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.otter-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    NIX_SHELL_PRESERVE_PROMPT = "1";
  };
}
