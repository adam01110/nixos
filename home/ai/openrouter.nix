{config, ...}: let
  inherit (builtins) toJSON;
in {
  sops = {
    secrets."openrouter_key" = {};

    templates."openrouter_key".content = toJSON {
      openrouter = {
        type = "api";
        key = config.sops.placeholder."openrouter_key";
      };
    };
  };
}
