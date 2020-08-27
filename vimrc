call plug#begin('~/.vim/plugged')

" After running PlugInstall, you also have to install:
" 1) tsserver. Just run in vim :CocInstall coc-tsserver
Plug 'sainnhe/edge'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier'

" Initialize plugin system
call plug#end()

set nobackup
set nowritebackup
set number

set termguicolors
set background=dark
" Set max tab width and new line shifts
set tabstop=4 shiftwidth=2

let g:edge_style = 'neon'
let g:edge_transparent_background = 1
let g:edge_disable_italic_comment = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

colorscheme edge

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR>

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


