{ ... }:

{
  bun = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:yellow bold";
  };

  deno = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:green bold";
  };

  nodejs = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰎙 ";
    style = "bg:base01 fg:green bold";
    not_capable_style = "bg:base01 fg:base08 bold";
  };
}
