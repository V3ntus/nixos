{virtualHosts, ...}: {
  acceptTerms = true;
  defaults = {
    email = "joe@gladiusso.com";
    server = "https://ca.gladiusso.com/acme/acme/directory";
  };
  certs."healthcheckacme.gladiusso.com" = {
    group = "nginx";
    extraDomainNames = builtins.attrNames virtualHosts;
    webroot = "/var/lib/acme/acme-challenge";
  };
}
