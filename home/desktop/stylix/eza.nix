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
  _module.args.ezaStylix = with colors; {
    colourful = true;

    # file kind colors.
    filekinds = {
      normal = base05;
      directory = base0D;
      symlink = base0C;
      pipe = base04;
      block_device = base08;
      char_device = base08;
      socket = base03;
      special = base0E;
      executable = base0B;
      mount_point = base09;
    };

    # permission bit colors.
    perms = {
      user_read = base05;
      user_write = base0A;
      user_execute_file = base0B;
      user_execute_other = base0B;
      group_read = base05;
      group_write = base0A;
      group_execute = base0B;
      other_read = base04;
      other_write = base0A;
      other_execute = base0B;
      special_user_file = base0E;
      special_other = base04;
      attribute = base04;
    };

    # size column colors by unit and magnitude.
    size = {
      major = base04;
      minor = base0C;
      number_byte = base05;
      number_kilo = base05;
      number_mega = base0D;
      number_giga = base0E;
      number_huge = base0E;
      unit_byte = base04;
      unit_kilo = base0D;
      unit_mega = base0E;
      unit_giga = base0E;
      unit_huge = base09;
    };

    # user and group
    users = {
      user_you = base05;
      user_root = base08;
      user_other = base0E;
      group_yours = base05;
      group_other = base04;
      group_root = base08;
    };

    # link count and hardlink
    links = {
      normal = base0C;
      multi_link_file = base09;
    };

    # git status
    git = {
      new = base0B;
      modified = base0A;
      deleted = base08;
      renamed = base0C;
      typechange = base0E;
      ignored = base04;
      conflicted = base08;
    };

    # git repo metadata
    git_repo = {
      branch_main = base05;
      branch_other = base0E;
      git_clean = base0B;
      git_dirty = base08;
    };

    # selinux security context
    security_context = {
      colon = base04;
      user = base05;
      role = base0E;
      typ = base03;
      range = base0E;
    };

    # colors by file extension category.
    file_type = {
      image = base0A;
      video = base08;
      music = base0B;
      lossless = base0C;
      crypto = base04;
      document = base05;
      compressed = base0E;
      temp = base08;
      compiled = base0D;
      build = base04;
      source = base0D;
    };

    # misc token
    punctuation = base04;
    date = base0A;
    inode = base04;
    blocks = base03;
    header = base05;
    octal = base0C;
    flags = base0E;

    # symlink visuals.
    symlink_path = base0C;
    control_char = base0D;
    broken_symlink = base08;
    broken_path_overlay = base04;
  };
}
