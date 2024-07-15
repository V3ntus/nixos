{modulesPath, ...}: {
  # Baseline configuration for initial remote deployment.
  # This is manually uploaded to a new host and switched to.
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ./hardware-configuration.nix  # make sure to run nixos-generate-config to get the hardware config
  ];

  system.stateVersion = "24.11";

  programs.git.enable = true;

  services.openssh.settings.PermitRootLogin = "yes";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1hJBN8Urub5StYxhnxIB6+QVrx9T+4704Uam7HHEWC joe@gladiusso.com"
  ];
}
