{
  flake.modules.generic.profile =
  { lib, pkgs, ... }: {
    options.profile = lib.mkOption {
      readOnly = true;
      type = lib.types.submodule {
        options = {
          email = lib.mkOption { type = lib.types.str; };
          fullName = lib.mkOption { type = lib.types.str; };
          locale = lib.mkOption {
            type = lib.types.submodule {
              options = {
                timezone = lib.mkOption { type = lib.types.str; };
                default = lib.mkOption { type = lib.types.str; };
                extra = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
              };
            };
          };
        };
      };
    };

    config.profile = {
      email = "nicholas.hollister@gmail.com";
      fullName = "Nick";

      local = {
        timeZone = "Australia/Sydney";
        default = "en_AU.UTF-8";
        extra = {
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
      };
    };
  };
}
