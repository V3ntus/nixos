# NixOS Configs
![image](https://github.com/V3ntus/nixos/assets/29584664/73c56423-7a90-4565-bd47-219a4a7982ed)
![image](https://github.com/V3ntus/nixos/assets/29584664/e2580fc9-7c6b-483e-bd1d-e8c8dc65e887)



## Usage

To build a system, run:

```
# nixos-rebuild switch --flake <path to repo>#<hostname>
```

Example:

```
# nixos-rebuild switch --flake /home/joe/repos/nixos_configs#joe-work
```

### Debugging

```
# nixos-rebuild test --flake .#<hostname> --show-trace --option eval-cache false
```
