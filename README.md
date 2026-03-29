<div align="center">
  <img src="./face.png" alt="Project avatar" width="112" />

  # adam0's NixOS configuration

  Modular multi-host NixOS and Home Manager flake for desktop, laptop, and virtual machine systems.

  [Overview](#overview) - [Layout](#layout) - [Hosts](#hosts) - [Usage](#usage) - [Secrets](#secrets)
</div>

This repository contains a personal NixOS setup built around `flake-parts`, `Home Manager`, and a heavily modular directory layout. It shares a common base across multiple machines, then layers host-specific hardware, service, and desktop overrides on top.

## Overview

- Shared NixOS modules under `modules/system`, Home Manager modules under `modules/home`, and per-host overrides under `modules/hosts`.
- Three flake outputs: `desktop`, `laptop`, and `vm`, all created from the same module stack in `flake/nixos.nix`.
- Declarative storage with Disko, encrypted secrets with SOPS, Secure Boot with Lanzaboote, and theming through Stylix.
- Wayland-first desktop built on Hyprland, UWSM, `greetd` + `tuigreet`, and Noctalia Shell.
- Custom overlays and packages for local tooling, external flake packages, and Hyprland plugin overrides.

## Layout

```text
.
|- flake.nix              # Flake entrypoint and inputs
|- flake/                 # flake-parts modules (hosts, dev shell, formatting)
|- modules/
|  |- system/             # Shared NixOS modules
|  |- home/               # Shared Home Manager modules
|  `- hosts/              # desktop, laptop, vm overrides
|- overlays/              # Local and upstream overlays
|- pkgs/                  # Custom packages exposed through overlays
|- secrets/               # SOPS-encrypted secrets
|- keys/                  # Public keys used for secret recipients
|- vars.nix               # Shared identity and locale values
`- face.png               # Header/avatar asset
```

## Hosts

| Host | Purpose | Notable differences |
| --- | --- | --- |
| `desktop` | Main workstation | ROCm enabled, dual-monitor Hyprland layout, Wooting and Roccat support, AMD + Intel GPU monitoring |
| `laptop` | Mobile system | Wi-Fi, Bluetooth, TLP, SCX, lid switch handling, battery-oriented tuning, touch support |
| `vm` | QEMU/KVM guest | `/dev/vda` Disko target, SSH enabled, guest agents, simplified display setup |

## Usage

From the repository root:

```bash
# Inspect flake outputs
nix flake show

# Apply a host configuration
sudo nixos-rebuild switch --flake .#desktop

# Format the repository
nix fmt

# Enter the dev shell
nix develop
```

> [!IMPORTANT]
> The host modules point at real installation devices such as `/dev/nvme0n1` and `/dev/vda`, and the configuration expects an Age key at `/var/lib/sops-nix/key.txt`. Review `modules/hosts/*/default.nix`, `modules/system/disk.nix`, and `modules/system/sops.nix` before using this on a new machine.

> [!NOTE]
> `direnv` is enabled through `.envrc`, and the default dev shell currently provides `sops` and `tokei`.

## Secrets

- Secrets live in `secrets/secrets.yaml` and are managed with SOPS.
- Recipient rules are defined in `.sops.yaml` for one user key and three host Age keys.
- System modules consume those secrets for items such as the user password, GitHub access tokens, and per-host DNS settings.

Edit flow:

```bash
sops secrets/secrets.yaml
```

## Customization

- Edit shared identity, locale, and Git metadata in `vars.nix`.
- Adjust host-specific hardware and service choices in `modules/hosts/<host>/`.
- Add or override shared behavior in `modules/system/` and `modules/home/`.
- Extend package selection through `pkgs/` and `overlays/`.

## Tooling

- Formatting and linting are wired through `treefmt-nix` in `flake/treefmt.nix`.
- Enabled tools include `alejandra`, `deadnix`, `statix`, `nixf-diagnose`, `biome`, `shfmt`, `shellcheck`, `yamlfmt`, `yamllint`, `stylua`, and `rumdl-format`.
- The repository uses `import-tree` extensively to auto-discover modules, overlays, and local packages.
