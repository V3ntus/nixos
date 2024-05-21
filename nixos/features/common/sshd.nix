{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
  security.pam.sshAgentAuth.enable = true;
}
