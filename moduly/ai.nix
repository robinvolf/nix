{pkgs, ...}:{
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "128000"; # Pro agenty, potřebujou hodně velký kontext
      OLLAMA_KEEP_ALIVE = "30m"; # Modely budou načtené v paměti alespoň 15min po promptu
      OLLAMA_IGPU_ENABLE = "1"; # By-default má vypnutou podporu iGPU, tohle ji zapne
    };

    # Aby naslouchal i připojením, které jdou zvenku
    # openFirewall = true;

    # Optional: preload models, see https://ollama.com/library
    # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
  };

  environment.systemPackages = with pkgs; [
    aichat # Lepší rozhraní než ollama se spoustou dalších fičurek
    whisper-cpp # Transkript audio -> text
  ];
}
