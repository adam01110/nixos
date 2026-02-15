_:
# Set env vars for eperimental features and disabled features.
let
  inherit (builtins) listToAttrs;
in {
  home.sessionVariables = let
    mkEnv = prefix: features:
      listToAttrs (
        map (n: {
          name = "${prefix}_${n}";
          value = 1;
        })
        features
      );

    experimentalFeatures = [
      "ICON_DISCOVERY"
      "FILEWATCHER"
      "LSP_TY"
      "OXFMT"
      "LSP_TOOL"
      "MARKDOWN"
    ];
    disabledFeatures = ["LSP_DOWNLOAD"];
  in
    mkEnv "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // mkEnv "OPENCODE_DISABLE" disabledFeatures;
}
