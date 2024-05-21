{}: {
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    permitRootLogin = "no";

    security.pan.enableSSHAgentAuth = true;
  };
}
