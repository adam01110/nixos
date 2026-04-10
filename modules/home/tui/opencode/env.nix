_:
# Set env vars for experimental features and disabled features.
let
  inherit (builtins) listToAttrs;
in {
  _module.args.opencodeEnv = let
    mkEnv = prefix: features:
      listToAttrs (
        map (n: {
          name = "${prefix}_${n}";
          value = 1;
        })
        features
      );

    experimentalFeatures = [
      # keep-sorted start
      "FILEWATCHER"
      "ICON_DISCOVERY"
      "LSP_TOOL"
      "LSP_TY"
      # keep-sorted end
    ];

    # Keep builtin lsp downloads disabled and rely on nix instead.
    disabledFeatures = [
      # keep-sorted start
      "AUTOCOMPACT"
      "LSP_DOWNLOAD"
      # keep-sorted end
    ];
    enabledFeatures = ["EXA"];
  in
    mkEnv "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // mkEnv "OPENCODE_DISABLE" disabledFeatures
    // mkEnv "OPENCODE_ENABLE" enabledFeatures;
}
