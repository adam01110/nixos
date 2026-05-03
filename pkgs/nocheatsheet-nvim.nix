{
  fetchFromGitHub,
  lib,
  vimUtils,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "noCheatSheet.nvim";
  version = "0-unstable-2026-05-03";

  src = fetchFromGitHub {
    owner = "adam01110";
    repo = "noCheatSheet.nvim";
    rev = "643a015f8e68d4decfdb2d110769e214e4df6fd1";
    hash = "sha256-QnSsvSBWWGIWoGiVoprrC1EfO114lE5hJItVNmvkvfY=";
  };

  meta = {
    description = "Standalone NvChad-style cheatsheet for Neovim";
    homepage = "https://github.com/adam01110/noCheatSheet.nvim";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
