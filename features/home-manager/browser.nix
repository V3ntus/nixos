{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
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
