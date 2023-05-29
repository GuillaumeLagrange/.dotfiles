local M = {}

M.map = function(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

M.nmap = function(shortcut, command)
  M.map("n", shortcut, command)
end

M.imap = function(shortcut, command)
  M.map("i", shortcut, command)
end

M.vmap = function(shortcut, command)
  M.vap("t", shortcut, command)
end

M.nvmap = function(shortcut, command)
  M.map({ "n", "v" }, shortcut, command)
end

M.tmap = function(shortcut, command)
  M.map("t", shortcut, command)
end

return M
