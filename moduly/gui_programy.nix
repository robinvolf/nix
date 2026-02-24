{pkgs, ...}:{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty-graphics # Fork alacritty s podporou grafických protokolů pro obrázky v terminálu
    zathura # Prohlížeč PDFek/EPUB/...
    imv # Prohlížeč obrázků
    bibletime # Program na čtení Bible
    legcord # Discord klient
    freetube # Frontend pro YouTube
    signal-desktop # Kecátko
    rnote # Kreslení, poznámky
    mpv # Přehrávání videí
    mpvScripts.quality-menu # Výběr kvality pro youtube videa přes mpv
    songrec # Shazam klient (poznávání skladby ze zvuku)
    libreoffice
    kooha # Nahrávání obrazovky
    wl-clipboard-rs # CLI ovládání clipboardu na Waylandu
  ];
}
