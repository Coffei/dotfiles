so ~/.vim/plugins.vim

syntax on
set mouse=a
set expandtab
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
colorscheme gruvbox
set background=dark
set number relativenumber
set ignorecase
set smartcase

set splitright
set laststatus=2
set wildmode=longest,list,full
set wildmenu
set textwidth=100
set formatoptions-=t

" caret in gnome-terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" FZF settings
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" disable elixir in vim-polyglot
let g:polyglot_disabled = ['elixir', 'org']

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]
            \            ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ }
            \ }

" Project root for vinegar
autocmd FileType netrw nnoremap <buffer> gr :edit ./<CR>

" Set syntax folding as it's working for Elixir and open 20 levels by default
"set foldmethod=syntax
"set foldlevelstart=20

"Move swap files
set directory=~/.vim/swapfiles//

"Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Neosnippets integration for deoplete
let g:neosnippet#enable_complete_done = 1
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Ale
" let g:ale_elixir_elixir_ls_release = '/home/jtrantin/Apps/elixir-ls/bin/'
let g:ale_linters = {'elixir': ['credo']}
let g:lint_delay = 0
let g:ale_lint_on_text_changed = 0

"xoxo Wojtek Mach
"Fixes test execution in umbrella apps
function! ElixirUmbrellaTransform(cmd) abort
    if match(a:cmd, 'apps/') != -1
        return '(' . substitute(a:cmd, 'mix test\(\s*--no-color\)* apps/\([^/]*/\)', '\cd apps/\2 \&\& mix test\1 \3', '') . ')'
    else
        return a:cmd
    end
endfunction

let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" Fix for Glog to open in quickfix
autocmd QuickFixCmdPost *grep* cwindow

"Elixir LS
"LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'elixir': ['elixir-ls'],
    \ }

" vim-orgmode config
let g:org_todo_keywords=['TODO(t)', 'IN-PROGRESS(i)', 'REVIEW(r)', 'DONE(d)']

" Custom shortcuts
let mapleader=" "
let maplocalleader="\\"
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
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <C-]> :call LanguageClient_textDocument_definition()<CR>:normal! m'<CR>
nmap <leader>t :call LanguageClient_textDocument_documentSymbol()<CR>
nmap <leader>o :call LanguageClient_contextMenu()<CR>
nmap <Leader>fs <Plug>(easymotion-overwin-f)
nmap <Leader>ff <Plug>(easymotion-sn)
imap fd <Esc>
vmap fd <Esc>
