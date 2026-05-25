{ config, pkgs, inputs, ... }:{
  imports =
    [
      ./hardware/bazina.nix
      ./moduly/cli.nix # CLI utilitky
      ./moduly/robin.nix
      ./moduly/vm_test.nix
      ./moduly/gui_programy.nix
      ./moduly/keyd.nix
      ./moduly/braille.nix
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

  # Pro updaty, za roota se můžu přihlásit daným klíčem
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIQYzKYSgupG/+DqyyuckdvyiXHE18hHdYI8PsI2Mq/l3IurBsDEkifkHRdDEBW35fIclxfPzuIjrNVh2YnFBFA= robin@t14-laptop"
    ];
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
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
    nvtopPackages.nvidia # GPU Monitoring
    whisper-cpp-vulkan # Přepis řeč na text
    fuzzel # Defaultní launcher v niri
    xwayland-satellite # Pro niri 
  ];

  # rtkit (volitelný, doporučený) umožňuje Pipewire používat sheduling v reálném čase pro zvýšení výkonu
  security.rtkit.enable = true;
  services.pipewire.pulse.enable = true; # Sunshine potřebuje pulse-audio

  # Aktuálně je openldap rozbitý, toto je hotfix
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];

  programs.niri.enable = true; # Kompozitor
  security.polkit.enable = true; # Niri není DE, takže musíme separátně nastavit
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true; 
      user = "robin";
    };
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    # Aby fungovalo HW enkódování pomocí NVENC
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
  };
  hardware.uinput.enable = true; # Vytváření virtuální klávesnice

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
