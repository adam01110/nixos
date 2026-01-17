_:
# show container context in the prompt.
{
  programs.starship.settings = {
    container = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol \\[$name\\]]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:blue bold";
    };

    docker_context = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$context]($style)[ ](bg:base01)";
      symbol = "󰡨 ";
      style = "bg:base01 fg:blue bold";
    };
  };
}
