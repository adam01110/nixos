{
  fetchFromGitHub,
  lib,
  vimUtils,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "noCheatSheet.nvim";
  version = "0-unstable-2026-05-01";

  src = fetchFromGitHub {
    owner = "adam01110";
    repo = "noCheatSheet.nvim";
    rev = "3d3f7a63128cd5d9d15f874997f3ab2728ed3dc5";
    hash = "sha256-svFBEYbc8pYPk1ee/eG/dKowE3UKg4lKYMr7Forvux0=";
  };

  meta = {
    description = "Standalone NvChad-style cheatsheet for Neovim";
    homepage = "https://github.com/adam01110/noCheatSheet.nvim";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
