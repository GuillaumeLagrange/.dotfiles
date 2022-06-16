local nvim_lsp = require("lspconfig")

-- nvim-autopairs
require('nvim-autopairs').setup()

-- nvim-tree
require'nvim-tree'.setup({
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
})

-- gitsigns
require('gitsigns').setup()

-- lsp
-- typescript
require("typescript").setup({
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>rf", ":TypescriptRenameFile<CR>", { silent = true, buffer=bufnr })
      vim.keymap.set("n", "<space>i", ":TypescriptAddMissingImports<CR>", { silent = true, buffer=bufnr })
      vim.keymap.set("n", "<space>u", ":TypescriptRemoveUnused<CR>", { silent = true, buffer=bufnr })
    end
  },
})

-- eslint
require'lspconfig'.eslint.setup{
  on_attach = function(client, bufnr)
    vim.api.nvim_exec('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll', false)
    vim.keymap.set('n', '<space>t', '<cmd>EslintFixAll<CR>', { silent = true, buffer=bufnr })
  end
}

-- json
require'lspconfig'.jsonls.setup{
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<space>t', '<cmd>lua vim.lsp.buf.formatting()<CR>', { silent = true, buffer = bufnr })
  end
}

-- nvim-cmp
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  };
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})

-- Tree sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true
  },
}

-- Indent
vim.opt.list = true

require("indent_blankline").setup {
  show_current_context = true,
}

-- Lualine
require'lualine'.setup {
  options = {
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''}
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path= 1,
      }
    },
    lualine_x = {
      {
        'filetype',
        icon_only = true,
      }
    },
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path= 1,
      }
    }
  },
  extensions = {'quickfix'}
}

-- Telescope
local actions    = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin    = require('telescope.builtin')
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      prompt_position = "top",
    },
    file_sorter      = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix    = ' 🔍 ',
    color_devicons   = true,
    path_display     = {"truncate"},

    sorting_strategy = "ascending",

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
    }
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

-- Disable underline
vim.diagnostic.config({
  virtual_text = true,
  underline = false,
})

-- Key bindings

-- common lsp
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })

-- nvim tree
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require'nvim-tree'.toggle()<CR>", {noremap = true, silent = true})

-- Telescope
vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>Telescope git_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<CMD>Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-b>", "<CMD>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-e>", "<CMD>Telescope grep_string<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-g>", "<CMD>Telescope git_bcommits<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "<CMD>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
