{
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "yes";

  home.file.".config/environment.d/ssh-agent.conf".text = ''
    SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent
  '';
}
