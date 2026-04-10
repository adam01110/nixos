{flakeLib, ...}:
# Display js runtime versions when active.
let
  inherit (flakeLib) starshipBase01Segment starshipBase01Style;
in {
  programs.starship.settings = {
    # keep-sorted start block=yes newline_separated=yes
    bun =
      starshipBase01Segment "$symbol($version)" "yellow bold"
      // {
        symbol = " ";
      };

    deno =
      starshipBase01Segment "$symbol($version)" "green bold"
      // {
        symbol = " ";
      };

    nodejs =
      starshipBase01Segment "$symbol($version)" "green bold"
      // {
        symbol = "󰎙 ";
        not_capable_style = starshipBase01Style "base08 bold";
      };
    # keep-sorted end
  };
}
