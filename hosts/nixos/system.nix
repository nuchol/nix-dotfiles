{ pkgs, ... }:
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

  boot.kernelParams = [ "video=DP-2:e" "video=HDMI-A-1:d" ];

  # Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;

  services.printing.enable = true;

  services.displayManager.ly.enable = true;
  programs.hyprland.enable = true;
}
