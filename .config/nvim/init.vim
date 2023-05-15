" tabs
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent

" searching
set hlsearch

" relative line numbers
set number
set relativenumber

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
"set laststatus=0                        " Always display the status line
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

call plug#begin(stdpath('data') . '/plugged')

  " sane defaults
  Plug 'tpope/vim-sensible'

  " IDE-like window
  Plug 'preservim/nerdtree'

  " better/different syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " language server protocol
  Plug 'neovim/nvim-lspconfig'

  " autocompletion
  Plug 'nvim-lua/completion-nvim'

  " Fuzzy searching
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " status line
  Plug 'itchyny/lightline.vim'

  " color scheme
  Plug 'arcticicestudio/nord-vim'
  Plug 'tomasiser/vim-code-dark'

  " wayland clipboard
  Plug 'jasonccox/vim-wayland-clipboard'

  " buffers in tabline
  Plug 'ap/vim-buftabline'

call plug#end()

set termguicolors
colorscheme codedark

lua << EOF
require'lspconfig'.rls.setup {
  on_attach = require'completion'.on_attach
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  ensure_installed = "rust",
}

-- diagnostics display configuration
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- don't show diagnostics at the end of the line
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
})

-- show diagnostics on hover
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
EOF

" completion
set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NERDTree commands
nnoremap <C-f> <cmd>NERDTreeFind<CR>

" IDE/LSP commands
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.bug.declaration()<CR>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <C-t> <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>
inoremap <C-t> <Esc><cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>


function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" close buffer
nnoremap <C-x> :bp\|bd #<CR>

" clear search highlight + redraw screen
nnoremap <C-_> :noh<CR><C-l>
