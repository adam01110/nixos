_:
# Configure sudo-rs and disable classic sudo.
{
  security = {
    sudo.enable = false;

    sudo-rs = {
      enable = true;
      execWheelOnly = true;

      # Use explicit defaults for environment reset, password feedback, and insults.
      extraConfig = ''
        Defaults env_reset,pwfeedback,insults
      '';
    };
  };
}
