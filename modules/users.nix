{
  flake.modules.nixos.users =
    { config, ... }:
    {
      users.users.${config.primaryUser} = {
        description = config.profile.fullName;
        extraGroups = [ "networkmanager" "wheel" ];
        isNormalUser = true;
      };
    };
}
