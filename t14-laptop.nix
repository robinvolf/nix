{ config, pkgs, inputs, ... }:{
  imports = [
    # Moje drahocenné CLI nástroje
    ./moduly/cli.nix
    ./moduly/robin.nix
    ./moduly/vm_test.nix
    ./moduly/gui_programy.nix
  ];

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --asterisks --time --greeting "" --cmd ${pkgs.fish}";
        user = "greeter";
      };
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
