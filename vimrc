let mapleader = ','

call plug#begin('~/.vim/plugged')

Plug 'sainnhe/edge'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

set timeoutlen=300

set nobackup
set nowritebackup
set number

set termguicolors
set background=dark
" Set max tab width and new line shifts
set tabstop=4 shiftwidth=2
" Center cursor vertically when eg. searching
set so=10
set number relativenumber

" Filename at the bottom
set laststatus=2

let g:edge_style = 'neon'
let g:edge_transparent_background = 1
let g:edge_disable_italic_comment = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" Trigger emmet when pressing leader key
let g:user_emmet_leader_key=','

" Install ts language server
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-angular', 'coc-tslint' ]

" Change cursor when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

colorscheme edge

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

nnoremap <C-p> :GFiles<CR>

" Edit vimr configuration file
nnoremap confe :e $MYVIMRC<CR>
" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


