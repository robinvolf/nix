{ config, pkgs, inputs, ... }:

let
  guiPrograms = with pkgs; [
    alacritty-graphics # Fork alacritty s podporou grafických protokolů pro obrázky v terminálu
    zathuraPkgs.zathura_core # Prohlížeč PDFek (jen program)
    zathuraPkgs.zathura_pdf_mupdf # Plugin pro PDFka pro zathuru
    imv # Prohlížeč obrázků
    bibletime # Program na čtení Bible
    legcord # Discord klient
    rnote # Kreslení, poznámky
    mpv # Přehrávání videí
    mpvScripts.quality-menu # Výběr kvality pro youtube videa přes mpv
  ];
in
{
  imports = [
    # Moje drahocenné CLI nástroje
    ./moduly/cli.nix
  ];

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Když použijeme tuto konfiguraci ve virtuálce
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4; # Výchozí 1 jádro je nepoužitelné pro moderní systém
      memorySize = 4096; # 4096 MiB RAM
    };
    services.spice-vdagentd.enable = true; # Sdílení clipboardu
  };

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.tmp.useTmpfs = true;

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

  users.users.robin = {
    isNormalUser = true;
    description = "Robin";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$CXo6N5TREXTi.QLsqIJ8G/$JOIvMeKRSluiwlVGStmvTNsTNneO37bSQDFCt9cd8Z8";
    shell = pkgs.fish;
  };

  # Desktopové Prostředí
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl # Ovládání jasu obrazovky
      i3status-rust # Generátor obsahu statusové řádky
      dunst # Notifikace
      swaylock # Zámek obrazovky
      swayidle # Zamknutí po nečinnosti/při uspání
      sway-contrib.grimshot # Screenshoty
      wlsunset # Filtr modrého světla
      bemenu # Startovač aplikací
      wl-clipboard-rs # Pro clipboard
      cliphist # Historie clipboardu
      wev # Testování vstupu
    ];
  };

  # Audio
  security.rtkit.enable = true; # Umožňuje pipewire vyžádat si real-time scheduling prioritu
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };


  # GUI Programy
  programs.firefox.enable = true;

  environment.systemPackages = guiPrograms;

  services.avahi = {
    enable = true;
    # Zapne DNS rezoluci přes Avahi
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  # Tiskárny
  services.printing.enable = true;
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother-DCP-9020CDW";
        location = "Ve skříni";
        deviceUri = "dnssd://Brother%20DCP-9020CDW._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-30055c4d1724";
        model = "drv:///sample.drv/generic.ppd";
      }
    ];
    ensureDefaultPrinter = "Brother-DCP-9020CDW";
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
