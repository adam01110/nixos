{
  # keep-sorted start
  inputs,
  lib,
  # keep-sorted end
  ...
}: final: _prev:
import ../pkgs {
  inherit
    # keep-sorted start
    inputs
    lib
    # keep-sorted end
    ;

  pkgs = final;
}
