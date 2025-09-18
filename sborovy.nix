{ config, pkgs, inputs, ... }:

{
  # HW konfigurace
  imports = [
    ./hardware/sborovy.nix
    ./moduly/cli.nix # Chcu tam mít svoje CLI utilitky
  ];

  # /tmp bude opravdu tmpfs RAMce
  boot.tmp.useTmpfs = true;

  # Síť
  networking.hostName = "sborovy";
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
  users.users.prezenter = {
    isNormalUser = true;
    description = "Prezentér";
    extraGroups = [
      "networkmanager"
    ];
    hashedPassword = "$y$j9T$roKp49iXFTXqR0W4JENMn.$vrnVh19SU8F0oVpAa0BifOM6VTrm5hH0b8atC8WJ8C8";
  };

  # Dané desktopové prostředí
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Zapne autologin při zapnutí pod uživatelem prezetner
  services.displayManager.autoLogin = {
    enable = true;
    user = "prezenter";
  };

  # Aby se při zapínání nezobrazovalo tty, ale rovnou desktopové prostředí
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    epiphany # Browser, bude firefox >:(
    totem # Video přehrávač, bude vlc
    decibels # Přehrávač hudby
    gnome-connections # VNC klient
    simple-scan # Skenovač dokuemtnů
    snapshot # Kamera
  ]);

  environment.variables = {
    GSK_RENDERER = "ngl"; # Jinak se GNOME aplikace špatně renderují (mají prázdné bílé okna a vizuální artefakty)
  };

  # Zapne flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ### Věci na údržbu ###
  # Povolíme připojení přes SSH pro uživatele root, abych se mohl na počítač vzdáleně připojit
  # a měnit /etc/nixos
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "without-password";
  };

  # Abych našel počítač přes mDNS (nemusím pak ssh root@192.168.xxx.xxx ale ssh root@sborovy.local)
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  # bruh = builtins.trace inputs.ekkles.packages inputs.ekkles.packages;
  environment.systemPackages = [
    pkgs.firefox # Browser    
    pkgs.vlc # Na přehrávání médií
    inputs.ekkles.packages."x86_64-linux".ekkles # GUI Ekklesu
    inputs.ekkles.packages."x86_64-linux".ekkles-cli # Pro import do databáze
  ];

  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
