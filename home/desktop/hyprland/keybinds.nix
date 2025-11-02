{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

let
  inherit (lib)
    getExe
    getExe'
    mkEnableOption
    optionals
    ;
in
{
  options.hyprland.brightness.enable = mkEnableOption "Enable function-row (F-keys) for brightness keybindings.";

  config.wayland.windowManager.hyprland.settings =
    let
      bash = getExe pkgs.bash;
      gawk = getExe pkgs.gawk;
      hyprctl = getExe' inputs.hyprland.packages.${system}.hyprland "hyprctl";
      notify-send = getExe' pkgs.libnotify "notify-send";

      qs = getExe' pkgs.quickshell ".quickshell-wrapped";
      noctalia = "${getExe' inputs.noctalia.packages.${pkgs.system}.default "noctalia-shell"} ipc call";
    in
    {
      binds.movefocus_cycles_fullscreen = true;

      bind =
        let
          dolphin = getExe' pkgs.kdePackages.dolphin "dolphin";
          equibop = getExe pkgs.equibop;
          ghostty = getExe pkgs.ghostty;
          hyprpicker = getExe pkgs.hyprpicker;
          hyprshot = getExe pkgs.hyprshot;
          steam = getExe pkgs.steam;
          zen-browser = getExe inputs.zen-browser.packages."${system}".default;
          app2unit = "${getExe pkgs.app2unit} -- ";

          cfgOverview = config.hyprland.overview;
          screenshotDir = "${config.xdg.userDirs.pictures}/screenshot";

          performantMode = pkgs.writeShellApplication {
            name = "performantMode";
            runtimeInputs = builtins.attrValues {
              inherit (pkgs)
                bash
                gawk
                libnotify
                ;
            };
            excludeShellChecks = [ "SC2276" ];
            text =
              builtins.replaceStrings
                [ "@bash@" "@hyprctl@" "@gawk@" "@notifySend@" ]
                [ bash hyprctl gawk notify-send ]
                (builtins.readFile ./scripts/performant-mode.sh);
          };
        in
        [
          # workspaces
          "SUPER, 1, split:workspace, 1"
          "SUPER, 2, split:workspace, 2"
          "SUPER, 3, split:workspace, 3"
          "SUPER, 4, split:workspace, 4"
          "SUPER, 5, split:workspace, 5"
          "SUPER, 6, split:workspace, 6"
          "SUPER, 7, split:workspace, 7"
          "SUPER, 8, split:workspace, 8"
          "SUPER, 9, split:workspace, 9"

          "SUPER SHIFT, 1, split:movetoworkspace, 1"
          "SUPER SHIFT, 2, split:movetoworkspace, 2"
          "SUPER SHIFT, 3, split:movetoworkspace, 3"
          "SUPER SHIFT, 4, split:movetoworkspace, 4"
          "SUPER SHIFT, 5, split:movetoworkspace, 5"
          "SUPER SHIFT, 6, split:movetoworkspace, 6"
          "SUPER SHIFT, 7, split:movetoworkspace, 7"
          "SUPER SHIFT, 8, split:movetoworkspace, 8"

          "SUPER CTRL, 1, split:movetoworkspacesilent, 1"
          "SUPER CTRL, 2, split:movetoworkspacesilent, 2"
          "SUPER CTRL, 3, split:movetoworkspacesilent, 3"
          "SUPER CTRL, 4, split:movetoworkspacesilent, 4"
          "SUPER CTRL, 5, split:movetoworkspacesilent, 5"
          "SUPER CTRL, 6, split:movetoworkspacesilent, 6"
          "SUPER CTRL, 7, split:movetoworkspacesilent, 7"
          "SUPER CTRL, 8, split:movetoworkspacesilent, 8"

          "SUPER SHIFT, O, split:grabroguewindows"

          # window manipulation
          "SUPER SHIFT, LEFT, movewindow, l"
          "SUPER SHIFT, RIGHT, movewindow, r"
          "SUPER SHIFT, UP, movewindow, u"
          "SUPER SHIFT, DOWN, movewindow, d"

          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, J, movewindow, d"

          "SUPER CTRL, LEFT, resizeactive, -20 0"
          "SUPER CTRL, RIGHT, resizeactive, 20 0"
          "SUPER CTRL, UP, resizeactive, 0 -20"
          "SUPER CTRL, DOWN, resizeactive, 0 20"

          "SUPER CTRL, H, resizeactive, -20 0"
          "SUPER CTRL, L, resizeactive, 20 0"
          "SUPER CTRL, K, resizeactive, 0 -20"
          "SUPER CTRL, J, resizeactive, 0 20"

          "SUPER, F, fullscreen"
          "SUPER, V, togglefloating"
          "SUPER, S, togglesplit"
          "SUPER, Q, killactive"

          # window focus
          "SUPER, LEFT, movefocus, l"
          "SUPER, RIGHT, movefocus, r"
          "SUPER, UP, movefocus, u"
          "SUPER, DOWN, movefocus, d"

          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # miscellaneous
          "SUPER, F1, exec, ${getExe performantMode}"

          # zoom
          "SUPER, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')"
          "SUPER, mouse_up, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')"

          "SUPER SHIFT, mouse_down, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"
          "SUPER SHIFT, minus, exec, ${hyprctl} -q keyword cursor:zoom_factor 1"

          # shell
          "SUPER, tab, exec, ${noctalia} launcher toggle"
          "SUPER, P, exec, ${noctalia} sessionMenu toggle"
          "SUPER, C, exec, ${noctalia} wallpaper toggle"
          "SUPER, O, exec, ${noctalia} notifications toggleHistory"
          "SUPER, I, exec, ${noctalia} controlCenter toggle"
          "SUPER, G, exec, ${noctalia} launcher calculator"
          "SUPER, H, exec, ${noctalia} launcher clipboard"
          "SUPER, L, exec, ${noctalia} idleInhibitor toggle"

          # screenshots
          "SUPER SHIFT, S, exec, ${hyprshot} -m region -z -o ${screenshotDir}/region"
          "SUPER, Print, exec, ${hyprshot} -m output -c -o ${screenshotDir}/output"

          # picker
          "SUPER SHIFT, S, exec, ${hyprpicker} -n -a -r -q -l"

          # applications
          "SUPER, Return, exec, ${app2unit} ${ghostty}"
          "SUPER, E, exec, ${app2unit} ${dolphin}"
          "SUPER, N, exec, ${app2unit} ${equibop}"
          "SUPER, B, exec, ${app2unit} ${zen-browser}"
          "SUPER, M, exec, ${app2unit} ${steam}"
        ]
        ++ (
          if cfgOverview == "quickshell" then
            [ "SUPER SHIFT, TAB, exec, ${qs} ipc -c overview call overview toggle" ]
          else
            [ "SUPER SHIFT, TAB, hyprexpo:expo, toggle" ]
        );

      bindm = [
        # window manipulation
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      binde = [
        # zoom
        "SUPER, equal, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 1.1}')"
        "minus, exec, ${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor | ${gawk} '/^float.*/ {print $2 * 0.9}')"
      ];

      bindel =
        let
          cfgBrightness = config.hyprland.brightness.enable;
        in
        [
          "XF86AudioMute, exec, ${noctalia} volume muteOutput"
          "XF86AudioRaiseVolume, exec, ${noctalia} volume increase"
          "XF86AudioLowerVolume, exec, ${noctalia} volume decrease"
        ]
        ++ optionals cfgBrightness [
          "XF86MonBrightnessUp, exec, brightnessctl set 1%+"
          "XF86MonBrightnessDown, exec, brightnessctl set 1%-"
        ];
    };
}
