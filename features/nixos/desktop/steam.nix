{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.mangohud
  ];

  programs.gamescope = {
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
