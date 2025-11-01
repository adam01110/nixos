{
  osConfig,
  ...
}:

let
  stylixColors = osConfig.lib.stylix.colors;
in
{
  _module.args.equibopStylix = {
    messageFetchTimerIcon = stylixColors.base0B;

    questify = {
      claimed = stylixColors.base0E;
      expired = stylixColors.base00;
      ignored = stylixColors.base08;
      unclaimed = stylixColors.base0D;
    };
  };
}
