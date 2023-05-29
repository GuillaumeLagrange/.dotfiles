local u = require("utils")

-- Diff mappings put/get then move to next change
u.nmap("<leader>dg", "<CMD>diffget<CR>]c")
u.nmap("<leader>dp", "<CMD>diffput<CR>]c")

u.nmap("<leader>dp", "<CMD>diffput<CR>]c")

-- Disable highlight
u.nmap("<leader><space>", "<CMD>noh<CR>")

-- Remap movement to move by column layout
u.nvmap("j", "gj")
u.nvmap("k", "gk")

u.nvmap(";", ":")

-- Window splitting remap"
u.nmap("<C-h>", "<C-w>h")
u.nmap("<C-k>", "<C-w>k")
u.nmap("<C-l>", "<C-w>l")
u.nmap("<C-j>", "<C-w>j")
u.nmap("<C-w>z", ":cclose<CR>")

-- Exit terminal insert mode
u.tmap("<Esc>", "<C-\\><C-n>")

-- Delete buffer without closing the window
u.nmap("<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- Fugitive

u.nmap("<leader>gw", ":Gwrite<CR>")
u.nmap("<leader>gr", ":Gread<CR>")
u.nmap("<leader>gc", ":Git commit -v<CR>")
u.nmap("<leader>gC", ":Git commit -v --amend<CR>")
u.nmap("<leader>gs", ":Git<CR>")
u.nmap("<leader>gd", ":Gdiff<CR>")
u.nmap("<leader>gb", ":Git blame<CR>")
