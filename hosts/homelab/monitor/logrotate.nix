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
        rotate = 0;
        maxsize = "20G";
        missingok = true;
        notifempty = true;
        create = "0600 root root";
        postrotate = "systemctl reload rsyslog";
      };
    };
  };
}
