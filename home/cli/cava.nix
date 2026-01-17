_:
# configure cava audio visualizer.
{
  programs.cava = {
    enable = true;

    settings = {
      general = {
        bar_width = 1;
        bar_spacing = 2;
      };

      smoothing = {
        monstercat = 1;
        noise_reduction = 33;
      };

      input.method = "pulse";
    };
  };
}
