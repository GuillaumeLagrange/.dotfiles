-- debug lsp
vim.lsp.set_log_level("info")
require("vim.lsp.log").set_format_func(vim.inspect)

-- nvim-autopairs
require("nvim-autopairs").setup()

-- web-devicons
require("nvim-web-devicons").setup()

-- noice
require("noice").setup()

-- nvim-tree
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
  },
  renderer = {
    full_name = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
})

-- gitsigns
require("gitsigns").setup()

-- -- TODO: Clean this up
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, true)
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, true)
--   end,
-- })

-- lsp
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({})
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function()
  -- end,
  -- lua_ls
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
})

-- typescript
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = {
    -- pass options to lspconfig's setup method
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>rf", ":TypescriptRenameFile<CR>", { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<space>i", ":TypescriptAddMissingImports<CR>", { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<space>u", ":TypescriptRemoveUnused<CR>", { silent = true, buffer = bufnr })
    end,
  },
})

-- eslint
require("lspconfig").eslint.setup({
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<space>t", ":EslintFixAll<CR>", { silent = true, buffer = bufnr })
  end,
})

require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
        check = {
          overrideCommand = {
            "cargo check --quiet --message-format=json --all-targets",
          },
        },
        buildScripts = {
          overideCommand = {
            "cargo check --quiet --message-format=json --all-targets",
          },
        },
      },
    },
  },
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
  on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint(bufnr, true)

      vim.api.nvim_set_keymap("n", "<F12>", "<CMD>lua vim.lsp.inlay_hint(0)<CR>", { noremap = true })
    end
  end,
})

-- nullls
local null_ls = require("null-ls")
local lSsources = {
  null_ls.builtins.formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "md",
      "txt",
    },
    only_local = "node_modules/.bin",
  }),
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.stylua,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = lSsources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})

-- nvim-cmp
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")

local cmp_kinds = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
}

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({
      config = {
        sources = {
          { name = "nvim_lsp" },
        },
      },
    }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 3 },
  }),
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
      return vim_item
    end,
  },
  preselect = "none",
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Tree sitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "go", "lua", "markdown", "python", "rust", "tsx", "typescript", "vim" },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
})

-- Indent
vim.opt.list = true

require("indent_blankline").setup({
  show_current_context = true,
})

-- Lualine
require("lualine").setup({
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_x = {
      {
        "filetype",
        icon_only = true,
      },
    },
  },
  inactive_sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },
  },
  extensions = { "quickfix" },
})

-- mini
-- require('mini.sessions').setup()
-- require('mini.starter').setup()
require("persisted").setup({
  save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
  silent = false, -- silent nvim message when sourcing session file
  use_git_branch = true, -- create session files based on the branch of the git enabled repository
  autosave = true, -- automatically save session files when exiting Neovim
  should_autosave = nil, -- function to determine if a session should be autosaved
  autoload = true, -- automatically load the session for the cwd on Neovim startup
  on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
  follow_cwd = true, -- change session file name to match current working directory if it changes
  allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
  ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
  telescope = { -- options for the telescope extension
    reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
  },
})

-- Telescope
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
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
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " 🔍 ",
    color_devicons = true,
    path_display = { "truncate" },

    sorting_strategy = "ascending",

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist,
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
  },
  pickers = {
    buffers = {
      sort_mru = true,
      ignore_current_buffer = true,
    },
    git_files = {
      git_command = { "git", "ls-files", "--exclude-standard", "--cached", "--others", "--deduplicate" },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    undo = {
      side_by_side = true,
      layout_config = {
        preview_height = 0.8,
        sorting_strategy = "descending",
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")
require("telescope").load_extension("file_browser")

-- Disable underline
vim.diagnostic.config({
  virtual_text = true,
  underline = false,
})

-- Key bindings

-- common lsp
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>t", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<space>wl",
  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-]>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- nvim tree
-- vim.api.nvim_set_keymap("n", "<space>f", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Telescope
vim.api.nvim_set_keymap("n", "<space>fF", "<CMD>Telescope file_browser<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<space>ff",
  "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)
vim.api.nvim_set_keymap("n", "<space>fg", "<CMD>lua require'telescope-config'.project_files()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-b>", "<CMD>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-e>", "<CMD>Telescope grep_string<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-g>", "<CMD>Telescope git_bcommits<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-s>", "<CMD>Telescope lsp_references<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Space>", "<CMD>Telescope resume<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "<CMD>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
