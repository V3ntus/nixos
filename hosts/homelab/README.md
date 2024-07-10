# Homelab Configuration

## Hardware

- **Host**: Dell PowerEdge T400
- **CPU**: Intel Xeon Silver 4110 (32) x2
- **GPU**: NVIDIA Tesla P40
- **RAM**: (4x 32GB) 128GB DDR4 Registered, ECC, Buffered, 2400MHz
- **Remote**: iDRAC 9 Enterprise

## Services
### Containers
> Docker instance hosting multiple services.
- [Portainer](http://192.168.2.6:9000/)
- [PiHole](http://192.168.2.6/admin)
- [Grafana](http://192.168.2.6:3000/)
- [InfluxDB](http://192.168.2.6:8086/)
- [Prometheus](http://192.168.2.6:9090/)
- [flaresolverr](http://192.168.2.6:8191/)
- [Homepage](http://192.168.2.6:3001/)

- [Nginx Proxy Manager](http://192.168.2.13:81)

- [Jellyfin](http://192.168.2.5:8096/)
- [Prowlarr](http://192.168.2.5:9696/)
- [Radarr](http://192.168.2.5:7878/)
- [Sonarr](http://192.168.2.5:8989/)
- [Transmission](http://192.168.2.5:9091/)

### VM's
> Whole virtual machines serving large purposes.
- [TrueNAS](http://192.168.2.4/)
- [Wazuh](https://192.168.2.11/)
- [AI (Ollama, Stable Diffusion)](http://192.168.2.12:8081/)