{
  lib,
  osConfig,
  ...
}:
# Provide themed values to equibop plugins via module args.
let
  inherit (lib) fromHexString removePrefix;
  inherit (osConfig.lib.stylix) colors;
  colorToInt = color: fromHexString (removePrefix "#" color);
in {
  _module.args.equibopStylix = {
    # keep-sorted start block=yes newline_separated=yes
    # Icon color for message fetch timer.
    messageFetchTimerIcon = colors.base0B;

    # Questify color assignments.
    questify = {
      # keep-sorted start
      claimed = colorToInt colors.base0E;
      expired = colorToInt colors.base00;
      ignored = colorToInt colors.base08;
      unclaimed = colorToInt colors.base0D;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
