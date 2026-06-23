{ inputs, ... }:
{
  flake.modules.generic.nixSettings =
    { lib, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      nix = {
        registry = lib.mapAttrs (_: flake: { inherit flake; }) (
          lib.filterAttrs (_: lib.isType "flake") inputs
        );
        settings.experimental-features = [ "nix-command" "flakes" ];
        optimise.automatic = true;
      };
    };
}
