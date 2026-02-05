{
  config,
  lib,
  vars,
  ...
}: let
  # Zen browser preference defaults and performance tuning.
  inherit
    (lib)
    mkEnableOption
    mkOption
    types
    ;
  inherit (vars) countryCode;
in {
  options.zen-browser = {
    travel.enable = mkEnableOption "Enable travel specific preferences.";
    commit-space = mkOption {
      type = types.int;
      description = "Memory threshold (in MiB) at which tabs are unloaded when available commit space is low";
    };
  };

  config.programs.zen-browser.profiles.default.settings = let
    cfgTravel = config.zen-browser.travel.enable;
    cfgCommitSpace = config.zen-browser.commit-space;
  in {
    captivedetect.canonicalURL = " ";
    content.notify.interval = 100000;
    devtools.selfxss.count = 0;
    doh-rollout.home-region = countryCode;
    lightweightThemes.getMoreURL = " ";
    pdfjs.sidebarViewOnLoad = 0;
    plain_text.wrap_long_lines = false;
    reader.parse-on-load.enabled = false;
    ui.key.menuAccessKey = 0;

    browser = {
      aboutConfig.showWarning = false;
      bookmarks.max_backups = 1;
      download.always_ask_before_handling_new_types = true;
      link.open_newwindow.restriction = 0;
      promo.focus.enabled = false;
      theme.dark-private-windows = false;
      topsites.useRemoteSetting = false;
      vpn_promo.enabled = false;
      warnOnQuitShortcut = false;

      low_commit_space_threshold_mb = cfgCommitSpace;
      low_commit_space_threshold_percent = 20;

      cache = {
        frecency_half_life_hours = 12;
        max_shutdown_io_lag = 16;

        disk = {
          smart_size.enabled = false;

          capacity = 8192000;
          metadata_memory_limit = 15360;
        };

        memory = {
          capacity = 131072;
          max_entry_size = 327680;
        };
      };

      contentblocking = {
        category = "strict";

        report = {
          hide_vpn_banner = true;
          lockwise.enabled = false;
        };
      };

      newtabpage.activity-stream = {
        newtabWallpapers.v2.enabled = false;

        default.sites = " ";
        feeds.section.topstories.options = "{\"hidden\":true}";

        section.highlights = {
          includeDownloads = false;
          includeVisited = false;
        };
      };

      region = {
        update.enabled = false;
        network.url = " ";
      };

      safebrowsing = {
        blockedURIs.enabled = false;
        malware.enabled = false;
        phishing.enabled = false;

        downloads = {
          enabled = false;
          dangerous.enabled = false;

          remote = {
            enabled = false;

            block_dangerous = false;
            block_dangerous_host = false;
            block_potentially_unwanted = false;
            block_uncommon = false;

            url = " ";
          };
        };

        provider = {
          google = {
            gethashURL = " ";
            reportURL = " ";
            updateURL = " ";
          };

          google4 = {
            dataSharingURL = " ";
            gethashURL = " ";
            updateURL = " ";
          };
        };
      };

      search = {
        separatePrivateDefault.ui.enabled = false;
        suggest.enabled.private = true;

        serpEventTelemetryCategorization = {
          enabled = false;
          regionEnabled = false;
        };
      };

      tabs = {
        searchclipboardfor.middleclick = false;
        unloadOnLowMemory = true;
        min_inactive_duration_before_unload = 300000;
      };

      urlbar = {
        addons.featureGate = true;
        autoFill.adaptiveHistory.enabled = true;

        suggest = {
          clipboard = false;
          fakespot = false;
          quickactions = false;
          trending = false;
          yelp = false;
          weather = false;
        };
      };
    };

    dom = {
      disable_window_move_resize = true;
      text_fragments.create_text_fragment.enabled = true;

      security = {
        https_only_mode.upgrade_onion = true;
        https_only_mode_pbm = true;
      };

      timeout = {
        budget_throttling_max_delay = 0;
        throttling_delay = 40;
      };

      webgpu = {
        enabled = true;
        service-workers.enabled = true;
      };
    };

    extensions = {
      postDownloadThirdPartyPrompt = false;
      enabledScopes = 7;

      webcompat-reporter.newIssueEndpoint = " ";
      webextensions.restrictedDomains = " ";

      pocket = {
        quarantinedDomains.enabled = false;
        showHome = false;

        site = " ";
        api = " ";
        oAuthConsumerKey = " ";
      };
    };

    general = {
      autoScroll = false;
      useragent.compatMode.firefox = true;
    };

    gfx = {
      webgpu.ignore-blocklist = true;
      content.skia-font-cache-size = 80;

      canvas.accelerated = {
        cache-items = 32768;
        cache-size = 4096;
      };

      webrender = {
        all = true;
        precache-shaders = true;
        program-binary-disk = true;
        quality.force-subpixel-aa-where-possible = true;

        "compositor" = true;
        "compositor.force-enabled" = true;
      };
    };

    image = {
      cache.size = 10485760;

      mem = {
        decode_bytes_at_a_time = 65536;
        shared.unmap.min_expiration_ms = 120000;
      };
    };

    javascript.options = {
      baselinejit.threshold = 50;
      concurrent_multiprocess_gcs.cpu_divisor = 8;
      ion.threshold = 5000;
    };

    layout = {
      spellcheckDefault = 2;

      css = {
        grid-template-masonry-value.enabled = true;
        moz-document.content.enabled = true;
      };
    };

    layers = {
      acceleration.force-enabled = true;
      mlgpu.enabled = true;

      gpu-process = {
        enabled = true;
        force-enabled = true;
      };
    };

    media = {
      autoplay.default = 5;
      hardware-video-decoding.force-enabled = true;

      gpu-process-decoder = true;
      gpu-process-encoder = true;

      cache_readahead_limit = 7200;
      cache_resume_threshold = 3600;

      memory_cache_max_size = 1048576;
      memory_caches_combined_limit_kb = 3145728;
      memory_caches_combined_limit_pc_sysmem = 10;
    };

    network = {
      connectivity-service.enabled = false;
      captive-portal-service.enabled = cfgTravel;

      auth.subresource-http-auth-allow = 1;
      ssl_tokens_cache_capacity = 32768;
      trr.mode = 2;

      buffer.cache = {
        count = 48;
        size = 65535;
      };

      dnsCacheEntries = 1000;
      dnsCacheExpirationGracePeriod = 240;
      dnsCacheExpiration = 3600;

      http = {
        referer.XOriginTrimmingPolicy = 2;

        max-connections = 1800;
        max-persistent-connections-per-proxy = 48;
        max-persistent-connections-per-server = 10;
        max-urgent-start-excessive-connections-per-host = 5;

        pacing.requests = {
          enabled = false;

          burst = 14;
          min-parallelism = 10;
        };
      };

      predictor = {
        enable-prefetch = true;

        max-resources-per-entry = 250;
        max-uri-length = 1000;

        preconnect-min-confidence = 20;
        preresolve-min-confidence = 10;

        prefetch-force-valid-for = 3600;
        prefetch-min-confidence = 30;
        prefetch-rolling-load-count = 120;
      };
    };

    nglayout.initialpaint = {
      delay = 0;
      delay_in_oopif = 0;
    };

    permissions = {
      manager.defaultsUrl = " ";

      default = {
        desktop-notification = 2;
        shortcuts = 2;
        xr = 2;
      };
    };

    privacy = {
      donottrackheader.enabled = true;
      globalprivacycontrol.enabled = true;
    };

    security = {
      cert_pinning.enforcement_level = 2;

      OCSP = {
        require = true;
        enabled = 2;
      };

      ssl = {
        require_safe_negotiation = true;
        treat_unsafe_negotiation_as_broken = true;
      };
    };

    signon = {
      autofillForms = false;
      formlessCapture.enabled = false;
      management.page.breach-alerts.enabled = false;
    };

    toolkit.telemetry = {
      cachedClientID = " ";
      server_owner = " ";
    };

    widget = {
      gtk.non-native-titlebar-buttons.enabled = true;

      use-xdg-desktop-portal = {
        file-picker = 1;
        mime-handler = 1;
        open-uri = 1;
      };
    };

    zen = {
      view.experimental-no-window-controls = true;
      welcome-screen.seen = true;

      urlbar = {
        behavior = "float";
        show-pip-button = true;
      };

      workspaces = {
        continue-where-left-off = true;
        separate-essentials = false;
      };
    };
  };
}
