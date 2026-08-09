{pkgs, lib, ...}:{
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "steam" # Pro lutris
   "steam-unwrapped"
  ];

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

    # Papá moc času, raději koukat na filmy
    freetube # Frontend pro YouTube

    # Na Hry <3
    # Podle mě je lepší mít na hry oddělený management než pro normální systémové balíčky
    lutris

  ] ++ (with pkgs; [
    ( mpv.override { scripts = [
      mpvScripts.mpris # mpris integrace
      mpvScripts.quality-menu # Výběr kvality pro youtube videa přes mpv
    ]; } )
  ]);
  
}
