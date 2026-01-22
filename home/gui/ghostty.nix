_:
# configure ghostty settings.
{
  programs.ghostty = {
    enable = true;

    settings = {
      # font settings.
      font-feature = "-calt, -liga, -dlig";
      freetype-load-flags = "hinting";

      # cursor settings.
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor,ssh-terminfo,ssh-env";

      # appearance settings.
      window-theme = "system";
      window-decoration = "none";
      gtk-titlebar = false;
      window-padding-x = 2;
      window-padding-y = 2;
      resize-overlay = "never";

      # misc settings.
      copy-on-select = false;
      auto-update = "off";
      confirm-close-surface = false;
      right-click-action = "ignore";

      # improve startup time.
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5m";

      # disable directory inherit.
      working-directory = "home";
      window-inherit-working-directory = false;

      # unbind the splitting keybinds.
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
