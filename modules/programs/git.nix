{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.git;
in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      oh-my-posh
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
  };
}
