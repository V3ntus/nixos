{lib, ...}: {
  users.mutableUsers = lib.mkDefault true;

  programs.ssh.startAgent = lib.mkDefault true;

  security.pam.services = lib.mkDefault {hyprlock = {};};

  security.pki.certificates = [
    ''
-----BEGIN CERTIFICATE-----
MIIBjjCCATWgAwIBAgIQXBqd86r1ah+/GwIlvbOoFDAKBggqhkjOPQQDAjAmMQ0w
CwYDVQQKEwRDUzMwMRUwEwYDVQQDEwxDUzMwIFJvb3QgQ0EwHhcNMjUwMzA2MTgy
OTA2WhcNMzUwMzA0MTgyOTA2WjAmMQ0wCwYDVQQKEwRDUzMwMRUwEwYDVQQDEwxD
UzMwIFJvb3QgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAARazvF58f0yORZN
+h2GxOBryvMrVTBQwHTbD7b9jgYHcivAFI7fh6qr0y/OQ+FXirIGTcXBWCkkx3dA
XlIDpGRfo0UwQzAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBATAd
BgNVHQ4EFgQUB39IdWEdAiDJtv4hnB5KMyL+cbgwCgYIKoZIzj0EAwIDRwAwRAIg
CyuSsit6gEuBJ+4XuExf54o3M0PqjZEIEKxXQMUFt/sCIGUTdLR+bEGOhi2qMIWS
DfTza6xBAQibV+1Dii8UMtq3
-----END CERTIFICATE-----
    ''
  ];
}
