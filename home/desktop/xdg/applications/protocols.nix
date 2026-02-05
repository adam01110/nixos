_:
# Default handlers for custom url protocols and schemes.
let
  inherit (builtins) listToAttrs;
in {
  xdg.mimeApps.defaultApplications = let
    mkEntries = prefix: desktop: names:
      map (name: {
        name = "${prefix}/${name}";
        value = desktop;
      })
      names;
  in
    listToAttrs (
      (mkEntries "x-scheme-handler" "zen-beta.desktop" [
        "https"
      ])
      ++ (mkEntries "x-scheme-handler" "obsidian.desktop" [
        "obsidian"
      ])
      ++ (mkEntries "x-scheme-handler" "beepertexts.desktop" [
        "beeper"
      ])
      ++ (mkEntries "x-scheme-handler" "org.prismlauncher.PrismLauncher.desktop" [
        "curseforge"
        "prismlauncher"
      ])
      ++ (mkEntries "x-scheme-handler" "org.vinegarhq.Sober.desktop" [
        "roblox-player"
        "roblox"
      ])
      ++ (mkEntries "x-scheme-handler" "bitwarden.desktop" [
        "bitwarden"
      ])
      ++ (mkEntries "x-scheme-handler" "onlyoffice-desktopeditors.desktop" [
        "oo-office"
      ])
      ++ (mkEntries "x-scheme-handler" "dev.zed.Zed.desktop" [
        "zed"
      ])
      ++ (mkEntries "x-scheme-handler" "steam.desktop" [
        "steam"
        "steamlink"
      ])
    );
}
