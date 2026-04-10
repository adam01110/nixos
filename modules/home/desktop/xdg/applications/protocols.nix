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
      # keep-sorted start block=yes
      (mkEntries "x-scheme-handler" "zen-beta.desktop" [
        "https"
      ])
      ++ (mkEntries "x-scheme-handler" "beepertexts.desktop" [
        "beeper"
      ])
      ++ (mkEntries "x-scheme-handler" "bitwarden.desktop" [
        "bitwarden"
      ])
      ++ (mkEntries "x-scheme-handler" "dev.zed.Zed.desktop" [
        "zed"
      ])
      ++ (mkEntries "x-scheme-handler" "obsidian.desktop" [
        "obsidian"
      ])
      ++ (mkEntries "x-scheme-handler" "onlyoffice-desktopeditors.desktop" [
        "oo-office"
      ])
      ++ (mkEntries "x-scheme-handler" "org.prismlauncher.PrismLauncher.desktop" [
        # keep-sorted start
        "curseforge"
        "prismlauncher"
        # keep-sorted end
      ])
      ++ (mkEntries "x-scheme-handler" "org.vinegarhq.Sober.desktop" [
        # keep-sorted start
        "roblox"
        "roblox-player"
        # keep-sorted end
      ])
      ++ (mkEntries "x-scheme-handler" "steam.desktop" [
        # keep-sorted start
        "steam"
        "steamlink"
        # keep-sorted end
      ])
      # keep-sorted end
    );
}
