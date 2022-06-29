-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug "williamboman/nvim-lsp-installer"
  Plug 'neovim/nvim-lspconfig'
  --Plug 'kabouzeid/nvim-lspinstall'
  --
  -- Plug 'glepnir/lspsaga.nvim'
  Plug 'tami5/lspsaga.nvim'
  --Plug 'nvim-lua/completion-nvim'
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = function ()
    vim.cmd('TSUpdate')
    end
  })
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  -- theming
  Plug 'joshdick/onedark.vim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'luiscassih/palenight-dash.vim'


  --Plug 'psliwka/vim-smoothie'

  --compe
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  --Plug 'L3MON4D3/LuaSnip'
  --Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  -- Plug 'hrsh7th/cmp-vsnip'
  -- Plug 'hrsh7th/vim-vsnip'
  -- statusbar
  Plug 'hoob3rt/lualine.nvim'
  Plug 'ryanoasis/vim-devicons'

  -- sneak
  Plug 'justinmk/vim-sneak'

  --Plug 'jiangmiao/auto-pairs'
  Plug 'airblade/vim-rooter'

  Plug 'numToStr/Comment.nvim'
  Plug 'ptzz/lf.vim'
  Plug 'voldikss/vim-floaterm'

  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim'
  --Plug 'alvan/vim-closetag'
vim.call('plug#end')

-- settings
local opt = vim.opt
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.guicursor = ''
opt.softtabstop = 2
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.expandtab = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.ruler = true
opt.smartindent = true
opt.hlsearch = false
opt.undodir = os.getenv( "HOME" ) .. "/.config/nvim/undodir"
opt.undofile = true
opt.hidden = true

-- globals
local g = vim.g
g.noswapfile = true
g.nobackup = true

-- mapping
local map = vim.api.nvim_set_keymap
g.mapleader = ' '
map('i','<S-Tab>', '<C-d>', { noremap = true })

-- Delete without yank
map('n','<leader>d', '""d', { noremap = true })
map('n','<leader>D', '""D', { noremap = true })
map('v','<leader>d', '""d', { noremap = true })
map('n','<leader>c', '""c', { noremap = true })
map('v','<leader>c', '""c', { noremap = true })
map('n','d', '"_d', { noremap = true })
map('v','d', '"_d', { noremap = true })
map('n','x', '"_x', { noremap = true })

-- git

map('n','[g', '<Plug>(GitGutterNextHunk)', {})
map('n',']g', '<Plug>(GitGutterPrevHunk)', {})
map('n','<leader>gu', '<Plug>(GitGutterUndoHunk)', {})
map('n','<leader>gp', '<Plug>(GitGutterPreviewHunk)', {})
map('n','<leader>gb', '<cmd>Git blame<cr>', { noremap = true })

-- theming
opt.termguicolors = true
opt.background = 'dark'
--vim.cmd([[
--let g:palenight_color_overrides = {
--\    'black': { 'gui': '#101114', "cterm": "0", "cterm16": "0" },
--\    'blue': { 'gui': '#5B85FF', "cterm": "39", "cterm16": "4" },
--\    'red': { 'gui': '#F54784', "cterm": "204", "cterm16": "1" },
--\    'green': { 'gui': '#4EBC6B', "cterm": "114", "cterm16": "2" },
--\    'white': { 'gui': '#DBE5ED', "cterm": "145", "cterm16": "7" },
--\    'yellow': { 'gui': '#ED9C50', "cterm": "180", "cterm16": "3" },
--\}
--]])
--vim.cmd('colorscheme palenight')
vim.cmd('colorscheme palenightdash')
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
]])

-- completion-nvim
--opt.completeopt = "menuone,noinsert,noselect"
opt.completeopt = "menu,menuone,noselect"
-- opt.shortmess = opt.shortmess + "c"
--map('i','C-<space>', '<Plug>(completion_trigger)', { expr = true })
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      --require('luasnip').lsp_expand(args.body)
      --vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- lspconfig
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  --require'completion'.on_attach(client, bufnr)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'html', 'tailwindcss' }

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end

require("nvim-lsp-installer").setup {}
--[[
require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
]]

-- lspsaga
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

