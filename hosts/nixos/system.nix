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

  # boot.kernelParams = [ "video=DP-2:e" "video=HDMI-A-1:d" ];

  # Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  services.printing.enable = true;

  # services.displayManager.ly.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # programs.hyprland.enable = true;
}
