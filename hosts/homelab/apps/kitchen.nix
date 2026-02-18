{
  services.tandoor-recipes = {
    enable = true;
    address = "0.0.0.0";
    extraConfig = {
      MEDIA_ROOT = "/var/lib/tandoor-recipes/media";
    };
    port = 8001;
  };
}
