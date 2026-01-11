{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) writeShellApplication;
in {
  sops = {
    secrets = {
      "ai/github_access_token" = {};
      "ai/context7_key" = {};
    };
  };

  programs.mcp = {
    enable = true;

    servers = let
      cat = getExe' pkgs.coreutils "cat";
    in {
      nix.command = getExe inputs.mcp-nixos.packages.${system}.mcp-nixos;

      context7.command = getExe (writeShellApplication {
        name = "context7-mcp-wrapper";
        text = ''
          CONTEXT7_API_KEY="$(${cat} "${config.sops.secrets."ai/context7_key".path}")"
          export CONTEXT7_API_KEY
          exec "${getExe' inputs.mcp-servers-nix.packages.${system}.context7-mcp "context7-mcp"}" "$@"
        '';
      });

      git.command = getExe' inputs.mcp-servers-nix.packages.${system}.mcp-server-git "mcp-server-git";

      github = {
        command = getExe (writeShellApplication {
          name = "github-mcp-server-wrapper";
          text = ''
            GITHUB_PERSONAL_ACCESS_TOKEN="$(${cat} "${config.sops.secrets."ai/github_access_token".path}")"
            export GITHUB_PERSONAL_ACCESS_TOKEN
            exec "${getExe pkgs.github-mcp-server}" "$@"
          '';
        });

        args = ["stdio" "--dynamic-toolsets" "--read-only"];
      };
    };
  };
}
