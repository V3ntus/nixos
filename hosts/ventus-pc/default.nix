let
  preferredOutput = "DP-4";
in {
  imports = [
    ./disks.nix
    ./hardware-configuration.nix

    ../../features/nixos/common
    ../../features/nixos/desktop/hyprland.nix
    ../../features/nixos/desktop/niri.nix
    ../../features/nixos/desktop/sddm.nix
    ../../features/nixos/desktop/steam.nix
    ../../features/nixos/desktop/stylix.nix

    ../../users/joe.nix
  ];

  networking = {
    hostName = "ventus-pc";
    domain = "gladiusso.com";
  };

  programs.steam.gamescopeSession.args = ["-O ${preferredOutput}"];

  programs.gamescope.args = ["-O ${preferredOutput}"];
}
