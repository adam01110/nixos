{
  description = "Adam0's nixos configuration.";

  inputs = {
    # keep-sorted start block=yes newline_separated=yes
    determinate = {
      url = "github:DeterminateSystems/nix-src";
      inputs.flake-parts.follows = "flake-parts";
    };

    disko = {
      url = "github:nix-community/disko?ref=latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins?ref=6acc0738f298f5efe40a99db2c12449112d65633";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.54.3";

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    import-tree.url = "github:vic/import-tree";

    lanzaboote = {
      url = "github:nix-community/lanzaboote?ref=v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel?ref=release";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-userstyles = {
      url = "github:adam01110/nix-userstyles";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
        # keep-sorted end
      };
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        # keep-sorted end
      };
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell?ref=v4.7.6";
      inputs = {
        # keep-sorted start
        nixpkgs.follows = "nixpkgs";
        noctalia-qs.follows = "noctalia-qs";
        # keep-sorted end
      };
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs = {
        # keep-sorted start
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
        # keep-sorted end
      };
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        # keep-sorted end
      };
    };

    nvf = {
      # url = "github:notashelf/nvf";
      url = "github:adam01110/nvf?ref=personal";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        # keep-sorted end
      };
    };

    overzicht = {
      url = "github:adam01110/overzicht";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
        # keep-sorted end
      };
    };

    oxicord = {
      url = "github:linuxmobile/oxicord";
      inputs = {
        # keep-sorted start
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        # keep-sorted end
      };
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        # keep-sorted start
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        # keep-sorted end
      };
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        # keep-sorted start
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nur.follows = "nur";
        systems.follows = "systems";
        # keep-sorted end
      };
    };

    systems.url = "github:nix-systems/default";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    tuigreet = {
      url = "github:notashelf/tuigreet?ref=0.10.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake?ref=beta";
      inputs = {
        # keep-sorted start
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        # keep-sorted end
      };
    };
    # keep-sorted end
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [(inputs.import-tree ./flake)];
    };
}
