{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
in {
  # Override commands with preferred tools.
  programs.fish.shellAliases = let
    # keep-sorted start
    bunx = getExe' pkgs.bun "bunx";
    ripgrep = getExe pkgs.ripgrep;
    # keep-sorted end
  in {
    # keep-sorted start
    cat = getExe pkgs.bat;
    egrep = ripgrep;
    fgrep = "${ripgrep} -F";
    grep = ripgrep;
    inherit bunx;
    npx = bunx;
    wget = getExe' pkgs.curl "wcurl";
    # keep-sorted end

    speedtest = getExe pkgs.speedtest-go;

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    "......." = "cd ../../../../../..";
  };
}
