# NixOS Configs

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