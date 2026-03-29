_:
# Configure television user interface settings.
{
  programs.television.settings.ui = let
    # Use minimal box borders to match the rest of the terminal theme.
    borderType = "plain";
  in {
    input_bar = {
      prompt = "➜";
      border_type = borderType;
    };

    results_panel.border_type = borderType;
    preview_panel.border_type = borderType;
  };
}
