# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./bazina-hardware.nix
      ./../modules/cli.nix # CLI utilitky
      ./../modules/ollama.nix # Lokální LLMka
      # Nefunguje :( sice se připojím a mám obraz, ale okno na wotko se nespustí ./../modules/sunshine.nix # Lokálni cloud gaming
    ];

  # Zálohy
  users.users.backup = {
    # Bez hesla, nedá se přihlásit heslem
    isSystemUser = true; # Systémový uživatel, bude mít UID < 1000
    createHome = true;
    home = "/home/backup";
    description = "Účet pro zálohu dat";
    group = "backup";
    shell = pkgs.bashNonInteractive;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
  };
  # Vytvoří skupinu backup pro uživatele na zálohy a pro mě
  users.groups.backup.members = [
    "backup"
    "robin"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.tmp.useTmpfs = true;

  networking.hostName = "bazina";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robin = {
    isNormalUser = true;
    description = "robin";
    extraGroups = [
      "networkmanager"
      "wheel" 
    ];
    hashedPassword = "$y$j9T$VfrRv.6AUivaF9xP/TQw4.$KkFRQaU0ghRlMG0O5a4FbQsv1StsvDTufMwNl4gXl31";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Celosystémové balíčky
  environment.systemPackages = with pkgs; [
    avahi
    ffmpeg
  ];

  environment.variables.EDITOR = "hx";

  # SSH
  services.openssh.enable = true;

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
