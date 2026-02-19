{ config, pkgs, inputs, ... }:{
  imports = [
    # Moje drahocenné CLI nástroje
    ./hardware.nix
    ./moduly/cli.nix
    ./moduly/robin.nix
    ./moduly/vm_test.nix
    ./moduly/gui_programy.nix
    ./moduly/keyd.nix
  ];

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Desktopové prostředí cosmic
  services.desktopManager.cosmic.enable = true;  
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-store
    cosmic-reader
    cosmic-player
  ];

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
  services.greetd = let
    greetMsg = "Chválu vzdejte Hospodinu, protože je dobrý";
  in {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --asterisks --time --greeting '${greetMsg}' --cmd '${pkgs.fish}/bin/fish'";
        user = "greeter";
      };
    };
  };

  services.logind.settings.Login.HandlePowerKey = "hibernate";
  services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";

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

  # Sice nejsu server, ale schopnost připojit se vzdáleně je velmi užitečná
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = false;
      AllowUsers = [ # Lze se připojit pouze jako uživatel robin
        "robin"  
      ];
      PasswordAuthentication = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
