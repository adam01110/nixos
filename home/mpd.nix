{
  config,
  lib,
  pkgs,
  ...
}:

let
  nur-no-pkgs =
    import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz")
      { };
in
{
  imports = lib.attrValues nur-no-pkgs.repos.adam.hmModules.yams;

  services = {
    mpd = {
      enable = true;
      network.startWhenNeeded = true;

      extraConfig = ''
        auto_update "yes"

        audio_output {
          type "pipewire"
          name "PipeWire"
        }

        audio_output {
          type "fifo"
          name "Visualiser"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }

        replaygain "auto"
        crossfade 8
      '';
    };

    mpd-discord-rpc.enable = true;
    yams.enable = true;
  };
}
