{ ... }:

{
  c = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version(-$name))]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0D";
  };

  cpp = {
    disabled = false;
    format = "[ ](#00000000)[](fg:base01)[$symbol($version(-$name))]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0B";
  };

  dart = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0D";
  };

  dotnet = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)( $tfm)]($style)[](fg:base01)";
    symbol = "󰪮 ";
    style = "bg:base01 fg:bold base0D";
  };

  golang = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0C";
    not_capable_style = "bg:base01 fg:bold base08";
  };

  haskell = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰲒 ";
    style = "bg:base01 fg:bold base0E";
  };

  haxe = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base08";
  };

  java = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰅶 ";
    style = "bg:base01 fg:bold base08";
  };

  kotlin = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󱈙 ";
    style = "bg:base01 fg:bold base09";
  };

  lua = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰢱 ";
    style = "bg:base01 fg:bold base0D";
  };

  perl = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base09";
  };

  php = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0D";
  };

  python = {
    format = "[ ](#00000000)[](fg:base01)[$symbol$pyenv_prefix($version)( \\($virtualenv\\))]($style)[](fg:base01)";
    symbol = "󰌠 ";
    style = "bg:base01 fg:bold base0A";
    pyenv_version_name = true;
    pyenv_prefix = "uv";
  };

  ruby = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base08";
  };

  rust = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󱘗 ";
    style = "bg:base01 fg:bold base09";
  };

  swift = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰛥 ";
    style = "bg:base01 fg:bold base09";
  };

  zig = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0A";
  };
}
