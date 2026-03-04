{config, ...}:
# Configure ghostty settings.
{
  programs.ghostty = {
    enable = true;

    settings = {
      # Font settings.
      font-feature = "-calt, -liga, -dlig";
      freetype-load-flags = "hinting";

      # Cursor settings.
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor,ssh-terminfo,ssh-env";

      # Appearance settings.
      window-theme = "system";
      window-decoration = "none";
      gtk-titlebar = false;
      window-padding-x = 2;
      window-padding-y = 2;
      resize-overlay = "never";

      # Misc settings.
      copy-on-select = false;
      auto-update = "off";
      confirm-close-surface = false;
      right-click-action = "ignore";

      # Improve startup time.
      quit-after-last-window-closed = false;
      gtk-single-instance = true;

      # Disable directory inherit.
      working-directory = "home";
      window-inherit-working-directory = false;

      # Enable cursor shader animation.
      custom-shader = "${config.xdg.configHome}/ghostty/cursor.glsl";
      custom-shader-animation = true;

      # Unbind the splitting keybinds.
      keybind = [
        "ctrl+enter=unbind"
        "ctrl+shift+enter=unbind"
        "ctrl+shift+e=unbind"
        "ctrl+shift+0=unbind"
        "ctrl+shift+q=unbind"
        "super+ctrl+equal=unbind"
        "super+alt+right=unbind"
        "super+d=unbind"
        "super+ctrl+down=unbind"
        "super+ctrl+left=unbind"
        "super+ctrl+up=unbind"
        "super+shift+enter=unbind"
        "super+alt+down=unbind"
        "super+ctrl+right=unbind"
        "super+alt+left=unbind"
        "super+alt+up=unbind"
        "super+left_bracket=unbind"
        "super+right_bracket=unbind"
        "super+shift+d=unbind"
        "alt+f4=unbind"
      ];
    };
  };

  # Put the shader file into the ghostty config dir.
  xdg.configFile."ghostty/cursor.glsl".source = ./cursor.glsl;
}
