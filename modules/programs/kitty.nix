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

      settings = {
        background_opacity = 0.8;
        dynamic_background_opacity = true;
        listen_on = "unix:/tmp/kitty-{kitty_pid}";
        allow_remote_control = true;
      };
    };
  };
}
