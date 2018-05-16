so ~/.vim/plugins.vim

syntax on
set mouse=a
set expandtab
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
colorscheme deus
set background=dark
set relativenumber

set splitright
set laststatus=2

" Set syntax folding as it's working for Elixir and open 20 levels by default
set foldmethod=syntax
set foldlevelstart=20

"Move swap files
set directory=~/.vim/swapfiles//

"Enabling syntastic for Elixir by compiling the files
let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"xoxo Wojtek Mach
"Fixes test execution in umbrella apps
function! ElixirUmbrellaTransform(cmd) abort
  if match(a:cmd, 'apps/') != -1
    return '(' . substitute(a:cmd, 'mix test apps/\([^/]*/\)', '\cd apps/\1 \&\& mix test \2', '') . ')'
  else
    return a:cmd
  end
endfunction

let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" Fix for Glog to open in quickfix
autocmd QuickFixCmdPost *grep* cwindow

" Custom shortcuts
let mapleader=" "
nmap <leader>p :Files<CR>
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>l <C-W>l
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>gp <Plug>GitGutterPreviewHunk
nmap <leader>gu <Plug>GitGutterUndoHunk
nmap <leader>gs <Plug>GitGutterStageHunk
imap fd <Esc>
"let test#filename_modifier = ":p"

