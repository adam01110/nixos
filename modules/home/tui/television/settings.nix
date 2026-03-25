_: {
  programs.television.settings.ui = let
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
