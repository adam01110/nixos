{ ... }:

{
  cmake = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = "󰔶 ";
    style = "bg:base01 fg:red bold";
  };

  gradle = {
    format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:cyan bold";
  };

  meson = {
    format = "[ ](#00000000)[](fg:base01)[$symbol$project]($style)[](fg:base01)";
    symbol = "⬢ ";
    style = "bg:base01 fg:blue bold";
  };
}
