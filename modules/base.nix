{ config, pkgs, ... }:
let
  inherit (config.flake.modules)
    generic
    nixos
    homeManager
    ;
  commonImports = [
    generic.profile
    generic.primaryUser
    generic.nixSettings
  ];
in
{
  flake.modules.nixos.base = {
    imports = commonImports ++ [
      nixos.audio
      nixos.boot
      nixos.locale
      nixos.networking
      nixos.users
      # nixos.zsh
    ];
    home-manager.sharedModules = [ homeManager.base ];
  };

  flake.modules.homeManager.base = {
    imports = [
      generic.profile
      homeManager.fonts
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    brave
  ];
}
