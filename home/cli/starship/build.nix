{ ... }:

{
  cmake = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰔶 ";
    style = "bg:base01 fg:bold base08";
  };

  gradle = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0C";
  };

  meson = {
    format = "[ ](#00000000)[](fg:base01)[$symbol$project]($style)[](fg:base01)";
    symbol = "⬢ ";
    style = "bg:base01 fg:bold base0D";
  };
}
