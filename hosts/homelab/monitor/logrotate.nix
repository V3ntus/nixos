{
  services.logrotate = {
    enable = true;
    checkConfig = false;
    settings = {
      header = {
        dateext = true;
      };
      "/var/log/messages" = {
        frequency = "daily";
        rotate = 7;
        compress = true;
        missingok = true;
        notifempty = true;
        create = "0600 root root";
        postrotate = "systemctl reload rsyslog";
      };
    };
  };
}
