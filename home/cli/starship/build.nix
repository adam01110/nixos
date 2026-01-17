_:
# starship segments for build tooling versions.
{
  programs.starship.settings = {
    cmake = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = "󰔶 ";
      style = "bg:base01 fg:red bold";
    };

    gradle = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol($version)]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:cyan bold";
    };

    meson = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$project]($style)[ ](bg:base01)";
      symbol = "⬢ ";
      style = "bg:base01 fg:blue bold";
    };
  };
}
