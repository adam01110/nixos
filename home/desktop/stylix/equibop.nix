{
  lib,
  osConfig,
  ...
}:

let
  colors =
    let
      stylixColors = osConfig.lib.stylix.colors;
      hashPrefix =
        value: if lib.isString value && !(lib.strings.hasPrefix "#" value) then "#${value}" else value;
    in
    builtins.mapAttrs (_: hashPrefix) stylixColors;
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
