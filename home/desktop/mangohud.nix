_:
# configure MangoHud overlay.
{
  programs.mangohud = {
    enable = true;

    settings = {
      legacy_layout = false;
      fps = true;
      frame_timing = true;
      horizontal = true;
      horizontal_stretch = 0;
      position = "top-left";
    };
  };
}
