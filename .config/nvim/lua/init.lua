local nvim_lsp = require("lspconfig")

-- nvim-autopairs
require('nvim-autopairs').setup({})

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
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require'nvim-tree'.toggle()<CR>", {noremap = true, silent = true})

-- gitsigns
require('gitsigns').setup()

-- ts-lsp-utils
nvim_lsp.tsserver.setup({
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    init_options = require("nvim-lsp-ts-utils").init_options,
    --
    on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {"hint"},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = false,
            inlay_hints_highlight = "Comment",

            -- update imports on file move
            update_imports_on_move = true,
            require_confirmation_on_move = true,
            watch_dir = nil,
        })

        vim.diagnostic.config({
          virtual_text = false,
          underline = false,
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    buf_set_keymap("n", "<space>o", ":TSLspOrganize<CR>", opts)
    buf_set_keymap("n", "<space>rf", ":TSLspRenameFile<CR>", opts)
    buf_set_keymap("n", "<space>i", ":TSLspImportAll<CR>", opts)
    buf_set_keymap("n", "<space>x", ":TSLspFixCurrent<CR>", opts)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>t', '<cmd>EslintFixAll<CR>', opts)
  end
})

-- eslint
require'lspconfig'.eslint.setup{}

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
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
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

-- Telescope
vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>Telescope git_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<CMD>Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-b>", "<CMD>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-e>", "<CMD>Telescope grep_string<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-g>", "<CMD>Telescope git_bcommits<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "<CMD>lua vim.lsp.buf.code_action()<CR>", { noremap = true })

-- Remove highlights
vim.api.nvim_set_keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true })

-- Find word/file across project
vim.api.nvim_set_keymap("n", "<Leader>pf", "yiw<CMD>Telescope git_files<CR><C-r>+<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>pw", "<CMD>Telescope grep_string<CR><ESC>", { noremap = true })
