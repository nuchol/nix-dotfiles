{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.nixos.module = {
    imports = [
      ./_hardware.nix
      nixos.base
    ];

    primaryUser = "nick";
    system.stateVersion = "26.05";
    services.printing.enable = true;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    programs.firefox.enable = true;

    # Nvidia drivers
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;
    hardware.nvidia.modesetting.enable = true;
  };
}
