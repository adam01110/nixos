_:
# Configure sober flatpak.
let
  pkg = "org.vinegarhq.Sober";
in {
  # Add flatpak packge.
  services.flatpak = {
    # keep-sorted start block=yes newline_separated=yes
    # Set flatpak overrides for discord rpc.
    overrides.${pkg}.Context.filesystems = [
      # keep-sorted start
      "xdg-run/app/com.discordapp.Discord:create"
      "xdg-run/discord-ipc-0"
      # keep-sorted end
    ];

    packages = [pkg];
    # keep-sorted end
  };
}
