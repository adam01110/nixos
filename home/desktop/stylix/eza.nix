{
  osConfig,
  ...
}:

# expose a theme for eza via module args.
let
  inherit (builtins) mapAttrs;
  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in
{
  _module.args.ezaStylix = {
    colourful = true;

    # file kind colors.
    filekinds = {
      normal = colors.base05;
      directory = colors.base0D;
      symlink = colors.base0C;
      pipe = colors.base04;
      block_device = colors.base08;
      char_device = colors.base08;
      socket = colors.base03;
      special = colors.base0E;
      executable = colors.base0B;
      mount_point = colors.base09;
    };

    # permission bit colors.
    perms = {
      user_read = colors.base05;
      user_write = colors.base0A;
      user_execute_file = colors.base0B;
      user_execute_other = colors.base0B;
      group_read = colors.base05;
      group_write = colors.base0A;
      group_execute = colors.base0B;
      other_read = colors.base04;
      other_write = colors.base0A;
      other_execute = colors.base0B;
      special_user_file = colors.base0E;
      special_other = colors.base04;
      attribute = colors.base04;
    };

    # size column colors by unit and magnitude.
    size = {
      major = colors.base04;
      minor = colors.base0C;
      number_byte = colors.base05;
      number_kilo = colors.base05;
      number_mega = colors.base0D;
      number_giga = colors.base0E;
      number_huge = colors.base0E;
      unit_byte = colors.base04;
      unit_kilo = colors.base0D;
      unit_mega = colors.base0E;
      unit_giga = colors.base0E;
      unit_huge = colors.base09;
    };

    # user and group colors.
    users = {
      user_you = colors.base05;
      user_root = colors.base08;
      user_other = colors.base0E;
      group_yours = colors.base05;
      group_other = colors.base04;
      group_root = colors.base08;
    };

    # link count and hardlink colors.
    links = {
      normal = colors.base0C;
      multi_link_file = colors.base09;
    };

    # git status colors.
    git = {
      new = colors.base0B;
      modified = colors.base0A;
      deleted = colors.base08;
      renamed = colors.base0C;
      typechange = colors.base0E;
      ignored = colors.base04;
      conflicted = colors.base08;
    };

    # git repo metadata colors.
    git_repo = {
      branch_main = colors.base05;
      branch_other = colors.base0E;
      git_clean = colors.base0B;
      git_dirty = colors.base08;
    };

    # selinux security context colors.
    security_context = {
      colon = colors.base04;
      user = colors.base05;
      role = colors.base0E;
      typ = colors.base03;
      range = colors.base0E;
    };

    # colors by file extension category.
    file_type = {
      image = colors.base0A;
      video = colors.base08;
      music = colors.base0B;
      lossless = colors.base0C;
      crypto = colors.base04;
      document = colors.base05;
      compressed = colors.base0E;
      temp = colors.base08;
      compiled = colors.base0D;
      build = colors.base04;
      source = colors.base0D;
    };

    # misc token colors.
    punctuation = colors.base04;
    date = colors.base0A;
    inode = colors.base04;
    blocks = colors.base03;
    header = colors.base05;
    octal = colors.base0C;
    flags = colors.base0E;

    # symlink visuals.
    symlink_path = colors.base0C;
    control_char = colors.base0D;
    broken_symlink = colors.base08;
    broken_path_overlay = colors.base04;
  };
}
