{pkgs, ...}:{
  services.ollama = {
    enable = true;

    # Akcelerace pro NVIDIA grafické karty
    acceleration = "cuda";

    # Aby naslouchal i připojením, které jdou zvenku
    openFirewall = true;
    host = "0.0.0.0";

    # Optional: preload models, see https://ollama.com/library
    # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
  };
}
