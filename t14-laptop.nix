{ config, pkgs, inputs, ... }:{
  imports = [
    # Moje drahocenné CLI nástroje
    ./hardware/t14-laptop.nix
    ./moduly/cli.nix
    ./moduly/robin.nix
    ./moduly/vm_test.nix
    ./moduly/gui_programy.nix
    ./moduly/keyd.nix
    ./moduly/ai.nix
    ./moduly/braille.nix
    ./moduly/tisk.nix
    inputs.dms-plugin-registry.modules.default
  ];

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Deduplikace souborů při každém build-u
  nix.settings.auto-optimise-store = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true; # /tmp bude uložené jen v RAMce
  boot.kernelParams = [
    "zswap.enabled=1" # enables zswap
    "zswap.max_pool_percent=25" # maximum percentage of RAM that zswap is allowed to use
    "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
  ];

  # Síť
  networking.hostName = "t14-laptop";
  networking.networkmanager.enable = true;

  # Internacionalizace
  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "cs_CZ.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Kompozitor
  programs.niri.enable = true;
  # Desktopový shell
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd služba pro automatické spouštění
      restartIfChanged = true;   # Automaticky restartovat službu dms.service, když se změní prostředí dms
    };
  
    enableSystemMonitoring = true;     # Widgety pro monitorování systému (dgop)
    enableDynamicTheming = true;       # Motivy založené na tapetách (matugen)
    enableClipboardPaste = true;       # Vkládání z historie schránky (wtype)

    enableVPN = false;                  # Widget pro správu VPN
    enableAudioWavelength = false;      # Audio vizualizér (cava)
    enableCalendarEvents = false;       # Integrace kalendáře (khal)

    plugins = {
      # Simply enable plugins by their ID (from the registry)
      dankBatteryAlerts.enable = true;
      amdGpuMonitor.enable = true;
    };
  };

  # Bez tohoto nefunguje na dms BT ani ukazatel nabití baterky
  hardware.bluetooth.enable = true;
  services.upower.enable = true;

  # Display Manager
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri"; # Required. Can be also "hyprland" or "sway"

    # Synchronizuje barvičky greeteru s dmskem
    configHome = "/home/robin";
  };

  # Avahi
  services.avahi = {
    enable = true;

    # Zapne DNS rezoluci .local domén přes avahi
    # Přes IPv6 to nezapínám protože spousta služeb (tiskárna) jede jen na IPv4 a při timeoutu to hlásí, že tiskárna je nedostupná
    nssmdns4 = true;

    # Co všechno o sobě rozhlašovat
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true; # Pro sdílení audia
    };
  };

  services.logind.settings.Login.HandlePowerKey = "hibernate";
  services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";

  # Override výchozího balíčku pro ollama, moje gpu podporuje Vulkan
  # Beru ho z nových nixpkgs, protože nové modely vyžadují novou verzi ollama
  services.ollama.package = pkgs.ollama-vulkan;

  environment.systemPackages = with pkgs; [
    moonlight-qt # Gamestreaming klient
    amdgpu_top # Pro dms plugin amdGpuMonitor
    xwayland-satellite # Pro niri, aby se mohly spouštět X11 programy
  ];

  environment.sessionVariables = {
    SDL_VIDEO_DRIVER = "wayland"; # Přinutí SDL programy, aby běžely na waylandu (např. openttd)
  };
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
