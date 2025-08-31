{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfgTravel = config.zen-browser.travel.enable;
in
{
  options.zen-browser.travel.enable = lib.mkEnableOption "Enable travel specific preferences.";

  programs.zen-browser = {
    enable = true;

    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );

        mkExtensionSettings = builtins.mapAttrs (
          _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
          }
        );
      in
      {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableBuiltinPDFViewer = true;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableForgetButton = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisablePasswordReveal = true;
        DisablePocket = true;
        DisableSafeMode = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        SkipTermsOfUse = true;
        TranslateEnabled = false;
        SearchSuggestEnabled = false;
        HttpsOnlyMode = true;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        Preferences = mkLockedAttrs {
          "browser.aboutConfig.showWarning" = false;
          "browser.cache.disk.capacity" = 8192000;
          "browser.cache.disk.metadata_memory_limit" = 15360;
          "browser.cache.disk.smart_size.enabled" = false;
          "browser.cache.frecency_half_life_hours" = 12;
          "browser.cache.max_shutdown_io_lag" = 16;
          "browser.cache.memory.max_entry_size" = 327680;
          "browser.places.speculativeConnect.enabled" = false;
          "browser.tabs.unloadOnLowMemory" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "dom.security.https_only_mode.upgrade_onion" = true;
          "dom.security.https_only_mode_pbm" = true;
          "dom.timeout.budget_throttling_max_delay" = 0;
          "dom.timeout.throttling_delay" = 40;
          "dom.webgpu.enabled" = true;
          "dom.webgpu.service-workers.enabled" = true;
          "gfx.canvas.accelerated.cache-items" = 32768;
          "gfx.canvas.accelerated.cache-size" = 4096;
          "gfx.content.skia-font-cache-size" = 80;
          "gfx.webrender.all" = true;
          "gfx.webrender.compositor" = true;
          "gfx.webrender.compositor.force-enabled" = true;
          "gfx.webrender.precache-shaders" = true;
          "gfx.webrender.program-binary-disk" = true;
          "gfx.webrender.software.opengl" = true;
          "gfx.webgpu.ignore-blocklist" = true;
          "image.cache.size" = 10485760;
          "image.mem.decode_bytes_at_a_time" = 65536;
          "image.mem.shared.unmap.min_expiration_ms" = 120000;
          "javascript.options.baselinejit.threshold" = 50;
          "javascript.options.concurrent_multiprocess_gcs.cpu_divisor" = 8;
          "javascript.options.ion.threshold" = 5000;
          "layers.acceleration.force-enabled" = true;
          "layers.gpu-process.enabled" = true;
          "layers.gpu-process.force-enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.memory_cache_max_size" = 1048576;
          "media.memory_caches_combined_limit_kb" = 3145728;
          "network.auth.subresource-http-auth-allow" = 1;
          "network.captive-portal-service.enabled" = cfgTravel;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.http.speculative-parallel-limit" = 0;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "network.ssl_tokens_cache_capacity" = 32768;
          "zen.view.experimental-no-window-controls" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.ssl.require_safe_negotiation" = true;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "security.OCSP.require" = true;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.provider.google4.gethashURL" = "";
          "browser.safebrowsing.provider.google4.updateURL" = "";
          "browser.safebrowsing.provider.google4.dataSharingURL" = "";
          "browser.safebrowsing.provider.google.gethashURL" = "";
          "browser.safebrowsing.provider.google.updateURL" = "";
          "browser.safebrowsing.provider.google.reportURL" = "";
          "browser.safebrowsing.provider.mozilla.gethashURL" = "";
          "browser.safebrowsing.downloads.remote.url" = "";
          "permissions.manager.defaultsUrl" = "";
          "geo.provider.use_geoclue" = false;
          "extensions.webextensions.restrictedDomains" = "";
          "extensions.postDownloadThirdPartyPrompt" = "";
        };

        ExtensionSettings = mkExtensionSettings {
          "{76ef94a4-e3d0-4c6f-961a-d38a429a332b}" = "ttv-lol-pro";
          "DontFuckWithPaste@raim.ist" = "don-t-fuck-with-paste";
          "{5ac8c0a3-ce21-4c47-972d-b45e685cca5d}" = "twitch-chat-pronouns";
          "{3507f56d-2ef5-45c1-b6d7-5297a0ba7642}" = "cookie-remover";
        };
      };

    profiles.${username} = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # content blocking
          ublock-origin
          localcdn
          sponsorblock
          fastforwardteam

          # annoyances
          shinigami-eyes
          istilldontcareaboutcookies
          translate-web-pages
          return-youtube-dislikes
          dearrow
          modrinthify

          darkreader
          stylus
          bitwarden
          wikiwand-wikipedia-modernized
        ];

        "uBlock0@raymondhill.net".settings = {
          selectedFilterLists = [ ];
        };
      };

      search = {
        force = true;
        default = "brave";

        engines =
          let
            nix-icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          in
          {
            # nixos
            nix-packages = {
              name = "Nix packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = nix-icon;
              definedAliases = [ "@np" ];
            };
            nixos-wiki = {
              name = "NixOS wiki";
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              icon = nix-icon;
              definedAliases = [ "@nw" ];
            };

            # general search
            brave = {
              name = "Brave search";
              urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
              icon = "";
              definedAliases = [ "@b" ];
            };
            google.metaData.alias = "@g";

            # disabled (hidden)
            bing.metaData.hidden = true;
            ddg.metaData.hidden = true;
            qwant.metaData.hidden = true;
            ecosia.metaData.hidden = true;
          };
      };

      containersForce = true;

      spacesForce = true;
      spaces = { };

      settings = { };
    };
  };
}
