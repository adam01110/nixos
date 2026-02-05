_:
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
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5m";

      # Disable directory inherit.
      working-directory = "home";
      window-inherit-working-directory = false;

      # Unbind the splitting keybinds.
      keybind = [
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
      ];
    };
  };
}
