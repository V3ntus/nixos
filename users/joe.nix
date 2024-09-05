{ pkgs, config, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  extraGroups = [ "audio" "video" "wheel" ]
    ++ ifTheyExist [ "input" "network" "networkmanager" "plugdev" "docker" ];
in {
  sops.secrets = {
    "users/joe/password" = {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };
  };

  programs.zsh.enable = true;

  users.users.joe = {
    name = "joe";
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."users/joe/password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAduLznqkN0rvDysKrE2FQLegyeRzWyVu1Z71VPs2N7y joe@nixos"
    ];
    inherit extraGroups;

    shell = pkgs.zsh;
  };
}
