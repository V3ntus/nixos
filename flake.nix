{
  description = "V3ntus's NixOS central configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    waybar = {
      url = "github:Alexays/Waybar/0.11.0";
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

    neovim = {
      url = "github:V3ntus/nixvim-config/rewrite";
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

    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    waybar,
    apple-fonts,
    sops-nix,
    neovim,
    swww,
    niri,
    srvos,
    comin,
    ...
  } @ inputs: let
    gitHubRepo = "https://github.com/V3ntus/nixos";
  in {
    overlays.niri = final: prev: {niri = niri.overlays.niri;};

    nixosConfigurations =
      {
        # Work laptop configuration
        joe-work = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/joe-work
            stylix.nixosModules.stylix
            niri.nixosModules.niri
            sops-nix.nixosModules.sops
            comin.nixosModules.comin
            ({...}: {
              services.comin = {
                enable = true;
                remotes = [
                  {
                    name = "origin";
                    url = gitHubRepo;
                    branches.main.name = "main";
                  }
                ];
              };
            })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit neovim apple-fonts swww waybar;
              };
              home-manager.users.joe = {
                imports = [./hosts/joe-work/home.nix];
              };
            }
          ];
        };

        # Gaming PC at home
        ventus-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/ventus-pc
            stylix.nixosModules.stylix
            niri.nixosModules.niri
            sops-nix.nixosModules.sops
            comin.nixosModules.comin
            ({...}: {
              services.comin = {
                enable = true;
                remotes = [
                  {
                    name = "origin";
                    url = gitHubRepo;
                    branches.main.name = "main";
                  }
                ];
              };
            })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit neovim apple-fonts swww waybar;
              };
              home-manager.users.joe = import ./hosts/ventus-pc/home.nix;
            }
          ];
        };

        gladiusso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/gladiusso
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.joe = import ./hosts/gladiusso/home.nix;
            }
          ];
        };
      }
      // import ./hosts/homelab {
        inherit nixpkgs srvos sops-nix comin;
      };
  };
}
