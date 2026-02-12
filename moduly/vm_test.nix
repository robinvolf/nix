# Pokud testujeme danou konfiguraci ve virtuálce pomocí
# nix build -v .#nixosConfigurations.t14-laptop.config.system.build.vm
# tak alokujeme té virtuálce 4 jádra a 4GB ramky

{...}:{
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4; # Výchozí 1 jádro je nepoužitelné pro moderní systém
      memorySize = 4096; # MiB RAM
    };
  };
}
