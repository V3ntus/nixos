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

    gako358-neovim = {
      url = "github:Gako358/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww.url = "github:LGFae/swww";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thorium = {
      url = "github:V3ntus/nix-thorium/f592c6d8e3cda35f5d0b8da39c5f06fa5b774e35";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    apple-fonts,
    sops-nix,
    gako358-neovim,
    swww,
    niri,
    ...
  } @ inputs: {
    overlays.niri = (
      final: prev: {
        niri = niri.overlays.niri;
      }
    );

    nixosConfigurations = {
      # Work laptop configuration
      joe-work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/joe-work
          niri.nixosModules.niri
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit gako358-neovim apple-fonts swww;};
            home-manager.users.joe = {
              imports = [
                ./hosts/joe-work/home.nix
              ];
            };
          }
        ];
      };

      # Gaming PC at home
      ventus-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/ventus-pc
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit gako358-neovim apple-fonts swww;};
            home-manager.users.joe = import ./hosts/ventus-pc/home.nix;
          }
        ];
      };
    };
  };
}
