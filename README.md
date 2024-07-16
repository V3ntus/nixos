<p align="center">
  <img src="https://github.com/NixOS/nixos-artwork/blob/master/logo/nixos-white.png?raw=true" />
</p>

<h1 align="center">NixOS Configs</h1>

<p align="center">Personal NixOS configurations for multiple devices and <a href="./hosts/homelab/README.md">homelab</a>.</p>

![image](https://github.com/V3ntus/nixos/assets/29584664/73c56423-7a90-4565-bd47-219a4a7982ed)  
<p align="center">Hyprland + Gruvbox</p>

![image](https://github.com/V3ntus/nixos/assets/29584664/733808e0-9e3a-463f-823c-1a6bbc362d3f)  
<p align="center">Nixvim</p>

![image](https://github.com/V3ntus/nixos/assets/29584664/e2580fc9-7c6b-483e-bd1d-e8c8dc65e887)  
<p align="center">Kitty + Gruvbox</p>

![image](https://github.com/V3ntus/nixos/assets/29584664/78f03d92-5ecb-4d3d-b75d-e440c4accfd1)  
<p align="center">Niri</p>

## Features

- Zen kernel
- Hyprland/Niri + Waybar config
- Kitty + Oh-my-zsh + starship
- Gruvbox theming
- Autorotating wallpaper using swww

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
$ nix flake check
# # or
# nixos-rebuild test --flake .#<hostname> --show-trace --option eval-cache false
```

Or to build a VM:

```
$ nixos-rebuild build-vm --flake .#<hostname>
$ QEMU_OPTS="-serial mon:stdio" QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm
```
