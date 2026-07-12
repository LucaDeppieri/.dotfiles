-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.opt

-- Line numbers
set.number = true
set.relativenumber = true

-- Indentation
set.autoindent = true
set.tabstop = 2
set.shiftwidth = 2
set.smarttab = true
set.softtabstop = 2
set.wrap = false

-- Encoding
vim.scriptencoding = "utf-8"
set.encoding = "utf-8"
set.fileencoding = "utf-8"

-- Search
set.ignorecase = true
set.smartcase = true
vim.o.hlsearch = false

-- Other
set.termguicolors = true
set.mouse = "a"
set.title = false
set.hlsearch = true
set.cursorline = false
vim.o.clipboard = "unnamedplus"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.background = "dark"
set.swapfile = false
