{
  # TODO: this opens the exporter on ALL interfaces. This is unsafe if not used correctly
  networking.firewall.allowedTCPPorts = [
    9000
  ];

  services.prometheus.exporters.node = {
    enable = true;
    port = 9000;
    enabledCollectors = [
      "cpu"
      "cpufreq"
      "ethtool"
      "diskstats"
      "filesystem"
      "loadavg"
      "meminfo"
      "netclass"
      "netdev"
      "netstat"
      "os"
      "selinux"
      "stat"
      "time"
      "uname"
      "logind"
      "systemd"
    ];
  };
}
