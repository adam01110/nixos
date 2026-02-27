{pkgs, ...}:
# System cursor fallback configuration.
{
  xdg = {
    # Fallback cursor to keep cursors.
    icons.fallbackCursorThemes = ["Bibata-Modern-Classic"];
  };

  environment = {
    # Ensure the cursor theme is present system-wide.
    systemPackages = [pkgs.nur.repos.adam0.bibata-modern-cursors-classic];
  };
}
