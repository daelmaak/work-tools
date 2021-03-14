let mapleader = ','

call plug#begin('~/.vim/plugged')

Plug 'sainnhe/edge'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'

" Initialize plugin system
call plug#end()

set statusline+=%{coc#status()}

" TextEdit might fail if hidden is not set.
set hidden

" highlight current cursor line
set cursorline

filetype plugin indent on
set autoindent

" auto reload file when it changes
set autoread
au CursorHold * checktime 

set timeoutlen=300
set updatetime=200

set nobackup
set nowritebackup

" more natural split opening
set splitbelow
set splitright

" exclude node_modules from search
set path+=**                                                                    
set wildignore+=**/node_modules/** 

" Give more space for displaying messages.
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set termguicolors
set background=dark
" Set max tab width and new line shifts
set tabstop=4 shiftwidth=2
" Center cursor vertically when eg. searching
set so=10
set number relativenumber

" Filename at the bottom
set laststatus=2

" https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
set backspace=indent,eol,start

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" In :Explore if you'd like to have relative numbering instead, try >
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

" Theme
let g:edge_style = 'neon'
let g:edge_transparent_background = 1
let g:edge_disable_italic_comment = 1

" Trigger emmet when pressing leader key
let g:user_emmet_leader_key=','

" Install coc extensions
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-angular', 'coc-eslint', 'coc-prettier', 'coc-css', 'coc-vetur' ]

" Change cursor when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

colorscheme edge

" Set up :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>p :Prettier<CR>

" Open vertical Git
nmap <leader>gg :vertical G<CR>

" Set up support for scss
autocmd FileType scss setl iskeyword+=@-@

" Organize imports
command! -nargs=0 OI :CocCommand editor.action.organizeImport

" prev tab
nnoremap H gT
" next tab
nnoremap L gt

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]g <Plug>(coc-diagnostic-next-error)

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Scroll in float window or popup
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
	execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:lightline = {
	  \ 'colorscheme': 'wombat',
	  \ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'gitbranch', 'readonly', 'filename', 'cocstatus', 'modified' ] ]
		\ },
		\ 'component_function': {
		  \   'cocstatus': 'coc#status',
		  \   'gitbranch': 'FugitiveHead'
		  \ },
		  \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

