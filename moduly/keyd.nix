{...}:{
  # Keyd, démon modifikace vstupu na úrovni kernelu
  services.keyd = {
    enable = true;  

    # Matchne to ID tátovy klávesnice
    # Normálně je klávesa Pause zaměněna za →
    # Pokud je stisknuto Shift+Pause, udělá to pouze Pause
    keyboards."tatova_klavesnice" = {
      ids = [
        "258a:001f:fcfe2b1f"
        "258a:001f:ab99cdb6 "
        "258a:001f:92611046"
      ];
      settings = {
        main = {
          pause = "right";
        };
        shift = {
          pause = "pause";
        };
      };
    };
  };
}
