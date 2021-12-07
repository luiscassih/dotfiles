call plug#begin()
" Theme
Plug 'joshdick/onedark.vim'
Plug 'kyazdani42/nvim-web-devicons'

" Godot
Plug 'habamax/vim-godot'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'sharkdp/bat'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-treesitter/nvim-treesitter'

" Others
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-sneak'
call plug#end() 

" Settings
set number
set relativenumber
set nohlsearch
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent
set laststatus=0
set noshowmode
set background=dark
set showtabline=2
set guicursor=
set exrc
set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=100

" Completition nvim-compe
"set completeopt=menuone,noselect
let g:ale_completion_enabled = 0
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let mapleader = " "

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"nmap <C-p> :Files

" Intellisense
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()

" File System
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-p> :Telescope find_files<cr>

" Tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:lightline = {
                        \ 'colorscheme': 'onedark',
                        \}
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
nnoremap <leader>xx :bd<CR>
nnoremap <leader>xa :%bd<CR>
nnoremap <leader>wp :wa<CR>
nnoremap <C-k> :bnext<cr>
nnoremap <C-j> :bNext<cr>

" Godot
let g:godot_executable = 'D:/dev/Godot/godot.exe'
nnoremap <leader>gp <cmd>w<cr><cmd>GodotRun<CR>
nnoremap <leader>gs <cmd>GodotRunCurrent<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


if (empty($TMUX))
        if (has("nvim"))
                 let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        endif
        if (has("termguicolors"))
                set termguicolors
        endif
endif
"autocmd vimenter * ++nested colorscheme onedark
syntax on
colorscheme onedark
highlight Normal guibg=none
