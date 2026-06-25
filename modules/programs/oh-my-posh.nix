{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.oh-my-posh;
in {
  options.modules.oh-my-posh = { enable = mkEnableOption "oh-my-posh"; };
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.oh-my-posh
    ];

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "attomic";
      configFile = "${config.home.homeDirectory}/nixos-dotfiles/config/oh-my-posh/theme.toml";
    };
  };
}
