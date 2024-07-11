{
  programs.ssh.startAgent = true;

  services.openssh.settings.PermitRootLogin = "yes";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1hJBN8Urub5StYxhnxIB6+QVrx9T+4704Uam7HHEWC nix@gladiusso.com"
  ];
}
