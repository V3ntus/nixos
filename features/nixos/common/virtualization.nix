{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
      qemu = { options = [ "-device virtio-vga-gl" "-display sdl,gl=on" ]; };
    };
  };
}
