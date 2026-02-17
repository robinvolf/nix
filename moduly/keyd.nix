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

    # Na klávesnici na x1 noťasu má end na místě capslocku
    # takto se při stisknutí endu vytvoří stick meta + space,
    # což je často zkratka na změnu rozložení klávesnice.
    keyboards."x1_zmena_rozlozeni" = {
      ids = [
        "0001:0001:70533846"
      ];
      settings = {
        main = {
          end = "macro(leftmeta+space)";
        };
      };
    };
  };
}
