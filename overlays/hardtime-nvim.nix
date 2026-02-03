_: _final: prev:
# patch hardtime.nvim to avoid per-key which-key require.
{
  vimPlugins =
    prev.vimPlugins
    // {
      hardtime-nvim = prev.vimPlugins.hardtime-nvim.overrideAttrs (old: {
        patches = (old.patches or []) ++ [../patches/hardtime-nvim-no-which-key-require.patch];
      });
    };
}
