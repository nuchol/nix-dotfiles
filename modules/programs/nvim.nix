{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nvim;
in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      ripgrep

      # Formatters
      stylua
      shfmt

      # LSP servers
      lua-language-server
      clang-tools
      typescript-language-server
      tinymist
      rust-analyzer
      nixd
    ];
  };
}

