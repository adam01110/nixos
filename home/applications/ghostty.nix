{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;

    settings = {
      # font settings
      font-feature = "-calt, -liga, -dlig";
      freetype-load-flags = "hinting";

      # cursor settings
      cursor-style = "block";
      cursor-style-blink = true;

      shell-integration = "none";

      # appearance settings
      title = "ghostty";
      background-blur = true;
      window-theme = "system";
      window-decoration = "none";
      gtk-titlebar = false;
      window-padding-x = 2;
      window-padding-y = 2;
      resize-overlay = "never";

      copy-on-select = false;
      auto-update = "off";
      confirm-close-surface = false;

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
