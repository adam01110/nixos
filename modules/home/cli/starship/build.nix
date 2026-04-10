{flakeLib, ...}:
# Starship segments for build tooling versions.
let
  inherit (flakeLib) starshipBase01Segment;
in {
  programs.starship.settings = {
    # keep-sorted start block=yes newline_separated=yes
    cmake =
      starshipBase01Segment "$symbol($version)" "red bold"
      // {
        symbol = "󰔶 ";
      };

    gradle =
      starshipBase01Segment "$symbol($version)" "cyan bold"
      // {
        symbol = " ";
      };

    meson =
      starshipBase01Segment "$symbol$project" "blue bold"
      // {
        symbol = "⬢ ";
      };
    # keep-sorted end
  };
}
