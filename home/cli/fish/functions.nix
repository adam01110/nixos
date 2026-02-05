{
  lib,
  pkgs,
  ...
}:
# Fish shell function definitions.
let
  inherit (builtins) readFile;
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) replaceVars;

  # Helper to generate fish functions from template files with variable substitution.
  mkFunction = {
    description,
    file,
    withMkdir ? false,
    ...
  } @ fnArgs: {
    inherit description;
    body = readFile (
      replaceVars file (
        let
          commonReplaceVars = {
            echo = getExe' pkgs.coreutils "echo";
            test = getExe' pkgs.coreutils "test";
          };
          args = removeAttrs fnArgs [
            "description"
            "file"
            "withMkdir"
          ];
        in
          (
            if withMkdir
            then commonReplaceVars // {mkdir = getExe' pkgs.coreutils "mkdir";}
            else commonReplaceVars
          )
          // args
      )
    );
  };
in {
  # Define custom fish functions with descriptions for shell integration.
  programs.fish.functions = {
    fish_greeting = {
      description = "Greeting to show when starting a fish shell.";
      body = let
        fortune = getExe pkgs.fortune;
        boxes = getExe pkgs.boxes;
      in "${fortune} -s | ${boxes} -d ansi";
    };

    # Tar.
    tar = mkFunction {
      description = "Custom tar function.";
      file = ./functions/tar.fish;
      tar = getExe pkgs.gnutar;
    };

    untar = mkFunction {
      description = "Custom untar function.";
      file = ./functions/untar.fish;
      tar = getExe pkgs.gnutar;
      withMkdir = true;
    };

    # Zip.
    zip = mkFunction {
      description = "Custom zip function.";
      file = ./functions/zip.fish;
      zip = getExe pkgs.zip;
    };

    unzip = mkFunction {
      description = "Custom unzip function.";
      file = ./functions/unzip.fish;
      unzip = getExe pkgs.unzip;
      withMkdir = true;
    };

    # Rar.
    rar = mkFunction {
      description = "Custom rar function.";
      file = ./functions/rar.fish;
      rar = getExe pkgs.rar;
    };

    unrar = mkFunction {
      description = "Custom unrar function.";
      file = ./functions/unrar.fish;
      unrar = getExe' pkgs.rar "unrar";
      withMkdir = true;
    };

    # 7z.
    "7z" = mkFunction {
      description = "Custom 7z function.";
      file = ./functions/7z.fish;
      sevenzip = getExe pkgs._7zz;
    };

    un7z = mkFunction {
      description = "Custom un7z function.";
      file = ./functions/un7z.fish;
      sevenzip = getExe pkgs._7zz;
      withMkdir = true;
    };
  };
}
