{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.hyprland;
in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      hyprpaper
      wl-clipboard
      wofi
    ];

    programs.hyprpaper = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
