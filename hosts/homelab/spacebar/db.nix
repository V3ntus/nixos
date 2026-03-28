{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    ensureDatabases = ["spacebar"];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
    '';
  };
}
