{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.starship.settings = {
    character = {
      format = "$symbol ";
      success_symbol = "[➜](bold base0B)";
      error_symbol = "[➜](bold base08)";
      vimcmd_symbol = "[](bold base0B)";
      vimcmd_replace_one_symbol = "[](bold base0E)";
      vimcmd_replace_symbol = "[](bold base0E)";
      vimcmd_visual_symbol = "[](bold base0A)";
    };

    cmd_duration = {
      format = "[ ](#00000000)[](fg:base01)[$duration]($style)[](fg:base01)";
      style = "bg:base01 fg:bold base0A";
      min_time = 500;
    };

    directory = {
      format = "[ ](#00000000)[](fg:base01)[$path]($style)[$read_only]($read_only_style)[](fg:base01)";
      style = "bg:base01 fg:bold base0D";
      read_only = " ";
      read_only_style = "bg:base01 fg:bold base08";
      truncation_length = 2;
      truncation_symbol = "…/";
      truncate_to_repo = true;
    };

    direnv = {
      disabled = false;
      format = "[ ](#00000000)[](fg:base01)[$symbol$loaded/$allowed]($style)[](fg:base01)";
      symbol = " ";
      style = "bg:base01 fg:bold base09";
    };

    hostname = {
      format = "[$ssh_symbol$hostname]($style)";
      style = "bg:base01 fg:bold base0B";
      ssh_symbol = "󰖟 ";
      ssh_only = false;
    };

    jobs = {
      format = "[ ](#00000000)[](fg:base01)[$symbol$number]($style)[](fg:base01)";
      symbol = "󱜯 ";
      style = "bg:base01 fg:bold base0D";
    };

    nix_shell = {
      format = "[ ](#00000000)[][$symbol$state( \\($name\\))]($style)[](fg:base01)";
      symbol = "󱄅 ";
      style = "bg:base01 fg:bold base0D";
      heuristic = true;
    };

    os = {
      disabled = false;
      format = "[$symbol]($style)";
      style = "bg:base01 fg:bold base04";

      symbols = {
        Linux = "";
        NixOS = "";
        Windows = "";
        Macos = "";
        Android = "";
      };
    };

    package = {
      format = "[ ](#00000000)[](fg:base01)[$symbol$version]($style)[](fg:base01)";
      symbol = "󰏗 ";
      style = "bg:base01 fg:bold base09";
      display_private = true;
    };

    shell = {
      disabled = false;
      format = "[$indicator]($style)";
      bash_indicator = "";
      fish_indicator = "";
      zsh_indicator = "";
      powershell_indicator = "󰨊";
      cmd_indicator = "";
      nu_indicator = "󰟆 ";
      unknown_indicator = "";
    };

    sudo = {
      disabled = false;
      format = "[ ](#00000000)[](fg:base01)[$symbol]($style)[](fg:base01)";
      symbol = "";
      style = "bg:base01 fg:bold base0A";
    };

    username = {
      format = "[$user]($style)";
      style_root = "bg:base01 fg:bold base08";
      style_user = "bg:base01 fg:bold base0D";
      show_always = true;
    };
  };
}
