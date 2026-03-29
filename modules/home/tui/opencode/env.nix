_:
# Set env vars for experimental features and disabled features.
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
      "LSP_TOOL"
      "MARKDOWN"
    ];

    # Keep builtin lsp downloads disabled and rely on nix instead.
    disabledFeatures = ["LSP_DOWNLOAD"];
    enabledFeatures = ["EXA"];
  in
    mkEnv "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // mkEnv "OPENCODE_DISABLE" disabledFeatures
    // mkEnv "OPENCODE_ENABLE" enabledFeatures;
}
