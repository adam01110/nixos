# Comment Style Guide

Goals: keep comments concise, consistent, and helpful for future maintainers of this NixOS + Home Manager configuration.

## Scope

- Applies to all `.nix` files in this repo.
- Does not cover documentation prose or commit messages.

## Quick Rules

- Use full‑sentence fragments in present tense, ending with a period.
- Place comments on their own line directly above the code they describe; avoid trailing inline comments.
- Indent the comment to the same level as the code.
- Start with a single `#` and one space; use `# -` for short bullet lists.
- Start comment text in lowercase to match existing repo style.
- Describe purpose or rationale, not just restating the identifier.
- Keep to ASCII; use backticks only for literal commands or identifiers.
- Prefer one short line; only add sub‑bullets when enumerating items.
- Leave a blank line between the module argument set and the first top‑level comment.

## Patterns Seen in This Repo

- File headers that summarize the file’s role:\
  `# flake entrypoint for this nixos + home manager setup.` (flake.nix:2)
- Section headers to group related blocks:\
  `# outputs: expose host configurations and pass through common arguments.` (flake.nix:111)
- Bulleted explanations for lists:

  ````text
  # group memberships:
  # - wheel: administrative access via sudo.
  # - audio: access to sound devices.
  # - networkmanager: control network connections.
  ``` (system/user.nix:26-29)
  ````

- Rationale above templated or generated content:\
  `# template for resolved.conf carrying dns servers from sops.` (system/services/network.nix:30)
- Short labels for config blocks:\
  `# set global flatpak overrides.` (home/services/flatpak.nix:6)

## When to Comment

- Add a comment when intent is not obvious from the name or when a setting is non-default, surprising, or has operational impact.
- Prefer no comment for straightforward attribute assignments whose names are self-explanatory.
- For TODOs, use `# TODO(<owner or reason>): …` and keep them rare; update or remove after the action is done.

## Anti-Patterns to Avoid

- Restating the attribute name (“# enable wifi” above `wifi.enable = true;`).
- Inline trailing comments that break readability, except for opaque literals (e.g., hashes) where adjacency helps.
- Long paragraphs; if more than two lines are needed, consider a doc comment in a README instead.

## Exceptions

- Allow humorous comments and emphasis in modules (example: `# GET OUT OF MY $HOME!`).
- Allow `# ZED` tags for editor-specific settings toggles.
- Allow inline comments inside example blocks in option descriptions.
- Allow package list headings copied from upstream (example: `# WINE`, `# PCSX2`).

## Templates

- Section header:\
  `# <short description>.`
- Bulleted list:

  ```text
  # <topic>:
  # - <item 1>.
  # - <item 2>.
  ```

## Enforcement Tips

- When adding new modules, copy a header pattern from an existing file (e.g., `home/services/flatpak.nix`) to keep tone consistent.
- During reviews, prefer rewriting the comment to match these rules rather than deleting context outright.
