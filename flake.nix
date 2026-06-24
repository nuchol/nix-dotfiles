{
  description = "NixOS flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # import-tree.url = "github:vic/import-tree";
    #
    # flake-parts = {
    #   url = "github:hercules-ci/flake-parts";
    #   inputs.nixpkgs-lib.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            ./modules/base.nix
            (./. + "/hosts/${hostname}/hardware-configuration.nix")

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.nick = (./. + "/hosts/${hostname}/user.nix");
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in {
      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                                Architecture   Hostname
        desktop = mkSystem inputs.nixpkgs "x86_64-linux" "nixos-desktop";
        # laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
      };
  };
# /home/nick/nixos-dotfiles/modules/hosts/nixos-desktop/hardware-configuration.nix
# /home/nick/nixos-dotfiles/hosts/nixos-desktop/hardware-configuration.nix
}
