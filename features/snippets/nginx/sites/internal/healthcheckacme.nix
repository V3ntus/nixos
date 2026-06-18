{...}: {
  useACMEHost = "healthcheckacme.gladiusso.com";
  locations."/" = {
    extraConfig = ''
      add_header Content-Type text/plain;
      return 200 'healthy';
    '';
  };
}
