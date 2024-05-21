{pkgs, ...}: {
  users.users = {
    root = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAduLznqkN0rvDysKrE2FQLegyeRzWyVu1Z71VPs2N7y"
      ];
    };
  };

  users.mutableUsers = false;
  nix.settings.trusted-users = ["ventus"];
}
