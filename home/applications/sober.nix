{ ... }:

# configure sober flatpak.
{
  # add flatpak packge.
  services.flatpak = {
    packages = [ "org.vinegarhq.Sober" ];

    # set flatpak overrides for discord rpc
    overrides."org.vinegarhq.Sober".Context.filesystems = [
      "xdg-run/app/com.discordapp.Discord:create"
      "xdg-run/discord-ipc-0"
    ];
  };
}
