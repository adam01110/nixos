{
  # keep-sorted start
  inputs,
  lib,
  # keep-sorted end
  ...
}: final: _prev:
# Expose ./pkgs as top-level pkgs.* entries.
import ../pkgs {
  inherit
    # keep-sorted start
    inputs
    lib
    # keep-sorted end
    ;

  pkgs = final;
}
