{pkgs, ...}:{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty-graphics # Fork alacritty s podporou grafických protokolů pro obrázky v terminálu
    zathuraPkgs.zathura_core # Prohlížeč PDFek (jen program)
    zathuraPkgs.zathura_pdf_mupdf # Plugin pro PDFka pro zathuru
    imv # Prohlížeč obrázků
    bibletime # Program na čtení Bible
    legcord # Discord klient
    freetube # Frontend pro YouTube
    signal-desktop # Kecátko
    rnote # Kreslení, poznámky
    mpv # Přehrávání videí
    mpvScripts.quality-menu # Výběr kvality pro youtube videa přes mpv
    wf-recorder # Jednoduché CLI nahrávání obrazovky
  ];
}
