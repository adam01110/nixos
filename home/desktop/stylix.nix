{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  color = config.lib.stylix.colors.withHashtag;
  colorRgb = config.lib.stylix.colors;

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;
in
{

  qt.style.package = pkgs.nur.repos.shadowrz.klassy;

  stylix = {
    cursor = {
      name = "Bibata-Modern-Gruvbox";
      package = pkgs.nur.repos.adam01110.bibata-cursors-gruvbox;
    };

    icons = {
      enable = true;
      light = "Gruvbox Plus Dark";
      dark = "Gruvbox Plus Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    opacity = {
      applications = 0.95;
      desktop = 0.95;
      popups = 0.95;
      terminal = 0.95;
    };

    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };

    targets = {
      nixcord.enable = false;
      vencord.enable = false;
      obsidian.enable = false;
      hyprland.enable = false;
    };
  };

  home.packages = with pkgs; [ nur.repos.adam01110.bibata-cursors-gruvbox-hyprcursor ];
  home.sessionVariables.HYPRCURSOR_THEME = config.stylix.cursor.name;

  programs.eza.theme = {
    colourful = true;

    filekinds = {
      normal = color.base05;
      directory = color.base0D;
      symlink = color.base0C;
      pipe = color.base04;
      block_device = color.base08;
      char_device = color.base08;
      socket = color.base03;
      special = color.base0E;
      executable = color.base0B;
      mount_point = color.base09;
    };

    perms = {
      user_read = color.base05;
      user_write = color.base0A;
      user_execute_file = color.base0B;
      user_execute_other = color.base0B;
      group_read = color.base05;
      group_write = color.base0A;
      group_execute = color.base0B;
      other_read = color.base04;
      other_write = color.base0A;
      other_execute = color.base0B;
      special_user_file = color.base0E;
      special_other = color.base04;
      attribute = color.base04;
    };

    size = {
      major = color.base04;
      minor = color.base0C;
      number_byte = color.base05;
      number_kilo = color.base05;
      number_mega = color.base0D;
      number_giga = color.base0E;
      number_huge = color.base0E;
      unit_byte = color.base04;
      unit_kilo = color.base0D;
      unit_mega = color.base0E;
      unit_giga = color.base0E;
      unit_huge = color.base09;
    };

    users = {
      user_you = color.base05;
      user_root = color.base08;
      user_other = color.base0E;
      group_yours = color.base05;
      group_other = color.base04;
      group_root = color.base08;
    };

    links = {
      normal = color.base0C;
      multi_link_file = color.base09;
    };

    git = {
      new = color.base0B;
      modified = color.base0A;
      deleted = color.base08;
      renamed = color.base0C;
      typechange = color.base0E;
      ignored = color.base04;
      conflicted = color.base08;
    };

    git_repo = {
      branch_main = color.base05;
      branch_other = color.base0E;
      git_clean = color.base0B;
      git_dirty = color.base08;
    };

    security_context = {
      colon = color.base04;
      user = color.base05;
      role = color.base0E;
      typ = color.base03;
      range = color.base0E;
    };

    file_type = {
      image = color.base0A;
      video = color.base08;
      music = color.base0B;
      lossless = color.base0C;
      crypto = color.base04;
      document = color.base05;
      compressed = color.base0E;
      temp = color.base08;
      compiled = color.base0D;
      build = color.base04;
      source = color.base0D;
    };

    punctuation = color.base04;
    date = color.base0A;
    inode = color.base04;
    blocks = color.base03;
    header = color.base05;
    octal = color.base0C;
    flags = color.base0E;

    symlink_path = color.base0C;
    control_char = color.base0D;
    broken_symlink = color.base08;
    broken_path_overlay = color.base04;
  };

  programs.zathura.options.font = sansSerifFont;

  wayland.windowManager.hyprland.settings = {
    general."col.inactive_border" = lib.mkForce "rgb(${colorRgb.base0B})";
    group."col.border_active" = lib.mkForce "rgb(${colorRgb.base03})";

    plugin.hyprexpo.bg_col = "rgb(${colorRgb.base00})";
  };

  programs.noctalia-shell.settings = {
    colors = {
      mError = color.base08;
      mOnError = color.base07;
      mOnPrimary = color.base05;
      mOnSecondary = color.base05;
      mOnSurface = color.base05;
      mOnSurfaceVariant = color.base04;
      mOnTertiary = color.base05;
      mOutline = color.base03;
      mPrimary = color.base0D;
      mSecondary = color.base0E;
      mShadow = color.base00;
      mSurface = color.base00;
      mSurfaceVariant = color.base01;
      mTertiary = color.base0B;
    };

    ui = {
      fontDefault = sansSerifFont;
      fontFixed = monospaceFont;
    };
  };
}
