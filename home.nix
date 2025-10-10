{ config, pkgs, lib, ... }:

{
  home.username = "cheva";
  home.homeDirectory = "/home/cheva";
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    fzf
    ripgrep
    nil
    gopls
    delve
    gotools
    golangci-lint
    golangci-lint-langserver
  ];

  home.file = {
    ".ssh/known_hosts".source = ~/nixfiles/ssh/known_hosts;
    ".config/helix".source = ~/nixfiles/helix;
    ".config/lazygit".source = ~/nixfiles/lazygit;
    ".config/tmux".source = ~/nixfiles/tmux;
    ".config/wezterm".source = ~/nixfiles/wezterm;
  };

  programs.home-manager.enable = true;
  programs.helix.enable = true;
  programs.lazygit.enable = true;
  programs.tmux.enable = true;
  programs.yazi.enable = true;
  programs.zoxide.enable = true;
  programs.zk.enable = true;
  programs.go.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      if not set -q SSH_AUTH_SOCK
        ssh-add -q ~/.ssh/id_ed25519
      end
    '';
  };

  # Launch fish from bash
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.git = {
    enable = true;
    userName = "Kai Chevannes";
    userEmail = "chevannes.kai@gmail.com";
    signing = {
      key = "~/.ssh/id_ed25519";
      format = "ssh";
      signByDefault = true;
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      add_newline = false;
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
    ZK_NOTEBOOK_DIR = ~/zettel;
  };

  services.ssh-agent.enable = true;

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ "$(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip')" ]; then
      WIN_HOME="/mnt/c/Users/$(whoami)"
      if [ -d "$WIN_HOME" ]; then
        cp "$HOME/nixfiles/wezterm/wezterm.lua" "$WIN_HOME/.wezterm.lua"
      fi
    fi
  '';
}
