{ ... }:

# container and docker context segments.
{
  container = {
    format = "[ ](#00000000)[](fg:base01)[$symbol \\[$name\\]]($style)[](fg:base01)";
    symbol = " ";
    style = "bg:base01 fg:blue bold";
  };

  docker_context = {
    format = "[ ](#00000000)[](fg:base01)[$symbol$context]($style)[](fg:base01)";
    symbol = "󰡨 ";
    style = "bg:base01 fg:blue bold";
  };
}
