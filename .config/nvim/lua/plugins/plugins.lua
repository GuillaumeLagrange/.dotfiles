return {
  -- Vim plugins

  "windwp/nvim-autopairs",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-commentary",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-abolish",
  "gruvbox-community/gruvbox",
  "christoomey/vim-tmux-navigator",
  "AndrewRadev/linediff.vim",
  "editorconfig/editorconfig-vim",

  -- Nvim plugins
  "nvim-treesitter/nvim-treesitter", -- {'do': ':TSUpdate'}
  "p00f/nvim-ts-rainbow",
  "lukas-reineke/indent-blankline.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "neovim/nvim-lspconfig",
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "iamcco/markdown-preview.nvim", -- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  { "olimorris/persisted.nvim", dev = true },
  "folke/tokyonight.nvim", -- { 'branch': 'main' }
  "nvim-lualine/lualine.nvim",
  "kyazdani42/nvim-tree.lua",
  "lewis6991/gitsigns.nvim",
  "David-Kunz/jester",
  "williamboman/mason.nvim", -- { 'do': ':MasonUpdate' }
  "williamboman/mason-lspconfig.nvim",
  "mfussenegger/nvim-dap",
  "folke/noice.nvim",
  "MunifTanjim/nui.nvim",
  "folke/neodev.nvim",
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opt = {
      symbol_in_winbar = {
        enable = false,
      },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
