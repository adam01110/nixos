{
  # keep-sorted start
  flakeLib,
  osConfig,
  # keep-sorted end
  ...
}: let
  inherit (flakeLib) blendHex;
  colors = osConfig.lib.stylix.colors.withHashtag;
in {
  programs.delta.options = with colors; {
    syntax-theme = "base16-stylix";

    # keep-sorted start
    file-style = "${base0D} bold";
    hunk-header-decoration-style = "${base0D} ul";
    hunk-header-file-style = "${base0D} ul bold";
    hunk-header-line-number-style = "${base0A} box bold";
    plus-style = "syntax ${blendHex 22 base00 base0B}";
    plus-emph-style = "${base00} ${blendHex 34 base00 base0B}";
    minus-style = "syntax ${blendHex 22 base00 base08}";
    minus-emph-style = "${base00} ${blendHex 34 base00 base08}";
    line-numbers-minus-style = base08;
    line-numbers-plus-style = base0B;
    line-numbers-left-style = base0D;
    line-numbers-right-style = base0D;
    line-numbers-zero-style = base03;
    whitespace-error-style = "${base00} bold";
    blame-palette = "${base00} ${base01} ${base02}";
    merge-conflict-ours-diff-header-style = "${base0A} bold";
    merge-conflict-ours-diff-header-decoration-style = "${base0D} box";
    merge-conflict-theirs-diff-header-style = "${base0A} bold";
    merge-conflict-theirs-diff-header-decoration-style = "${base0D} box";
    # keep-sorted end
  };
}
