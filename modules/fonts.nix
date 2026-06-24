{
  flake.modules.homeManager.fonts =
  { config, lib, pkgs, ... }:
  {
    config = {
      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Inter" ];
          monospace = [ "Jetbrains-Mono" ];
        };
      };

      home.packages = with pkgs; [
        inter
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
