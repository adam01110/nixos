{
  config,
  lib,
  ...
}:

# define zen browser policies, options, and locked preferences.
let
  inherit (builtins) mapAttrs;
  inherit (lib)
    mkEnableOption
    mkOption
    types
    ;
in
{
  options.zen-browser = {
    travel.enable = mkEnableOption "Enable travel specific preferences.";
    commit-space = mkOption {
      type = types.int;
      description = "Memory threshold (in MiB) at which tabs are unloaded when available commit space is low";
    };
  };

  config.programs.zen-browser.policies =
    let
      mkLockedAttrs = mapAttrs (
        _: value: {
          Value = value;
          Status = "locked";
        }
      );

      mkExtensionSettings = mapAttrs (
        _: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        }
      );
    in
    {
      # set policies.S
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
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
      PDFjs.Enabled = false;
      StartDownloadsInTempDirectory = true;

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # set preferences.
      Preferences =
        let
          cfgTravel = config.zen-browser.travel.enable;
          cfgCommitSpace = config.zen-browser.commit-space;
        in
        mkLockedAttrs {
          "browser.aboutConfig.showWarning" = false;
          "browser.bookmarks.max_backups" = 1;
          "browser.cache.disk.capacity" = 8192000;
          "browser.cache.disk.metadata_memory_limit" = 15360;
          "browser.cache.disk.smart_size.enabled" = false;
          "browser.cache.frecency_half_life_hours" = 12;
          "browser.cache.memory.capacity" = 131072;
          "browser.cache.memory.max_entry_size" = 327680;
          "browser.cache.max_shutdown_io_lag" = 16;
          "browser.contentblocking.category" = "strict";
          "browser.contentblocking.report.hide_vpn_banner" = true;
          "browser.contentblocking.report.lockwise.enabled" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.link.open_newwindow.restriction" = 0;
          "browser.low_commit_space_threshold_mb" = cfgCommitSpace;
          "browser.low_commit_space_threshold_percent" = 20;
          "browser.newtabpage.activity-stream.default.sites" = " ";
          "browser.newtabpage.activity-stream.feeds.section.topstories.options" = "{\"hidden\":true}";
          "browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.profiles.enabled" = true;
          "browser.promo.focus.enabled" = false;
          "browser.region.network.url" = " ";
          "browser.region.update.enabled" = false;
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.dangerous.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = " ";
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.provider.google.gethashURL" = " ";
          "browser.safebrowsing.provider.google.reportURL" = " ";
          "browser.safebrowsing.provider.google.updateURL" = " ";
          "browser.safebrowsing.provider.google4.dataSharingURL" = " ";
          "browser.safebrowsing.provider.google4.gethashURL" = " ";
          "browser.safebrowsing.provider.google4.updateURL" = " ";
          "browser.search.separatePrivateDefault.ui.enabled" = false;
          "browser.search.serpEventTelemetryCategorization.enabled" = false;
          "browser.search.serpEventTelemetryCategorization.regionEnabled" = false;
          "browser.search.suggest.enabled.private" = true;
          "browser.tabs.min_inactive_duration_before_unload" = 300000;
          "browser.tabs.searchclipboardfor.middleclick" = false;
          "browser.tabs.unloadOnLowMemory" = true;
          "browser.theme.dark-private-windows" = false;
          "browser.topsites.useRemoteSetting" = false;
          "browser.urlbar.addons.featureGate" = true;
          "browser.urlbar.autoFill.adaptiveHistory.enabled" = true;
          "browser.urlbar.suggest.clipboard" = false;
          "browser.urlbar.suggest.fakespot" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.yelp" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.vpn_promo.enabled" = false;
          "browser.warnOnQuitShortcut" = false;
          "captivedetect.canonicalURL" = " ";
          "content.notify.interval" = 100000;
          "devtools.selfxss.count" = 0;
          "doh-rollout.home-region" = "NL";
          "dom.disable_window_move_resize" = true;
          "dom.security.https_only_mode.upgrade_onion" = true;
          "dom.security.https_only_mode_pbm" = true;
          "dom.text_fragments.create_text_fragment.enabled" = true;
          "dom.timeout.budget_throttling_max_delay" = 0;
          "dom.timeout.throttling_delay" = 40;
          "dom.webgpu.enabled" = true;
          "dom.webgpu.service-workers.enabled" = true;
          "extensions.enabledScopes" = 7;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "extensions.pocket.api" = " ";
          "extensions.pocket.oAuthConsumerKey" = " ";
          "extensions.pocket.quarantinedDomains.enabled" = false;
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = " ";
          "extensions.webcompat-reporter.newIssueEndpoint" = " ";
          "extensions.webextensions.restrictedDomains" = " ";
          "general.autoScroll" = false;
          "general.useragent.compatMode.firefox" = true;
          "gfx.canvas.accelerated.cache-items" = 32768;
          "gfx.canvas.accelerated.cache-size" = 4096;
          "gfx.content.skia-font-cache-size" = 80;
          "gfx.webrender.all" = true;
          "gfx.webrender.compositor" = true;
          "gfx.webrender.compositor.force-enabled" = true;
          "gfx.webrender.precache-shaders" = true;
          "gfx.webrender.program-binary-disk" = true;
          "gfx.webrender.quality.force-subpixel-aa-where-possible" = true;
          "gfx.webgpu.ignore-blocklist" = true;
          "image.cache.size" = 10485760;
          "image.mem.decode_bytes_at_a_time" = 65536;
          "image.mem.shared.unmap.min_expiration_ms" = 120000;
          "javascript.options.baselinejit.threshold" = 50;
          "javascript.options.concurrent_multiprocess_gcs.cpu_divisor" = 8;
          "javascript.options.ion.threshold" = 5000;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "layout.css.moz-document.content.enabled" = true;
          "layout.spellcheckDefault" = 2;
          "layers.acceleration.force-enabled" = true;
          "layers.gpu-process.enabled" = true;
          "layers.gpu-process.force-enabled" = true;
          "layers.mlgpu.enabled" = true;
          "lightweightThemes.getMoreURL" = " ";
          "media.autoplay.default" = 5;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "media.gpu-process-decoder" = true;
          "media.gpu-process-encoder" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.memory_cache_max_size" = 1048576;
          "media.memory_caches_combined_limit_kb" = 3145728;
          "media.memory_caches_combined_limit_pc_sysmem" = 10;
          "network.auth.subresource-http-auth-allow" = 1;
          "network.buffer.cache.count" = 48;
          "network.buffer.cache.size" = 65535;
          "network.captive-portal-service.enabled" = cfgTravel;
          "network.connectivity-service.enabled" = false;
          "network.dnsCacheEntries" = 1000;
          "network.dnsCacheExpirationGracePeriod" = 240;
          "network.dnsCacheExpiratio" = 3600;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-proxy" = 48;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.burst" = 14;
          "network.http.pacing.requests.enabled" = false;
          "network.http.pacing.requests.min-parallelism" = 10;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "network.predictor.enable-prefetch" = true;
          "network.predictor.max-resources-per-entry" = 250;
          "network.predictor.max-uri-length" = 1000;
          "network.predictor.preconnect-min-confidence" = 20;
          "network.predictor.prefetch-force-valid-for" = 3600;
          "network.predictor.prefetch-min-confidence" = 30;
          "network.predictor.prefetch-rolling-load-count" = 120;
          "network.predictor.preresolve-min-confidence" = 10;
          "network.ssl_tokens_cache_capacity" = 32768;
          "network.trr.mode" = 2;
          "nglayout.initialpaint.delay" = 0;
          "nglayout.initialpaint.delay_in_oopif" = 0;
          "pdfjs.sidebarViewOnLoad" = 0;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.shortcuts" = 2;
          "permissions.default.xr" = 2;
          "permissions.manager.defaultsUrl" = " ";
          "plain_text.wrap_long_lines" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "reader.parse-on-load.enabled" = false;
          "security.cert_pinning.enforcement_level" = 2;
          "security.OCSP.enabled" = 2;
          "security.OCSP.require" = true;
          "security.ssl.require_safe_negotiation" = true;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "toolkit.telemetry.cachedClientID" = " ";
          "toolkit.telemetry.server_owner" = " ";
          "ui.key.menuAccessKey" = 0;
          "widget.gtk.non-native-titlebar-buttons.enabled" = true;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "widget.use-xdg-desktop-portal.open-uri" = 1;
          "zen.urlbar.behavior" = "float";
          "zen.urlbar.show-pip-button" = true;
          "zen.view.experimental-no-window-controls" = true;
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.separate-essentials" = false;
          "zen.welcome-screen.seen" = true;
        };

      # add extensions not in nur.
      ExtensionSettings =
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
    };
}
