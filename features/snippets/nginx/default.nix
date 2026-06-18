{
  virtualHosts,
  recommendedProxySettings ? true,
  recommendedOptimisation ? true,
  recommendedTlsSettings ? true,
  appendHttpConfig ? "",
}: {
  enable = true;
  appendHttpConfig = ''
    ${appendHttpConfig}
  '';
  inherit virtualHosts recommendedTlsSettings recommendedOptimisation recommendedProxySettings;
}
