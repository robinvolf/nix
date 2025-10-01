# Celé je podle tady tohoto setupu:
# https://docs.lizardbyte.dev/projects/sunshine/v0.23.0/about/guides/linux/headless_ssh.html#virtual-display-setup
# Ale docela dost modifikované xdd

{pkgs, lib, ...}:{
  services.openssh.settings.UsePAM = false;

  # Tady jde deklarativně nastavit i ten sunshine, ale vzhledem k tomu, jak to pouštím
  # random skriptem, je jednodušši to nastavovat manuálně přes webové rozhraní (https://bazina.local:47990)
  # Dají se tam nastavit různé kodeky, ale nejdůležitější jsou různé appky, které se pak dají spouštět
  #
  # Důležité: Nastav hook, který před každým spuštěním aplikace spustí `xhost +`, aby se to připojilo k Xkám
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    # Enable nvenc support
    package = pkgs.sunshine.override {
      cudaSupport = true;
    };
  };


  #X-ka
  services.xserver = {
    enable = true;
    autorun = false;
    layout = "us";
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    # displayManager.startx.enable = true;
    # X.org funguje tak, že vezme první dostupný ServerLayout. NixOS si nageneruje vlastní,
    # ale my ho přebijeme pomocí DefaultServerLayout
    extraConfig = ''
      Section "ServerFlags"
        DefaultServerLayout "SunshineLayout"
      EndSection

      Section "ServerLayout"
        Identifier "SunshineLayout"
        Screen 0 "metaScreen" 0 0
      EndSection

      Section "Monitor"
          Identifier "Monitor0"
          Option "Enable" "true"
      EndSection

      Section "Device"
          Identifier "Card0"
          Driver "nvidia"
          VendorName "NVIDIA Corporation"
          Option "MetaModes" "1920x1080"
          Option "ConnectedMonitor" "HDMI-0"
          Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoVertRefreshCheck,NoWidthAlignmentCheck"
      EndSection

      Section "Screen"
          Identifier "metaScreen"
          Device "Card0"
          Monitor "Monitor0"
          DefaultDepth 24
          Option "TwinView" "True"
          SubSection "Display"
              Depth 24
              Virtual 1920 1080
          EndSubSection
      EndSection
    '';
  };

  environment.systemPackages = with pkgs; [
    lutris      # Aby bylo, co hrát :)
    xorg.xhost  # Aby se daly dávat permissions pro připojení k X displeji
    xorg.xrandr # Debugování X-ek
    wineWowPackages.full # Wine
  ];
}

