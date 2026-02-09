_: _final: prev:
# Run superhtml dependency linking after Zig sets the cache path.
{
  superhtml = prev.superhtml.overrideAttrs (old: {
    postPatch = "";
    postConfigure = (old.postConfigure or "") + (old.postPatch or "");
  });
}
