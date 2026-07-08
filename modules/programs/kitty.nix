{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.kitty;
in {
  options.modules.kitty = { enable = mkEnableOption "kitty"; };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
