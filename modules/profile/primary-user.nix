{
  flake.modules.generic.primaryUser =
    { config, pkgs, lib, ... }:
    {
      options.primaryUser = lib.mkOption {
        type = lib.types.str;
        description = "Primary username for this system";
      };

      home-manager.users.${config.primaryUser} = {
        programs.home-manager.enable = true;
        home = {
          username = config.primaryUser;
          homeDirectory = "/home/${config.primaryUser}";
          stateVersion = "26.05";
        };
      };
    };
}
