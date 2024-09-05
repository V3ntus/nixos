{ pkgs, config, ... }: {
  sops.secrets = {
    "users/root/password" = {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };
  };

  programs.zsh.enable = true;

  users.users.root = {
    name = "root";
    isSystemUser = true;
    hashedPasswordFile = config.sops.secrets."users/root/password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAduLznqkN0rvDysKrE2FQLegyeRzWyVu1Z71VPs2N7y root@nixos"
    ];
    shell = pkgs.zsh;
  };
}
