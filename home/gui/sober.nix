{...}:
# configure sober flatpak.
let
  pkg = "org.vinegarhq.Sober";
in {
  # add flatpak packge.
  services.flatpak = {
    packages = [pkg];

    # set flatpak overrides for discord rpc.
    overrides.${pkg}.Context.filesystems = [
      "xdg-run/app/com.discordapp.Discord:create"
      "xdg-run/discord-ipc-0"
    ];
  };
}
