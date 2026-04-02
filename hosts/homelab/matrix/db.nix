{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
    '';
    initialScript = pkgs.writeText "initial.sql" ''
      CREATE ROLE "matrix-synapse";
      ALTER ROLE "matrix-synapse" WITH LOGIN;
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
        TEMPLATE template0
        LC_COLLATE = "C"
        LC_CTYPE = "C";
    '';
  };
}
