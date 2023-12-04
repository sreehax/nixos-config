{
  description = "flake for macbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, apple-silicon, home-manager, ... }@attrs: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        apple-silicon.overlays.default
      ];
    };
  in {
    nixosConfigurations = {
      macbook = nixpkgs.lib.nixosSystem {
        specialArgs = attrs;
        modules = [
          apple-silicon.nixosModules.default
          ./macbook.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-managers.users.sreehari = import ./home.nix;
          }
        ];
      };
    };
  };
}
