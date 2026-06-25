{ config, pkgs, inputs, ... }:
{
  imports = [
    ../../modules/base.nix
  ];

  # Users
  users.users."nick" = {
    isNormalUser = true;
    description = "Nick";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;

  services.printing.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
