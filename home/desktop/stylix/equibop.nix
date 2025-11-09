{
  osConfig,
  ...
}:

let
  inherit (builtins) mapAttrs;
  colors = mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;
in
{
  _module.args.equibopStylix = {
    messageFetchTimerIcon = colors.base0B;

    questify = {
      claimed = colors.base0E;
      expired = colors.base00;
      ignored = colors.base08;
      unclaimed = colors.base0D;
    };
  };
}
