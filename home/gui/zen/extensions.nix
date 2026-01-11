{pkgs, ...}:
# zen browser extensions configuration.
let
  inherit
    (builtins)
    attrValues
    mapAttrs
    ;
in {
  # add extensions in nur.
  programs.zen-browser.profiles.default.extensions = {
    # force extensions to be enabled.
    force = true;
    packages = attrValues {
      inherit
        (pkgs.nur.repos.rycee.firefox-addons)
        # content blocking.
        ublock-origin
        localcdn
        sponsorblock
        fastforwardteam
        istilldontcareaboutcookies
        consent-o-matic
        don-t-fuck-with-paste
        # annoyances.
        shinigami-eyes
        translate-web-pages
        return-youtube-dislikes
        dearrow
        darkreader
        bitwarden
        wikiwand-wikipedia-modernized
        violentmonkey
        pronoundb
        modrinthify
        indie-wiki-buddy
        libredirect
        ;
    };
  };

  # add extensions not in nur.
  programs.zen-browser.policies.ExtensionSettings = let
    mkExtensionSettings = mapAttrs (
      _: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      }
    );
  in
    (mkExtensionSettings {
      "{76ef94a4-e3d0-4c6f-961a-d38a429a332b}" = "ttv-lol-pro";
      "{3507f56d-2ef5-45c1-b6d7-5297a0ba7642}" = "cookie-remover";
    })
    // {
      "magnolia@12.34" = {
        install_url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-latest.xpi";
        installation_mode = "force_installed";
      };
    };
}
