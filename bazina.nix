# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./moduly/cli.nix # CLI utilitky
    ];

  # Když použijeme tuto konfiguraci ve virtuálce
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4; # Výchozí 1 jádro je nepoužitelné pro moderní systém
      memorySize = 4096; # 4096 MiB RAM
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.tmp.useTmpfs = true;

  networking.hostName = "bazina";

  # Enable networking
  networking.networkmanager.enable = true;

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

  users.users.robin = {
    isNormalUser = true;
    description = "robin";
    extraGroups = [
      "networkmanager"
      "wheel" 
    ];
    hashedPassword = "$y$j9T$VfrRv.6AUivaF9xP/TQw4.$KkFRQaU0ghRlMG0O5a4FbQsv1StsvDTufMwNl4gXl31";
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    # nssmdns4 = true;
    # nssmdns6 = true;
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
