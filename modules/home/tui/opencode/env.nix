{flakeLib, ...}: let
  inherit (flakeLib) envFlags;
in {
  _module.args.opencodeEnv = let
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
    envFlags "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // envFlags "OPENCODE_DISABLE" disabledFeatures
    // envFlags "OPENCODE_ENABLE" enabledFeatures;
}