--map('n','gh', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', { noremap = true })
map('n','gD', '<cmd>lua require("lspsaga.provider").preview_definition()<CR>', { noremap = true })
--map('n','gr', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', { noremap = true })
map('n','gR', '<cmd>lua require("lspsaga.rename").rename()<CR>', { noremap = true })
map('n','[d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', { noremap = true })
map('n',']d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', { noremap = true })

--map('t','<C-\\><C-\\>', '<cmd>lua require("lspsaga.floaterm").close_float_terminal()<CR>', { noremap = true })

_G.is_saga_term_open = false
_G.toggleSagaFloaterm = function() 
  if (_G.is_saga_term_open) then
    require("lspsaga.floaterm").close_float_terminal()
    _G.is_saga_term_open = false
  else
    require("lspsaga.floaterm").open_float_terminal()
    _G.is_saga_term_open = true
  end
end 
--map('n','<C-\\><C-\\>', '<cmd>lua toggleSagaFloaterm()<cr>', { noremap = true })
--map('t','<C-\\><C-\\>', '<cmd>lua toggleSagaFloaterm()<cr>', { noremap = true })
map('n','<C-]><C-]>', '<cmd>lua toggleSagaFloaterm()<cr>', { noremap = true })
map('t','<C-]><C-]>', '<cmd>lua toggleSagaFloaterm()<cr>', { noremap = true })


-- lfcd

vim.cmd([[
let g:lf_map_keys = 0
let g:lf_width = 0.9
let g:lf_height = 0.7
]])
map('n','<leader>l', '<cmd>:Lf<cr>', { noremap = true })


-- treesitter

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "c_sharp", "cpp", "css", "gdscript", "go", "html", "java", "javascript", "json", "kotlin", "regex", "python", "scss", "tsx", "typescript", "vim", "vue", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    autotag = {
      enable = true,
    }
  },
}


-- trouble
require("trouble").setup {}

require('telescope').setup({
  defaults = {
    hidden=true,
    no_ignore=true,
  }
});

-- telescope
map('n','<leader>f', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true })
map('n','<leader>F', '<cmd>lua require("telescope.builtin").git_status()<cr>', { noremap = true })
map('n','<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true })
map('n','<leader>h', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { noremap = true })
map('n','<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true })
map('n','<leader>s', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { noremap = true })

-- Copy paste
map('n','<leader>y', '"+yy', { noremap = true })
map('v','<leader>y', '"+y', { noremap = true })
map('n','<leader>p', '"+p', { noremap = true })
map('v','<leader>p', '"+p', { noremap = true })

-- Tabs
map('n','<leader>x', '<cmd>bd<cr>', { noremap = true })
--map('n','<leader>xa', '<cmd>%bd<cr>', { noremap = true })
map('n','<leader>wp', '<cmd>wa<cr>', { noremap = true })
map('n','<leader>ww', '<cmd>w<cr>', { noremap = true })
--map('n','<C-k>', '<cmd>bnext<cr>', { noremap = true })
--map('n','<C-j>', '<cmd>bNext<cr>', { noremap = true })

-- status bar
require('lualine').setup {
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}

-- Comment
require('Comment').setup()

-- Sneak
g['sneak#label'] = 1
map('n','f', '<Plug>Sneak_f', { })

-- split
map('n','<leader>sv', '<cmd>vsplit<Return><C-w>w<cr>', {}) -- split vertical
map('n','<leader>ss', '<cmd>split<Return><C-w>w<cr>', {}) -- split horizontal
map('n','<C-h>', '<C-w>h', {}) -- move cursor to upper window
map('n','<C-j>', '<C-w>j', {})
map('n','<C-k>', '<C-w>k', {})
map('n','<C-l>', '<C-w>l', {})
map('n','<leader>sf', '<C-w>o', {}) -- make this window the only one and close the others
map('n','<leader>rj', '<cmd>vertical resize +20<cr>', {})
map('n','<leader>rk', '<cmd>vertical resize -20<cr>', {})
map('n','<leader>rh', '<cmd>resize +10<cr>', {})
map('n','<leader>rl', '<cmd>resize -10<cr>', {})


-- Close tags
--[[
vim.cmd([[
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
]]


