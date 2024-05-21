{
  programs.dconf.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.sddm = {
    enable = true;
  };

  services.libinput = {
    enable = true;
    naturalScrolling = true;
    middleEmulation = false;
    tapping = true;
  };
}
