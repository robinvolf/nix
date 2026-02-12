{ config, pkgs, inputs, ... }:{
  imports =
    [
      ./hardware.nix
      ./moduly/cli.nix # CLI utilitky
      ./moduly/robin.nix
      ./moduly/vm_test.nix
      ./moduly/gui_programy.nix
      ./moduly/keyd.nix
    ];

  # Nix konfigurace
  # Povolit nesvobodné balíčky kvůli Nvidii
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

  # Věci na hry
  environment.systemPackages = with pkgs; [
    lutris # Na gri
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


  # Načte proprietární ovladač nvidia pro Xorg a Wayland
  services.xserver.videoDrivers = ["nvidia"];
  # Zapne OpenGL
  hardware.graphics.enable = true;
  hardware.nvidia = {

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false; # Pro finegrained musí být zapnutý offload

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
