{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  extraGroups =
    [
      "audio"
      "video"
      "wheel"
    ]
    ++ ifTheyExist [
      "network"
      "networkmanager"
      "plugdev"
      "docker"
    ];
in {
  sops.secrets = {
    "users/ventus/password" = {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };
  };

  users.users.ventus = {
    isNormalUser = true;
    initialPassword = "password";
    passwordFile = config.sops.secrets."users/ventus/password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAduLznqkN0rvDysKrE2FQLegyeRzWyVu1Z71VPs2N7y ventus@nixos"
    ];
    inherit extraGroups;

    shell = pkgs.zsh;
  };
}
