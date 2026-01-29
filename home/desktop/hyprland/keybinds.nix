{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:
# keybindings for hyprland including workspace, window, and media controls.
let
  inherit
    (lib)
    getExe
    getExe'
    mkEnableOption
    optionalString
    ;
  inherit (pkgs) callPackage;

  inherit (config.xdg) configHome;
in {
  options.hyprland.brightness.enable = mkEnableOption "Enable function-row (F-keys) for brightness keybindings.";

  # generate hyprland binding lists and helpers.
  config = {
    # allow focus cycling while a window is fullscreen.
    wayland.windowManager.hyprland.settings.binds.movefocus_cycles_fullscreen = true;

    # keep keybinds in a separate file for parsing tools.
    xdg.configFile."hypr/keybinds.conf".text = let
      gawk = getExe pkgs.gawk;
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";

      qs = getExe' config.programs.quickshell.package ".quickshell-wrapped";
      noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";

      performantMode = callPackage ./scripts/performant-mode.nix {inherit osConfig;};
      thunar = getExe pkgs.thunar;
      equibop = getExe config.programs.nixcord.equibop.package;
      ghostty = "${getExe config.programs.ghostty.package} +new-window";
      hyprpicker = getExe config.programs.hyprshot.package;
      hyprshot = getExe config.programs.hyprshot.package;
      steam = getExe osConfig.programs.steam.package;
      zen-browser = getExe inputs.zen-browser.packages."${system}".default;
      app2unit = "${getExe config.programs.noctalia-shell.app2unit.package} --";
      brightnessctl = getExe pkgs.brightnessctl;

      cfgBrightness = config.hyprland.brightness.enable;
      screenshotDir = "${config.xdg.userDirs.pictures}/screenshot";

      zoomIn = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')";
      zoomOut = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')";
    in
      ''
        # 1. Applications
        bind = SUPER, Return, exec, ${app2unit} ${ghostty} #"terminal"
        bind = SUPER, E, exec, ${app2unit} ${thunar} #"file manager"
        bind = SUPER, N, exec, ${app2unit} ${equibop} #"discord"
        bind = SUPER, B, exec, ${app2unit} ${zen-browser} #"browser"
        bind = SUPER, M, exec, ${app2unit} ${steam} #"steam"

        # 2. Shell
        bind = SUPER, tab, exec, ${noctalia} launcher toggle #"launcher"
        bind = SUPER, ESCAPE, exec, ${noctalia} sessionMenu toggle #"session menu"
        bind = SUPER, C, exec, ${noctalia} wallpaper toggle #"wallpaper menu"
        bind = SUPER, O, exec, ${noctalia} notifications toggleHistory #"notification history"
        bind = SUPER, U, exec, ${noctalia} controlCenter toggle #"control center"
        bind = SUPER, G, exec, ${noctalia} launcher emoji #"emoji picker"
        bind = SUPER SHIFT, V, exec, ${noctalia} launcher clipboard #"clipboard history"
        bind = SUPER, Y, exec, ${noctalia} idleInhibitor toggle #"idle inhibitor"

        # 3. Workspaces
        bind = SUPER, 1, split:workspace, 1 #"workspace 1"
        bind = SUPER, 2, split:workspace, 2 #"workspace 2"
        bind = SUPER, 3, split:workspace, 3 #"workspace 3"
        bind = SUPER, 4, split:workspace, 4 #"workspace 4"
        bind = SUPER, 5, split:workspace, 5 #"workspace 5"
        bind = SUPER, 6, split:workspace, 6 #"workspace 6"
        bind = SUPER, 7, split:workspace, 7 #"workspace 7"
        bind = SUPER, 8, split:workspace, 8 #"workspace 8"

        bind = SUPER SHIFT, 1, split:movetoworkspace, 1 #"move window to workspace 1"
        bind = SUPER SHIFT, 2, split:movetoworkspace, 2 #"move window to workspace 2"
        bind = SUPER SHIFT, 3, split:movetoworkspace, 3 #"move window to workspace 3"
        bind = SUPER SHIFT, 4, split:movetoworkspace, 4 #"move window to workspace 4"
        bind = SUPER SHIFT, 5, split:movetoworkspace, 5 #"move window to workspace 5"
        bind = SUPER SHIFT, 6, split:movetoworkspace, 6 #"move window to workspace 6"
        bind = SUPER SHIFT, 7, split:movetoworkspace, 7 #"move window to workspace 7"
        bind = SUPER SHIFT, 8, split:movetoworkspace, 8 #"move window to workspace 8"

        bind = SUPER CTRL, 1, split:movetoworkspacesilent, 1 #"move window to workspace 1 (silent)"
        bind = SUPER CTRL, 2, split:movetoworkspacesilent, 2 #"move window to workspace 2 (silent)"
        bind = SUPER CTRL, 3, split:movetoworkspacesilent, 3 #"move window to workspace 3 (silent)"
        bind = SUPER CTRL, 4, split:movetoworkspacesilent, 4 #"move window to workspace 4 (silent)"
        bind = SUPER CTRL, 5, split:movetoworkspacesilent, 5 #"move window to workspace 5 (silent)"
        bind = SUPER CTRL, 6, split:movetoworkspacesilent, 6 #"move window to workspace 6 (silent)"
        bind = SUPER CTRL, 7, split:movetoworkspacesilent, 7 #"move window to workspace 7 (silent)"
        bind = SUPER CTRL, 8, split:movetoworkspacesilent, 8 #"move window to workspace 8 (silent)"

        # 4. Window Management
        bind = SUPER, F, fullscreen #"toggle fullscreen"
        bind = SUPER, V, togglefloating #"toggle floating"
        bind = SUPER, S, togglesplit #"toggle split"
        bind = SUPER, P, pseudo #"toggle pseudo"
        bind = SUPER, Q, killactive #"close window"
        bind = SUPER SHIFT, O, split:grabroguewindows #"grab rogue windows"

        bind = SUPER SHIFT, LEFT, movewindow, l #"swap window left"
        bind = SUPER SHIFT, RIGHT, movewindow, r #"swap window right"
        bind = SUPER SHIFT, UP, movewindow, u #"swap window up"
        bind = SUPER SHIFT, DOWN, movewindow, d #"swap window down"

        bind = SUPER SHIFT, H, movewindow, l #"swap window left"
        bind = SUPER SHIFT, L, movewindow, r #"swap window right"
        bind = SUPER SHIFT, K, movewindow, u #"swap window up"
        bind = SUPER SHIFT, J, movewindow, d #"swap window down"

        # 5. Window Focus
        bind = SUPER, LEFT, movefocus, l #"focus left"
        bind = SUPER, RIGHT, movefocus, r #"focus right"
        bind = SUPER, UP, movefocus, u #"focus up"
        bind = SUPER, DOWN, movefocus, d #"focus down"

        bind = SUPER, H, movefocus, l #"focus left"
        bind = SUPER, L, movefocus, r #"focus right"
        bind = SUPER, K, movefocus, u #"focus up"
        bind = SUPER, J, movefocus, d #"focus down"

        # 6. Groups
        bind = SUPER, X, togglegroup #"toggle grouping"
        bind = SUPER ALT, X, moveoutofgroup #"move out of group"

        bind = SUPER ALT, LEFT, moveintogroup, l #"move into group (left)"
        bind = SUPER ALT, RIGHT, moveintogroup, r #"move into group (right)"
        bind = SUPER ALT, UP, moveintogroup, u #"move into group (up)"
        bind = SUPER ALT, DOWN, moveintogroup, d #"move into group (down)"

        bind = SUPER ALT, H, moveintogroup, l #"move into group (left)"
        bind = SUPER ALT, L, moveintogroup, r #"move into group (right)"
        bind = SUPER ALT, K, moveintogroup, u #"move into group (up)"
        bind = SUPER ALT, J, moveintogroup, d #"move into group (down)"

        bind = SUPER ALT, TAB, changegroupactive, f #"next in group"
        bind = SUPER ALT SHIFT, TAB, changegroupactive, b #"previous in group"
        bind = SUPER ALT, mouse_down, changegroupactive, f #"next in group"
        bind = SUPER ALT, mouse_up, changegroupactive, b #"previous in group"

        bind = SUPER ALT, 1, changegroupactive, 1 #"group window 1"
        bind = SUPER ALT, 2, changegroupactive, 2 #"group window 2"
        bind = SUPER ALT, 3, changegroupactive, 3 #"group window 3"
        bind = SUPER ALT, 4, changegroupactive, 4 #"group window 4"
        bind = SUPER ALT, 5, changegroupactive, 5 #"group window 5"

        # 7. Layout and Resize
        binde = SUPER CTRL, LEFT, resizeactive, -20 0 #"resize left"
        binde = SUPER CTRL, RIGHT, resizeactive, 20 0 #"resize right"
        binde = SUPER CTRL, UP, resizeactive, 0 -20 #"resize up"
        binde = SUPER CTRL, DOWN, resizeactive, 0 20 #"resize down"

        binde = SUPER CTRL, H, resizeactive, -20 0 #"resize left"
        binde = SUPER CTRL, L, resizeactive, 20 0 #"resize right"
        binde = SUPER CTRL, K, resizeactive, 0 -20 #"resize up"
        binde = SUPER CTRL, J, resizeactive, 0 20 #"resize down"

        # 8. Screenshots and Color
        bind = SUPER SHIFT, S, exec, ${hyprshot} -m region -z -o ${screenshotDir}/region #"screenshot region"
        bind = SUPER, Print, exec, ${hyprshot} -m output -c -o ${screenshotDir}/output #"screenshot output"
        bind = SUPER SHIFT, X, exec, ${hyprpicker} -n -a -r -q -l #"color picker"

        # 9. System
        bind = SUPER SHIFT, TAB, exec, ${qs} ipc -c overview call overview toggle #"overview"
        bind = SUPER, F2, exec, ${noctalia} plugin togglePanel keybind-cheatsheet #"keybind cheatsheet"
        bind = SUPER, F1, exec, ${getExe performantMode} #"performant mode"

        # 10. Zoom
        binde = SUPER, equal, exec, ${zoomIn} #"zoom in"
        binde = SUPER, minus, exec, ${zoomOut} #"zoom out"

        bind = SUPER, mouse_down, exec, ${zoomIn} #"zoom in"
        bind = SUPER, mouse_up, exec, ${zoomOut} #"zoom out"

        bind = SUPER SHIFT, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor 1 #"reset zoom"
        bind = SUPER SHIFT, minus, exec, ${hyprctl} -q keyword cursor:zoom_factor 1 #"reset zoom"

        # 11. Media
        bindl = , XF86AudioMute, exec, ${noctalia} volume muteOutput #"mute"
        bindel = , XF86AudioRaiseVolume, exec, ${noctalia} volume increase #"volume up"
        bindel = , XF86AudioLowerVolume, exec, ${noctalia} volume decrease #"volume down"

        # 12. Mouse
        bindm = SUPER, mouse:272, movewindow #"move window"
        bindm = SUPER, mouse:273, resizewindow #"resize window"
      ''
      + optionalString cfgBrightness ''

        # 13. Brightness
        bindel = , XF86MonBrightnessUp, exec, ${brightnessctl} set 1%+ #"brightness up"
        bindel = , XF86MonBrightnessDown, exec, ${brightnessctl} set 1%- #"brightness down"
      '';

    wayland.windowManager.hyprland.extraConfig = ''
      source = ${configHome}/hypr/keybinds.conf
    '';
  };
}
