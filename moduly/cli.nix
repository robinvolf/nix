# Všechny CLI utilitky, které používám

{pkgs, ...}:{
  # Základ
  programs.git.enable = true;
  programs.fish.enable = true; # Můj oblíbený shell
  environment.systemPackages = [pkgs.helix]; # Textový editor
  environment.systemPackages = [pkgs.zellij]; # Terminálový multiplexor + integrovaný "screen"

  # Náhrady klasických příkazů
  environment.systemPackages = [pkgs.eza]; # Lepší ls
  environment.systemPackages = [pkgs.dust]; # Lepší du
  environment.systemPackages = [pkgs.rip2]; # Lepší rm
  programs.zoxide.enable = true;
  environment.systemPackages = [pkgs.delta]; # Lepší diff
  programs.bat.enable = true;
  environment.systemPackages = [pkgs.ripgrep-all]; # Lepší grep, který umí hledat i v netextových souborech (pdf, docx, sqlite, ...)
  environment.systemPackages = [pkgs.bottom]; # Lepší (h)top
  environment.systemPackages = [pkgs.fd]; # Lepší find

  
  # Internet
  environment.systemPackages = [pkgs.curl]; # CLI stahovač z internetu
  environment.systemPackages = [pkgs.yt-dlp];        # Stahovač YT videí
  environment.systemPackages = [pkgs.speedtest-cli]; # Klient pro měření rychlosti internetového připojení
  programs.openvpn3.enable = true;       # Pro VPNku
  environment.systemPackages = [pkgs.rsync];         # Přenos souborů
  environment.systemPackages = [pkgs.bandwhich];     # Vypíše využití sítě podle adres/procesů

  # Hardware
  environment.systemPackages = [pkgs.smartmontools];         # Nástroje pro S.M.A.R.T monitoring disků
  environment.systemPackages = [pkgs.hwinfo];                # Řekne info o HW
  environment.systemPackages = [pkgs.android-file-transfer]; # MTP souborový systém pro přenášení souborů z/do android telefonu
  environment.systemPackages = [pkgs.dmidecode];             # Umí dekódovat, jaký má počítač HW podle SMBIOS/DMI standartu

  # Manuálové stránky
  documentation = {
    nixos.enable = true; # Zahrne manuálové stránky pro NixOS
    dev.enable = true; # Zahrne manuálové stránky pro vývoj
    man = {
      enable = true
      generateCaches = true; # Kešuje indexaci manuálových stránek, aby se v ní dalo hledat
    };
  };
  environment.systemPackages = [pkgs.tealdeer]; # Výcuc manuálových stránek

  # Rozličné utilitky
  environment.systemPackages = [pkgs.file];                 # Co je to za typ souboru?
  environment.systemPackages = [pkgs.ouch];                 # Utilitka pro práci s archivy a kompresí (tar, zip, ...)
  environment.systemPackages = [pkgs.fend];                 # Kalkulačka
  environment.systemPackages = [pkgs.sshfs];                # Souborový systém přes ssh
  environment.systemPackages = [pkgs.taskwarrior3];         # Seznam pro TODOčka
  environment.systemPackages = [pkgs.just];                 # Takový jednoduchý command runner, lepší než kopa shell skriptů
  programs.skim.enable = true                 # Fuzzy finder
  environment.systemPackages = [pkgs.which];                # Řekne umístění spustitelného souboru
  environment.systemPackages = [pkgs.watchexec];            # Spouští příkazy při modifikaci souboru
  environment.systemPackages = [pkgs.lsof];                 # Vypíše otevřené soubory
  environment.systemPackages = [pkgs.tokei];                # Spočítá řádky kódu
  environment.systemPackages = [pkgs.ffmpeg-headless];               # Audio-video manipulace
}
