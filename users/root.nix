{
  pkgs,
  config,
  ...
}: {
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
    shell = pkgs.zsh;
  };
}
