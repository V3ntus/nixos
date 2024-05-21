{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  extraGroups =
    [
      "wheel"
    ]
    ++ ifTheyExist [
      "docker"
      "git"
      "libvirtd"
      "network"
      "networkmanager"
      "plugdev"
    ];
in {
  users.users = {
    ventus = {
      inherit extraGroups;

      description = "Ventus";
      isNormalUser = true;

      home = "/home/ventus";

      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAduLznqkN0rvDysKrE2FQLegyeRzWyVu1Z71VPs2N7y"
      ];
    };
  };
}
