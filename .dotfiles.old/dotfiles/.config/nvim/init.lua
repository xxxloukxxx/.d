local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- vim.cmd [[packadd packer.nvim]]
-- 
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'w0rp/ale'
  use 'lervag/vimtex'
  use 'nvim-lualine/lualine.nvim'
  use 'joshdick/onedark.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)

---------------------------------------------------------------------> Global config
local opt = vim.opt
vim.o.breakindent = true
vim.g.mapleader = ":"
opt.ignorecase = true
opt.mouse = "a"
opt.autoindent = true
opt.hlsearch = true
opt.number = true
opt.cursorline = true
opt.laststatus = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.ruler = true
opt.syntax = "on"
opt.smartcase = true
opt.ignorecase = true
opt.list = true
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
---
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--- Status line
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Vimtex
vim.g.vimtex_compiler_latexmk = { executable = 'latexmk' }
vim.g.vimtex_compiler_latexmk_engines = { _ = '-xelatex' }

