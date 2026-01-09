{osConfig, ...}:
# provide themed values to equibop plugins via module args.
let
  inherit (builtins) mapAttrs;
  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in {
  _module.args.equibopStylix = {
    # icon color for message fetch timer.
    messageFetchTimerIcon = colors.base0B;

    # questify color assignments.
    questify = {
      claimed = colors.base0E;
      expired = colors.base00;
      ignored = colors.base08;
      unclaimed = colors.base0D;
    };
  };
}
