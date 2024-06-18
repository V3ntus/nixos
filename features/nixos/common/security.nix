{
  users.mutableUsers = true;

  programs.ssh.startAgent = true; 

  security.pam.services = {
    hyprlock = {};
  };
}
