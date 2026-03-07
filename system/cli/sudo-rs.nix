_:
# Configure sudo-rs and disable classic sudo.
{
  security = {
    sudo.enable = false;

    sudo-rs = {
      enable = true;
      execWheelOnly = true;

      # Enable password feedback.
      extraConfig = ''
        Defaults env_reset,pwfeedback
      '';
    };
  };
}
