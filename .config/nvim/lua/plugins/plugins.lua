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
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  "p00f/nvim-ts-rainbow",
  "lukas-reineke/indent-blankline.nvim",
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
    },
  },
  "neovim/nvim-lspconfig",
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "iamcco/markdown-preview.nvim", -- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  "olimorris/persisted.nvim",
  "folke/tokyonight.nvim", -- { 'branch': 'main' }
  "nvim-lualine/lualine.nvim",
  "kyazdani42/nvim-tree.lua",
  "lewis6991/gitsigns.nvim",
  "David-Kunz/jester",
  "williamboman/mason.nvim", -- { 'do': ':MasonUpdate' }
  "williamboman/mason-lspconfig.nvim",
  "simrat39/rust-tools.nvim",
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
