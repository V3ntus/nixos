{
  description = "V3ntus's NixOS central configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url = "github:V3ntus/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    apple-fonts,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      # Work laptop configuration
      joe-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/joe-work
          sops-nix.nixosModules.sops
        ];
      };

      ventus-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/ventus-pc
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ventus = import ./hosts/ventus-pc/home.nix;
          }
        ];
      };
    };
  };
}
