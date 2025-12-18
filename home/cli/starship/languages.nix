{ ... }:

# per-language version modules for compilers and sdks.
{
  programs.starship.settings = {
    c = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version(-$name))]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:blue bold";
    };

    cpp = {
      disabled = false;
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version(-$name))]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:green bold";
    };

    dart = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:blue bold";
    };

    dotnet = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)( $tfm)]($style)[ ](bg:base01)";
      symbol = "󰪮 ";
      style = "bg:base01 fg:blue bold";
    };

    golang = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:cyan bold";
      not_capable_style = "bg:base01 fg:base08 bold";
    };

    haskell = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󰲒 ";
      style = "bg:base01 fg:magenta bold";
    };

    haxe = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:base08 bold";
    };

    java = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󰅶 ";
      style = "bg:base01 fg:base08 bold";
    };

    kotlin = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󱈙 ";
      style = "bg:base01 fg:base09 bold";
    };

    lua = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󰢱 ";
      style = "bg:base01 fg:blue bold";
    };

    perl = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:base09 bold";
    };

    php = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:blue bold";
    };

    python = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$pyenv_prefix($version)( \\($virtualenv\\))]($style)[ ](bg:base01)";
      symbol = "󰌠 ";
      style = "bg:base01 fg:yellow bold";
      pyenv_version_name = true;
      pyenv_prefix = "uv";
    };

    ruby = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:base08 bold";
    };

    rust = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󱘗 ";
      style = "bg:base01 fg:base09 bold";
    };

    swift = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󰛥 ";
      style = "bg:base01 fg:base09 bold";
    };

    zig = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:yellow bold";
    };
  };
}
