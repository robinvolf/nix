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
          capslock = "macro(leftmeta+space)";
        };
        shift = {
          pause = "pause";
        };
      };
    };

    # Thinkpady maji stejne id klavesnice, ja si tu remapnu
    # capslock na meta+space (cimz se meni rozlozeni klavesnice)
    # Na klávesnici na x1 noťasu má end na místě capslocku,
    # tak ho premapuju taky a shift+end bude normalni end
    keyboards."thinkpad" = {
      ids = [
        "0001:0001:70533846"
      ];
      settings = {
        main = {
          capslock = "macro(leftmeta+space)";
          end = "macro(leftmeta+space)";
        };
        shift = {
          end = "end";
        };
      };
    };

    # Cursed proste
    keyboards."capslock_zmena_rozlozeni" = {
      ids = [
        "*"
      ];
      settings = {
        main = {
          capslock = "macro(leftmeta+space)";
        };
      };
    };
  };
}
