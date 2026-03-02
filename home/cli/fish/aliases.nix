{
  lib,
  pkgs,
  ...
}:
# Configure some aliases for the fish shell.
let
  inherit
    (lib)
    getExe
    getExe'
    ;
in {
  # Override commands with preferred tools.
  programs.fish.shellAliases = let
    ripgrep = getExe pkgs.ripgrep;
  in {
    wget = getExe' pkgs.curl "wcurl";
    cat = getExe pkgs.bat;
    grep = ripgrep;
    egrep = ripgrep;
    fgrep = "${ripgrep} -F";

    speedtest = getExe pkgs.speedtest-go;
    cpond = "${getExe pkgs.nur.repos.adam0.cpond} -b -c 16";

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    "......." = "cd ../../../../../..";
  };
}
