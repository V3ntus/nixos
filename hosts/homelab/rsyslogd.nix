{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      *.* @security.gladiusso.com:9001
    '';
  };
}
