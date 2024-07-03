{
    services.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
  };

  services.open-webui = {
    enable = true;
    port = 8081;
    host = "0.0.0.0";
    # environment = {
    #  GLOBAL_LOG_LEVEL = "DEBUG";
    #  MAIN_LOG_LEVEL = "DEBUG";
    #  RAG_LOG_LEVEL = "DEBUG";
    # };
  };

  systemd.services.open-webui = {
    unitConfig = {
      StartLimitIntervalSec = 30;
      StartLimitBurst = 3;
    };
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  services.searx = {
    enable = true;
    settings = {
      use_default_settings = true;
      server = {
        port = 8082;
        bind_address = "0.0.0.0";
        secret_key = "super_secret";
        limiter = false;
        image_proxy = true;
      };
      ui = {
        static_use_hash = true;
      };
      search = {
        safe_search = 0;
        autocomplete = "";
        default_lang = "";
        formats = [
          "html"
          "json"
        ];
      };
    };
  };
}