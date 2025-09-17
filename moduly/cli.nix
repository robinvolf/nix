# Všechny CLI utilitky, které používám

{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    # Základ
    git    # Git!!!!
    fish   # Můj oblíbený shell
    helix  # Textový editor
    zellij # Terminálový multiplexor + integrovaný "screen"

    # Náhrady klasických příkazů
    eza     # Lepší ls
    dust    # Lepší du
    rip2    # Lepší rm
    zoxide  # Lepší cd
    delta   # Lepší diff
    bat     # Lepší cat
    ripgrep # Lepší grep
    bottom  # Lepší (h)top
    fd      # Lepší find

    # Internet
    curl          # CLI stahovač z internetu
    yt-dlp        # Stahovač YT videí
    speedtest-cli # Klient pro měření rychlosti internetového připojení
    openvpn       # Pro VPNku
    rsync         # Přenos souborů
    bandwhich     # Vypíše využití sítě podle adres/procesů

    # Hardware
    smartmontools         # Nástroje pro S.M.A.R.T monitoring disků
    hwinfo                # Řekne info o HW
    android-file-transfer # MTP souborový systém pro přenášení souborů z/do android telefonu
    dmidecode             # Umí dekódovat, jaký má počítač HW podle SMBIOS/DMI standartu

    # Manuály
    man      # Prohlížeč manuálových stránek
    manix    # Prohlížeč offline dokumentace Nixu
    tealdeer # Jednodušší "manuálové stránky"

    # Utilitky
    file                 # Co je to za typ souboru?
    ouch                 # Utilitka pro práci s archivy a kompresí (tar, zip, ...)
    fend                 # Kalkulačka
    sshfs                # Souborový systém přes ssh
    taskwarrior3         # Seznam pro TODOčka
    just                 # Takový jednoduchý command runner, lepší než kopa shell skriptů
    skim                 # Fuzzy finder
    which                # Řekne umístění spustitelného souboru
    watchexec            # Spouští příkazy při modifikaci souboru
    lsof                 # Vypíše otevřené soubory
    tokei                # Spočítá řádky kódu
    brightnessctl        # Ovládání jasu obrazovky
    ffmpeg               # Audio-video manipulace

    # Toto je velice HW specifické a obzvlášť nvidia, která si natáhne cuda package,
    # který je obrovský a dlouho se buildí
    # TODO: Nějak modularizovat (třá si vzít vstup a podle toho)
    
    # nvtopPackages.amd    # Monitorování GPU (AMD)
    # nvtopPackages.intel  # Monitorování GPU (Intel)
    # nvtopPackages.nvidia # Monitorování GPU (NVidia)
  ];  
}
