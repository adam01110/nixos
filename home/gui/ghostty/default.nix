{config, ...}:
# Configure ghostty settings.
{
  programs.ghostty = {
    enable = true;

    # Add the cursor shader to to ghostty config.
    settings.custom-shader = "${config.xdg.configHome}/ghostty/cursor.glsl";
  };

  # Put the shader file into the ghostty config dir.
  xdg.configFile."ghostty/cursor.glsl".source = ./cursor.glsl;
}
