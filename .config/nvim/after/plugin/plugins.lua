-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use "williamboman/nvim-lsp-installer"
  use 'neovim/nvim-lspconfig'
  --use 'kabouzeid/nvim-lspinstall'
  --
  -- use 'glepnir/lspsaga.nvim'
  use 'tami5/lspsaga.nvim'
  --use 'nvim-lua/completion-nvim'
  use('nvim-treesitter/nvim-treesitter', {['do'] = function ()
    vim.cmd('TSUpdate')
    end
  })
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- theming
  use 'joshdick/onedark.vim'
  use 'drewtempelmeyer/palenight.vim'
  -- use 'luiscassih/palenight-dash.vim'
  use {'catppuccin/nvim', as= 'catppuccin'}


  --use 'psliwka/vim-smoothie'

  --compe
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  --use 'L3MON4D3/LuaSnip'
  --use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  -- snip
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  -- statusbar
  use 'hoob3rt/lualine.nvim'
  use 'ryanoasis/vim-devicons'

  -- sneak
  use 'justinmk/vim-sneak'

  --use 'jiangmiao/auto-pairs'
  use 'airblade/vim-rooter'

  use 'numToStr/Comment.nvim'
  use 'ptzz/lf.vim'
  -- use 'vifm/vifm.vim'
  use 'voldikss/vim-floaterm'

  use 'kyazdani42/nvim-web-devicons'
  use 'folke/trouble.nvim'
  --use 'alvan/vim-closetag'
  -- use 'terryma/vim-multiple-cursors'
  -- use 'mg979/vim-visual-multi'
  use 'j-hui/fidget.nvim'
end)
