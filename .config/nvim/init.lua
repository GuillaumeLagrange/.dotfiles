vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  return
end

require("lazy").setup("plugins", {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/lua/nvim-plugins",
    fallback = true, -- Fallback to git when local plugin doesn't exist
  },
})

require("settings")
require("mappings")
require("setup")
