{
  osConfig,
  pkgs,
  ...
}: let
  inherit (builtins) mapAttrs;

  tomlFormat = pkgs.formats.toml {};

  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in {
  xdg.configFile."television/themes/".source = with colors;
    tomlFormat.generate "television-stylix.toml" {
      # general
      background = base00;
      border_fg = base04;
      text_fg = base05;
      dimmed_text_fg = base04;

      # input
      input_text_fg = base08;
      result_count_fg = base08;

      # results
      result_name_fg = base0D;
      result_line_number_fg = base0A;
      result_value_fg = base05;
      selection_fg = base0B;
      selection_bg = base01;
      match_fg = base08;

      # preview
      preview_title_fg = base0B;

      # modes
      channel_mode_fg = base00;
      channel_mode_bg = base0E;
      remote_control_mode_fg = base00;
      remote_control_mode_bg = base0C;
      action_picker_mode_fg = base00;
      action_picker_mode_bg = base0D;
    };
}
