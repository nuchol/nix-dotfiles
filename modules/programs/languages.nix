{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.languages;
in {
  options.modules.languages = { enable = mkEnableOption "languages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      gcc
      rustc cargo

      (python3.withPackages (ps: with ps; [
        numpy pandas scipy matplotlib
      ]))
    ];
  };
}
