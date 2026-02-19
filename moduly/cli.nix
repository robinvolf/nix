# Všechny CLI utilitky, které používám

{pkgs, ...}:
let 
  # Základ
  programs.git.enable = true; # Git
  programs.fish.enable = true; # Můj oblíbený shell
  basic = with pkgs; [
    helix # Textový editor
    zellij # Terminálový multiplexor + integrovaný "screen"
  ];

  # Náhrady klasických příkazů
  programs.zoxide.enable = true; # Lepší cd
  programs.bat.enable = true; # Lepší cat
  classicSubstitutes = with pkgs; [
    eza # Lepší ls
    dust # Lepší du
    rip2 # Lepší rm
    delta # Lepší diff
    ripgrep-all # Lepší grep, který umí hledat i v netextových souborech (pdf, docx, sqlite, ...)
    bottom # Lepší (h)top
    fd # Lepší find
  ];

  # Internet
  programs.openvpn3.enable = true;       # Pro VPNku
  internet = with pkgs; [
    pkgs.curl # CLI stahovač z internetu
    pkgs.yt-dlp        # Stahovač YT videí
    pkgs.speedtest-cli # Klient pro měření rychlosti internetového připojení
    pkgs.rsync         # Přenos souborů
    pkgs.bandwhich     # Vypíše využití sítě podle adres/procesů
  ];

  # Hardware
  hardware = with pkgs; [
    smartmontools         # Nástroje pro S.M.A.R.T monitoring disků
    hwinfo                # Řekne info o HW
    android-file-transfer # MTP souborový systém pro přenášení souborů z/do android telefonu
    dmidecode             # Umí dekódovat, jaký má počítač HW podle SMBIOS/DMI standartu
  ];

  # Manuálové stránky
  documentation = {
    nixos.enable = true; # Zahrne manuálové stránky pro NixOS
    dev.enable = true; # Zahrne manuálové stránky pro vývoj
    man = {
      enable = true;
      generateCaches = true; # Kešuje indexaci manuálových stránek, aby se v ní dalo hledat
    };
  };
  manuals = [pkgs.tealdeer]; # Výcuc manuálových stránek

  # Utilitky
  programs.skim.enable = true;                 # Fuzzy finder
  utilities = with pkgs; [
    file                 # Co je to za typ souboru?
    ouch                 # Utilitka pro práci s archivy a kompresí (tar, zip, ...)
    fend                 # Kalkulačka
    openssh              # Pro klientské SSH nástroje
    sshfs                # Souborový systém přes ssh
    taskwarrior3         # Seznam pro TODOčka
    just                 # Takový jednoduchý command runner, lepší než kopa shell skriptů
    which                # Řekne umístění spustitelného souboru
    watchexec            # Spouští příkazy při modifikaci souboru
    lsof                 # Vypíše otevřené soubory
    tokei                # Spočítá řádky kódu
    ffmpeg-headless      # Audio-video manipulace
    translate-shell      # CLI překladač
    typst                # Sázecí nástroj, nástupce Latexu
    tinymist             # LSP server pro typst
  ];
in {
  inherit programs;
  environment.systemPackages = basic ++ classicSubstitutes ++ internet ++ hardware ++ manuals ++ utilities;

  console.font = "LatArCyrHeb-16";

  environment.variables = {
    EDITOR = "hx";
  };
}
