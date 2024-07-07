{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.mangohud
  ];

  programs.gamescope = {
    capSysNice = true;
    enable = true;
    args = [
      "--hdr-enabled"
    ];
  };

  programs.steam = {
    gamescopeSession = {
      enable = true;
      args = [
        "--hdr-enabled"
      ];
    };
    enable = true;
  };
}
