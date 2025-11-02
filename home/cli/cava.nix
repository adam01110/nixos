{ ... }:

{
  programs.cava = {
    enable = true;

    settings = {
      general = {
        bar_width = 1;
        bar_spacing = 2;
      };

      input = {
        method = "pipewire";
        source = "auto";
      };

      output.method = "ncurses";

      smoothing = {
        monstercat = 1;
        noise_reduction = 33;
      };
    };
  };
}
