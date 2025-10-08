{ config, pkgs, ... }:

{
  home.username = "focus";
  home.homeDirectory = "/home/focus";
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.fzf
    pkgs.ripgrep
    pkgs.nil
  ];

  home.file = {
    ".config/helix".source = ~/nixfiles/helix;
    ".config/tmux".source = ~/nixfiles/tmux;
  };

  programs.home-manager.enable = true;
  programs.helix.enable = true;
  programs.lazygit.enable = true;
  programs.tmux.enable = true;
  programs.yazi.enable = true;
  programs.zoxide.enable = true;
  programs.zk.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
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
  };
}
