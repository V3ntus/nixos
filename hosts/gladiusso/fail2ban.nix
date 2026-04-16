{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      fail2ban
    ];

    etc = {
      "fail2ban/filter.d/nginx-badbots.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
        [Definition]
        failregex = ^<HOST> -.*"(GET|POST).*HTTP.*"(curl|(W|w)get|scrapy|bot|Go-http-client)
        ignoreregex =
      '');
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "192.168.2.0/24"
    ];
    bantime = "1h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
    jails = {
      nginx-sslerror.settings = {
        enabled = true;
      };
      nginx-badbots.settings = {
        enabled = true;
        filter = "nginx-badbots";
        logpath = "/var/log/nginx/access.log";
        findtime = 600;
        backend = "auto";
      };
    };
  };
}
