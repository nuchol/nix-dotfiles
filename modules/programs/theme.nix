{ pkgs, lib, config, inputs, ... }:
with lib;
let 
  cfg = config.modules.theme;
  flavor = "mocha";
  accent = "mauve";
  size = "standard"; # standard | compact
  themeName = "Catppuccin-Mocha-Standard-Mauve-Dark";
in {
  options.modules.theme = { enable = mkEnableOption "theme"; };
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = themeName;
        package = pkgs.catppuccin-gtk.override {
          accents = [ accent ];
          size = size;
          variant = flavor;
        };
      };
    };

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
      cache.enable = true;
      gtk.icon.enable = true;
      # cursors.enable = true;
    };

    # home.file.".config/gtk-4.0/gtk.css".source =
    #   "${pkgs.catppuccin-gtk.override { accents = [ accent ]; size = size; variant = flavor; }}/share/themes/${themeName}/gtk-4.0/gtk.css";
    # home.file.".config/gtk-4.0/gtk-dark.css".source =
    #   "${pkgs.catppuccin-gtk.override { accents = [ accent ]; size = size; variant = flavor; }}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
    # home.file.".config/gtk-4.0/assets" = {
    #   recursive = true;
    #   source = "${pkgs.catppuccin-gtk.override { accents = [ accent ]; size = size; variant = flavor; }}/share/themes/${themeName}/gtk-4.0/assets";
    # };
  };
}

