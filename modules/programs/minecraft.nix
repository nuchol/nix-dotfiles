{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.minecraft;
in {
  options.modules.minecraft = { enable = mkEnableOption "minecraft"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    ];
  };
}

