{...}:{
  # Konfigurace bootloaderu a parametrů kernelu

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true; # /tmp bude uložené jen v RAMce
  boot.kernelParams = [
    "zswap.enabled=1" # umožňuje zswap
    "zswap.max_pool_percent=25" # maximální procento paměti RAM, které může zswap použít
    "zswap.shrinker_enabled=1" # zda proaktivně zmenšit fond při vysokém tlaku paměti
  ];
}
