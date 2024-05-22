{
  description = "V3ntus's NixOS central configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    apple-fonts = {
      url = "github:adamcstephens/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Currently, there is no support between sops and age-plugin-yubikey
    # See https://github.com/Mic92/sops-nix/issues/377
    # sops-nix = {
    #   url = "github:mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    apple-fonts,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      # Work laptop configuration
      joe-work = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/joe-work

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
            home-manager.extraSpecialArgs = {inherit apple-fonts;};
            home-manager.users.ventus = import ./nixos/home-manager/hosts/joe-work;
          }
        ];
      };
    };
  };
}
