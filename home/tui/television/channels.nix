{
  osConfig,
  config,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
in {
  programs.television.package = pkgs.television.withPackages (
    _:
      attrValues {
        inherit
          (pkgs)
          man
          tlrc
          ;

        inherit (pkgs.bat-extras) batman;
      }
      ++ [
        config.programs.zoxide.package
        config.programs.bat.package
        osConfig.services.flatpak.package
      ]
  );
}
