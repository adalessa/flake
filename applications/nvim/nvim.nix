pkgs:
{
  enable = true;
  vimAlias = true;
  withNodeJs = true;
  withPython3 = true;

  extraConfig = ''ru start.lua'';

  # This install all the plugins without an external plugin manager
  plugins = with pkgs.vimPlugins; [

    # Telescope
    telescope-nvim
    telescope-file-browser-nvim
    telescope-fzy-native-nvim
    telescope-fzf-native-nvim
    telescope-fzf-writer-nvim
    telescope-ui-select-nvim
    nvim-neoclip-lua

    impatient-nvim

    # Complettition
    nvim-cmp
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-nvim-lsp
    luasnip
    cmp_luasnip
    nvim-autopairs
    lspkind-nvim

    # Treesitter
    nvim-treesitter
    nvim-treesitter-refactor
    playground
    nvim-web-devicons

    # test
    vim-test

    vim-surround
    vim-commentary

    # Theme
    nightfox-nvim

    # Git
    gitsigns-nvim
    vim-fugitive
    git-worktree-nvim

    # LSP
    nvim-lspconfig
    null-ls-nvim
  ];
  extraPackages = with pkgs; [
    tree-sitter
    python39Full
    # nix
    rnix-lsp

    # PHP
    nodePackages.intelephense
    php81Packages.phpcs
    php81Packages.phpstan
    php81Packages.php-cs-fixer

    # Lua
    stylua
    sumneko-lua-language-server

    # Golang
    golangci-lint
    gopls
  ];
}
