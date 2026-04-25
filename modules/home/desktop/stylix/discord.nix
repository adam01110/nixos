{
  # keep-sorted start
  lib,
  osConfig,
  # keep-sorted end
  ...
}: let
  inherit (lib) fromHexString;
  inherit (osConfig.lib.stylix) colors;
in {
  # Pass themed values to Equibop plugins through module arguments.
  _module.args.equibopStylix = {
    # keep-sorted start block=yes newline_separated=yes
    # Icon color for message fetch timer.
    messageFetchTimerIcon = colors.base0B;

    # Reuse the full Stylix palette in local Equibop theming.
    palette = colors.withHashtag;

    # Questify color assignments.
    questify = {
      # keep-sorted start
      claimed = fromHexString colors.base0E;
      expired = fromHexString colors.base00;
      ignored = fromHexString colors.base08;
      unclaimed = fromHexString colors.base0D;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
