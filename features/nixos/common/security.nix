{
  users.mutableUsers = true;

  programs.ssh.startAgent = true;

  security.pam.services = {hyprlock = {};};

  security.pki.certificates = [
    ''
      CS30 Root CA
      =========
      -----BEGIN CERTIFICATE-----
      MIIBjjCCATWgAwIBAgIQXBqd86r1ah+/GwIlvbOoFDAKBggqhkjOPQQDAjAmMQ0w\nCwYDVQQKEwRDUzMwMRUwEwYDVQQDEwxDUzMwIFJvb3QgQ0EwHhcNMjUwMzA2MTgy\nOTA2WhcNMzUwMzA0MTgyOTA2WjAmMQ0wCwYDVQQKEwRDUzMwMRUwEwYDVQQDEwxD\nUzMwIFJvb3QgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAARazvF58f0yORZN\n+h2GxOBryvMrVTBQwHTbD7b9jgYHcivAFI7fh6qr0y/OQ+FXirIGTcXBWCkkx3dA\nXlIDpGRfo0UwQzAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBATAd\nBgNVHQ4EFgQUB39IdWEdAiDJtv4hnB5KMyL+cbgwCgYIKoZIzj0EAwIDRwAwRAIg\nCyuSsit6gEuBJ+4XuExf54o3M0PqjZEIEKxXQMUFt/sCIGUTdLR+bEGOhi2qMIWS\nDfTza6xBAQibV+1Dii8UMtq3
      -----END CERTIFICATE-----
    ''
  ];
}
