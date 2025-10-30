{ config, pkgs, inputs, ... }:

{
  # HW konfigurace
  imports = [
    ./hardware/esta-laptop.nix
    ./moduly/cli.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.tmp.useTmpfs = true;

  # Síť
  networking.hostName = "esta-laptop";
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

  # Normální uživatel
  users.users.ester = {
    isNormalUser = true;
    description = "Ester";
    extraGroups = [
      "networkmanager"
    ];
    hashedPassword = "$y$j9T$1c/f6Y89tKzS0lI80T/KX.$Qm1IcLjOyhEZ2DyXO5SNedGd.Lq7Eo5eZEEHo.INNo.";
  };

  # Celosystémové balíčky
  environment.systemPackages = with pkgs; [
    firefox # Browser    
    vlc # Na přehrávání médií

    libreoffice # Na editování wordů, prezentací, ...
    hunspell # Pro kontrolu pravopisu v libreoffice spolu se slovníky příslušných jazyků
    hunspellDicts.cs_CZ
    hunspellDicts.en_GB-ise

    nvtopPackages.intel  # Monitorování GPU (Intel)
  ];

  # Dané desktopové prostředí
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Zapne autologin, aby nemusela zadávat heslo
  services.displayManager.autoLogin = {
    enable = true;
    user = "ester";
  };

  # Aby se při zapínání nezobrazovalo tty, ale rovnou desktopové prostředí
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser
    totem # video player
  ]);

  environment.variables = {
    GSK_RENDERER = "ngl"; # Jinak Gnome aplikace *umřou*
  };

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ### Věci na údržbu ###
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
  };

  # SSH a Avahi, abych se mohl připojovat na počítač pro údržbu
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
    # Nebudeme pokoušet, nepůjde se přihlásit přes heslo
    settings.PasswordAuthentication = false;
  };
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
