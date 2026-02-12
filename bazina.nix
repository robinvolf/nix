{ config, pkgs, inputs, ... }:{
  imports =
    [
      # ./hardware.nix
      ./moduly/cli.nix # CLI utilitky
      ./moduly/robin.nix
      ./moduly/vm_test.nix
    ];

  # Nix konfigurace
  # Povolit nesvobodné balíčky
  nixpkgs.config.allowUnfree = true;
  # Povolit funkci Flakes a nové rozhraní CLI nástroje nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.tmp.useTmpfs = true;

  # Síť
  networking.networkmanager.enable = true;
  networking.hostName = "bazina";

  # Set your time zone.
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

  environment.variables.EDITOR = "hx";

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Avahi
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    lutris # Na gri
    alacritty-graphics # Terminálový emulátor
    inputs.prismlauncher.packages."x86_64-linux".prismlauncher # Cracknutý minecraft launcher
  ];

  # Desktopové prostředí
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-store
    cosmic-reader
    cosmic-player
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
