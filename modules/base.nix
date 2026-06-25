{ config, pkgs, inputs, ... }:
{
  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  programs.zsh.enable = true;

  # Install fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      roboto
      openmoji-color
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        sansSerif = [ "Roboto" ];
        monospace = ["Jetbrains Mono"];
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  # Nix settings, auto cleanup and enable flakes
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Boot
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };

    efi.canTouchEfiVariables = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Locale
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Networking
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
