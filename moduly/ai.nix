{pkgs, ...}:{
  services.ollama = {
    enable = true;

    # Aby naslouchal i připojením, které jdou zvenku
    # openFirewall = true;
    # host = "0.0.0.0";

    # Optional: preload models, see https://ollama.com/library
    # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
  };

  environment.systemPackages = with pkgs; [
    aichat # Lepší rozhraní než ollama se spoustou dalších fičurek
    whisper-cpp # Transkript audio -> text
  ];
}
