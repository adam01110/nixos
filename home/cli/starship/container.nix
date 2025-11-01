{ ... }:

{
  container = {
    format = "[ ](#00000000)[](fg:base01)[$symbol \\[$name\\]]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:bold base0D";
  };

  docker_context = {
    format = "[ ](#00000000)[](fg:base01)[$symbol$context]($style)[](fg:base01)";
    symbol = "󰡨 ";
    style = "bg:base01 fg:bold base0D";
  };
}
