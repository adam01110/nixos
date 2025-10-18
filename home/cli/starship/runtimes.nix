{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.starship.settings = {
    bun = {
      format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
      symbol = " ";
      style = "bg:base01 fg:bold base0A";
    };

    deno = {
      format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
      symbol = " ";
      style = "bg:base01 fg:bold base0B";
    };

    nodejs = {
      format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
      symbol = "󰎙 ";
      style = "bg:base01 fg:bold base0B";
      not_capable_style = "bg:base01 fg:bold base08";
    };
  };
}
