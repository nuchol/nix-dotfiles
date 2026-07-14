{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh
    ];

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };

      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];

      # .zshrc
      initContent = ''
        bindkey '^[[Z' autosuggest-accept
        
        _SSHFS_ZID=z5692989
        _SSHFS_CSE_MOUNT="$HOME/cse"
      '';
    };
  };
}
