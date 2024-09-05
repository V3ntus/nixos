{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--password-store=gnome-libsecret"
    ];
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "enamippconapkdmgfgjchkhakpfinmaj" # DeArrow
      "hkgfoiooedgoejojocmhlaklaeopbecg" # Google's PiP
      "gebbhagfogifgggkldgodflihgfeippi" # RYD
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
