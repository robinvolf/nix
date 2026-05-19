{pkgs, inputs, lib, ...}:{
  programs.firefox.enable = true;

  nixpkgs.config = {
    packageOverrides = pkgs: {
      factorio = pkgs.factorio.override {
        username = "Kamikatze_312";
        token = builtins.readFile ./factorio_token;
      };
    };

    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
     "factorio-alpha" # Má unfree licenci
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty-graphics # Fork alacritty s podporou grafických protokolů pro obrázky v terminálu
    zathura # Prohlížeč PDFek/EPUB/...
    imv # Prohlížeč obrázků
    bibletime # Program na čtení Bible
    legcord # Discord klient
    signal-desktop # Kecátko
    rnote # Kreslení, poznámky
    songrec # Shazam klient (poznávání skladby ze zvuku)
    libreoffice
    kooha # Nahrávání obrazovky
    wl-clipboard-rs # CLI ovládání clipboardu na Waylandu
    gimp # Editace obrázků
    libnotify # CLI Notifikace
    pwvucontrol # GUI pro mix zvuku
    musescore # Editor not
    freetube # Frontend pro YouTube

    # Hry <3
    openttd
    factorio
  ] ++ (with pkgs; [
    ( mpv.override { scripts = [
      mpvScripts.mpris # mpris integrace
      mpvScripts.quality-menu # Výběr kvality pro youtube videa přes mpv
    ]; } )
  ]);
  
}
