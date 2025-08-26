{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "[](fg:base01)"
        "$hostname"
        "[/](fg:text bg:base01)"
        "$username"
        "[](fg:base01)"

        "[ ](#00000000)"
        "[](fg:base01)"
        "$os"
        "[ ](bg:base01)"
        "$shell"
        "[](fg:base01)"

        "$nix_shell"

        "$container"
        "$docker_context"

        "$directory"
        "$sudo"
        "$jobs"

        "$fossil_branch"
        "[ ](#00000000)"
        "[](fg:base01)"
        "$git_branch"
        "[ ](bg:base01)"
        "$git_commit"
        "$git_state"
        "$git_status"
        "[](fg:base01)"

        "$package"

        "$bun"
        "$deno"
        "$nodejs"

        "$cmake"
        "$gradle"
        "$meson"

        "$c"
        "$cpp"
        "$dart"
        "$dotnet"
        "$golang"
        "$haskell"
        "$haxe"
        "$java"
        "$kotlin"
        "$lua"
        "$perl"
        "$php"
        "$python"
        "$ruby"
        "$rust"
        "$swift"
        "$zig"

        "$character"
      ];

      character = {
        format = "$symbol ";
        success_symbol = "[➜](bold base0B)";
        error_symbol = "[➜](bold base08)";
        vimcmd_symbol = "[](bold base0B)";
        vimcmd_replace_one_symbol = "[](bold base0E)";
        vimcmd_replace_symbol = "[](bold base0E)";
        vimcmd_visual_symbol = "[](bold base0A)";
      };

      cmd_duration = {
        format = "[ ](#00000000)[](fg:base01)[$duration]($style)[](fg:base01)";
        style = "bg:base01 fg:bold base0A";
        min_time = 500;
      };

      directory = {
        format = "[ ](#00000000)[](fg:base01)[$path]($style)[$read_only]($read_only_style)[](fg:base01)";
        style = "bg:base01 fg:bold base0D";
        read_only = " ";
        read_only_style = "bg:base01 fg:bold base08";
        truncation_length = 2;
        truncation_symbol = "…/";
        truncate_to_repo = true;
      };

      direnv = {
        disabled = false;
        format = "[ ](#00000000)[](fg:base01)[$symbol$loaded/$allowed]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base09";
      };

      hostname = {
        format = "[$ssh_symbol$hostname]($style)";
        style = "bg:base01 fg:bold base0B";
        ssh_symbol = "󰖟 ";
        ssh_only = false;
      };

      jobs = {
        format = "[ ](#00000000)[](fg:base01)[$symbol$number]($style)[](fg:base01)";
        symbol = "󱜯 ";
        style = "bg:base01 fg:bold base0D";
      };

      nix_shell = {
        format = "[ ](#00000000)[][$symbol$state( \\($name\\))]($style)[](fg:base01)";
        symbol = "󱄅 ";
        style = "bg:base01 fg:bold base0D";
        heuristic = true;
      };

      os = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bg:base01 fg:bold base04";

        symbols = {
          Linux = "";
          NixOS = "";
          Windows = "";
          Macos = "";
          Android = "";
        };
      };

      package = {
        format = "[ ](#00000000)[](fg:base01)[$symbol$version]($style)[](fg:base01)";
        symbol = "󰏗 ";
        style = "bg:base01 fg:bold base09";
        display_private = true;
      };

      shell = {
        disabled = false;
        format = "[$indicator]($style)";
        bash_indicator = "";
        fish_indicator = "";
        zsh_indicator = "";
        powershell_indicator = "󰨊";
        cmd_indicator = "";
        nu_indicator = "󰟆 ";
        unknown_indicator = "";
      };

      sudo = {
        disabled = false;
        format = "[ ](#00000000)[](fg:base01)[$symbol]($style)[](fg:base01)";
        symbol = "";
        style = "bg:base01 fg:bold base0A";
      };

      username = {
        format = "[$user]($style)";
        style_root = "bg:base01 fg:bold base08";
        style_user = "bg:base01 fg:bold base0D";
        show_always = true;
      };

      # languages
      c = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version(-$name))]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0D";
      };

      cpp = {
        disabled = false;
        format = "[ ](#00000000)[](fg:base01)[$symbol($version(-$name))]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0B";
      };

      dart = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0D";
      };

      dotnet = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)( $tfm)]($style)[](fg:base01)";
        symbol = "󰪮 ";
        style = "bg:base01 fg:bold base0D";
      };

      golang = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0C";
        not_capable_style = "bg:base01 fg:bold base08";
      };

      haskell = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰲒 ";
        style = "bg:base01 fg:bold base0E";
      };

      haxe = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base08";
      };

      java = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰅶 ";
        style = "bg:base01 fg:bold base08";
      };

      kotlin = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󱈙 ";
        style = "bg:base01 fg:bold base09";
      };

      lua = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰢱 ";
        style = "bg:base01 fg:bold base0D";
      };

      perl = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base09";
      };

      php = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0D";
      };

      python = {
        format = "[ ](#00000000)[](fg:base01)[$symbol$pyenv_prefix($version)( \\($virtualenv\\))]($style)[](fg:base01)";
        symbol = "󰌠 ";
        style = "bg:base01 fg:bold base0A";
        pyenv_version_name = true;
        pyenv_prefix = "uv";
      };

      ruby = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base08";
      };

      rust = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󱘗 ";
        style = "bg:base01 fg:bold base09";
      };

      swift = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰛥 ";
        style = "bg:base01 fg:bold base09";
      };

      zig = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0A";
      };

      # containers
      container = {
        format = "[ ](#00000000)[](fg:base01)[$symbol \\[$name\\]]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0D";
      };

      docker_context = {
        format = "[ ](#00000000)[](fg:base01)[$symbol$context]($style)[](fg:base01)";
        symbol = "󰡨 ";
        style = "bg:base01 fg:bold base0D";
      };

      # runtimes
      bun = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0A";
      };

      deno = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0B";
      };

      nodejs = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰎙 ";
        style = "bg:base01 fg:bold base0B";
        not_capable_style = "bg:base01 fg:bold base08";
      };

      # build systems
      cmake = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = "󰔶 ";
        style = "bg:base01 fg:bold base08";
      };

      gradle = {
        format = "[ ](#00000000)[](fg:base01)[$symbol($version)]($style)[](fg:base01)";
        symbol = " ";
        style = "bg:base01 fg:bold base0C";
      };

      meson = {
        format = "[ ](#00000000)[](fg:base01)[$symbol$project]($style)[](fg:base01)";
        symbol = "⬢ ";
        style = "bg:base01 fg:bold base0D";
      };

      # git
      fossil_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        style = "bold base0E";
      };

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style)";
        symbol = " ";
        style = "bg:base01 fg:bold base0E";
      };

      git_commit = {
        format = "[\\($hash$tag\\)]($style)";
        style = "bg:base01 fg:bold base0B";
        tag_disabled = false;
        only_detached = false;
        tag_symbol = "  ";
      };

      git_state = {
        format = "[ $state( $progress_current/$progress_total)]($style)";
        style = "bg:base01 fg:bold base0A";
        rebase = "rebasing";
        merge = "merging";
        revert = "reverting";
        cherry_pick = "cherry-picking";
        bisect = "bisecting";
        am = "am";
        am_or_rebase = "am/rebase";
      };

      git_status = {
        format = "([ \\[$all_status$ahead_behind\\]]($style))";
        style = "bg:base01 fg:bold base08";
        deleted = "";
      };

      # disabled
      aws.disabled = true;
      battery.disabled = true;
      buf.disabled = true;
      cobol.disabled = true;
      conda.disabled = true;
      crystal.disabled = true;
      daml.disabled = true;
      elixir.disabled = true;
      elm.disabled = true;
      env_var.disabled = true;
      erlang.disabled = true;
      fennel.disabled = true;
      fill.disabled = true;
      fossil_metrics.disabled = true;
      gcloud.disabled = true;
      gleam.disabled = true;
      guix_shell.disabled = true;
      helm.disabled = true;
      julia.disabled = true;
      kubernetes.disabled = true;
      mojo.disabled = true;
      nats.disabled = true;
      netns.disabled = true;
      nim.disabled = true;
      ocaml.disabled = true;
      odin.disabled = true;
      opa.disabled = true;
      openstack.disabled = true;
      pixi.disabled = true;
      pulumi.disabled = true;
      purescript.disabled = true;
      quarto.disabled = true;
      rlang.disabled = true;
      raku.disabled = true;
      red.disabled = true;
      scala.disabled = true;
      singularity.disabled = true;
      solidity.disabled = true;
      spack.disabled = true;
      terraform.disabled = true;
      typst.disabled = true;
      vagrant.disabled = true;
      vlang.disabled = true;
      vcsh.disabled = true;
    };
  };
}
