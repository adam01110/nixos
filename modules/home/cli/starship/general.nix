_:
# Core prompt symbols and common modules.
{
  programs.starship.settings = {
    # keep-sorted start block=yes newline_separated=yes
    character = {
      format = "$symbol ";
      # keep-sorted start
      error_symbol = "[➜](fg:red bold)";
      success_symbol = "[➜](fg:green bold)";
      vimcmd_replace_one_symbol = "[](fg:magenta bold)";
      vimcmd_replace_symbol = "[](fg:magenta bold)";
      vimcmd_symbol = "[](fg:green bold)";
      vimcmd_visual_symbol = "[](fg:yellow bold)";
      # keep-sorted end
    };

    cmd_duration = {
      format = "[ ](#00000000)[ ](bg:base01)[$duration]($style)[ ](bg:base01)";
      style = "bg:base01 fg:yellow bold";
      min_time = 500;
    };

    directory = {
      format = "[ ](#00000000)[ ](bg:base01)[$path]($style)[$read_only]($read_only_style)[ ](bg:base01)";
      style = "bg:base01 fg:blue bold";
      read_only = " ";
      read_only_style = "bg:base01 fg:red bold";
      truncate_to_repo = true;
      truncation_length = 2;
      truncation_symbol = "…/";
    };

    direnv = {
      disabled = false;
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$loaded( \\($allowed\\))]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:base09";
    };

    hostname = {
      format = "[$ssh_symbol$hostname]($style)";
      style = "bg:base01 fg:green bold";
      ssh_symbol = "󰖟 ";
      ssh_only = false;
    };

    jobs = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$number]($style)[ ](bg:base01)";
      symbol = "󱜯 ";
      style = "bg:base01 fg:blue bold";
    };

    nix_shell = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$state( \\($name\\))]($style)[ ](bg:base01)";
      symbol = "󱄅 ";
      style = "bg:base01 fg:blue bold";
      heuristic = true;
    };

    os = {
      disabled = false;
      format = "[$symbol]($style)";
      style = "bg:base01 fg:base04 bold";

      symbols = let
        # keep-sorted start
        apple = "";
        linux = "";
        redhat = "󱄛";
        # keep-sorted end
      in {
        # keep-sorted start
        Android = "";
        Linux = linux;
        NixOS = "󱄅";
        Unknown = "";
        Windows = "";
        # keep-sorted end

        # keep-sorted start
        AlmaLinux = "";
        Alpine = "";
        Arch = "";
        Artix = "";
        CachyOS = linux;
        CentOS = "";
        Debian = "";
        Elementary = "";
        EndeavourOS = "";
        Fedora = "";
        Garuda = "";
        Gentoo = "";
        Kali = "";
        Manjaro = "";
        Mint = "󰣭";
        Nobara = "";
        PikaOS = linux;
        Pop = "";
        Raspbian = "";
        RedHatEnterprise = redhat;
        Redhat = redhat;
        RockyLinux = "";
        SUSE = "";
        Solus = "";
        Ubuntu = "";
        Void = "";
        Zorin = "";
        openSUSE = "";
        # keep-sorted end

        # keep-sorted start
        Ios = apple;
        Macos = apple;
        # keep-sorted end

        # keep-sorted start
        FreeBSD = "";
        OpenBSD = "";
        # keep-sorted end
      };
    };

    package = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$version]($style)[ ](bg:base01)";
      symbol = "󰏗 ";
      style = "bg:base01 fg:base09 bold";
      display_private = true;
    };

    shell = {
      disabled = false;
      format = "[$indicator]($style)";
      # keep-sorted start
      bash_indicator = "";
      cmd_indicator = "";
      fish_indicator = "";
      nu_indicator = "󰟆 ";
      powershell_indicator = "󰨊";
      unknown_indicator = "";
      zsh_indicator = "";
      # keep-sorted end
      style = "bg:base01 fg:base04 bold";
    };

    sudo = {
      disabled = false;
      format = "[ ](#00000000)[ ](bg:base01)[$symbol]($style)[ ](bg:base01)";
      symbol = "";
      style = "bg:base01 fg:yellow bold";
    };

    username = {
      format = "[$user]($style)";
      style_root = "bg:base01 fg:base08 bold";
      style_user = "bg:base01 fg:blue bold";
      show_always = true;
    };
    # keep-sorted end
  };
}
