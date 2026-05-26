{...}:{
  # Avahi
  services.avahi = {
    enable = true;

    # Zapne DNS rezoluci .local domén přes avahi
    # Přes IPv6 to nezapínám protože spousta služeb (tiskárna) jede jen na IPv4 a při timeoutu to hlásí, že tiskárna je nedostupná
    nssmdns4 = true;

    # Co všechno o sobě rozhlašovat
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
