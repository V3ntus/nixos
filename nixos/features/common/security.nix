{
  imports = [];

  # Yubikey support
  services.pcscd.enable = true;

  security.sudo.wheelNeedsPassword = false;

  security.rtkit.enable = true;
}
