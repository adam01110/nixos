_: {
  programs.television.settings.ui = let
    # Use minimal box borders to match the rest of the terminal theme.
    borderType = "plain";
  in {
    input_bar = {
      # keep-sorted start
      border_type = borderType;
      prompt = "➜";
      # keep-sorted end
    };

    # keep-sorted start
    preview_panel.border_type = borderType;
    results_panel.border_type = borderType;
    # keep-sorted end
  };
}
