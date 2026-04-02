---
name: nix-search
description: Search and query NixOS packages and options using nix-search-tv. Use when you need to find packages, get package details, view source code locations, or inspect NixOS, Home Manager, and configured flake option indexes.
---

# Nix Search

This skill helps you search NixOS packages and options using `nix-search-tv`, a tool that indexes packages and options from `nixpkgs`, platform docs, and locally configured flake sources.

## Available Indexes

Common builtins:

- `nixpkgs` for packages.
- `home-manager` for Home Manager options.
- `nixos` for NixOS options.
- `darwin` for nix-darwin options.
- `noogle` for function and library docs.

Configured flake indexes:

- `disko` for Disko NixOS options.
- `home-manager-flake` for Home Manager flake docs.
- `home-manager-nixos` for the Home Manager NixOS module.
- `lanzaboote` for Lanzaboote NixOS options.
- `nix-flatpak` for the nix-flatpak Home Manager module.
- `nix-index-database` for the nix-index-database Home Manager module.
- `nixcord` for nixcord options.
- `noctalia` for the Noctalia Home Manager module.
- `nvf` for NVF options.
- `overzicht` for the Overzicht Home Manager module.
- `sops-nix` for SOPS NixOS options.
- `sops-nix-home-manager` for SOPS Home Manager options.
- `spicetify-nix` for Spicetify Home Manager options.
- `stylix-nixos` for Stylix NixOS options.
- `zed-extensions` for Zed extensions Home Manager options.
- `zen-browser` for the Zen Browser Home Manager module.

## Commands

### 1. List Available Packages or Options

Use `print` to list entries from one or more indexes:

```bash
nix-search-tv print --indexes nixpkgs
nix-search-tv print --indexes nixos
nix-search-tv print --indexes nixpkgs,home-manager
```

Use cached data without refetching:

```bash
nix-search-tv print --offline --indexes nixpkgs
```

Search through package names:

```bash
nix-search-tv print --indexes nixpkgs | grep -i firefox
```

The first run downloads and indexes data, so it can take a few minutes.

### 2. Get Package or Option Details

Use `preview` to inspect a package or option:

```bash
nix-search-tv preview --indexes nixpkgs firefox
nix-search-tv preview --indexes nixos boot.loader.systemd-boot.enable
```

Use JSON output for automation:

```bash
nix-search-tv preview --indexes nixpkgs --json firefox
```

The `--json` flag returns structured output and includes the selected key in `_key`.

### 3. Get Source Code Location

Use `source` to get the source location for a package or option:

```bash
nix-search-tv source --indexes nixpkgs firefox
```

With offline mode:

```bash
nix-search-tv source --offline --indexes nixpkgs firefox
```

### 4. Get Homepage

Use `homepage` to get a package homepage URL:

```bash
nix-search-tv homepage --indexes nixpkgs firefox
```

With offline mode:

```bash
nix-search-tv homepage --offline --indexes nixpkgs firefox
```

## Tips

- First run downloads and indexes data. Later runs reuse the cache.
- When multiple indexes are selected, results may be prefixed with the index name.
- Set `NO_COLOR=1` to disable ANSI colors in command output.
- Use `--offline` when you want fast cached lookups.
- Use `--json` with `preview` when the result will be parsed by tools.

## Agent Usage Patterns

### Efficient cached lookup

```bash
nix-search-tv preview --offline --indexes nixpkgs --json firefox | jq -r '.description'
```

### Search and get source in one pipeline

```bash
PACKAGE=$(nix-search-tv print --offline --indexes nixpkgs | grep -i neovim | head -1)
nix-search-tv source --offline --indexes nixpkgs "$PACKAGE"
```

### Inspect configured flake indexes

```bash
nix-search-tv print --offline --indexes stylix-nixos
nix-search-tv preview --offline --indexes zen-browser enable
```

## Troubleshooting

`cache.txt` not found: run `nix-search-tv print --indexes <index>` to trigger initial indexing.

Stale data: remove the relevant cache directory and rerun a query:

```bash
rm -rf ~/.cache/nix-search-tv/<index-name>
nix-search-tv print --indexes <index-name>
```

Multiple indexes causing ambiguity: use an explicit `--indexes` list.
