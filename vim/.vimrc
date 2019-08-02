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
set updatetime=500

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
            \             [ 'gitbranch',  'cocstatus', 'readonly', 'filename', 'modified' ]
            \            ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'cocstatus': 'coc#status'
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
" commented for coc
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Neosnippets integration for deoplete
" commented for coc 1 line
" let g:neosnippet#enable_complete_done = 1
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" commented for coc 3 lines
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" For conceal markers.
" commented for coc 3 lines
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" Ale
" let g:ale_elixir_elixir_ls_release = '/home/jtrantin/Apps/elixir-ls/bin/'
" commented for coc 3 lines
let g:ale_linters = {'elixir': ['credo']}
let g:lint_delay = 0
let g:ale_lint_on_text_changed = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

"xoxo Wojtek Mach
"Fixes test execution in umbrella apps
function! ElixirUmbrellaTransform(cmd) abort
    if match(a:cmd, 'apps/') != -1
        return '(' . substitute(a:cmd, 'mix test\(\s*--no-color\)* apps/\([^/]*/\)', '\cd apps/\2 \&\& mix test\1 \3', '') . ')'
    else
        return a:cmd
    end
endfunction
" use vim terminal for launching tests
let test#strategy = "vimterminal"

let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" Fix for Glog to open in quickfix
autocmd QuickFixCmdPost *grep* cwindow

"Elixir LS
"LanguageClient-neovim
" commented for coc 3 lines
" let g:LanguageClient_serverCommands = {
"     \ 'elixir': ['elixir-ls'],
"     \ }

" vim-orgmode config
let g:org_todo_keywords=['TODO(t)', 'IN-PROGRESS(i)', 'REVIEW(r)', 'DONE(d)']
let g:org_agenda_files = ['~/Documents/notes/todo.org']

" COC config
let g:coc_snippet_next = '<C-l>'

" Custom functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Custom shortcuts
let mapleader=" "
let maplocalleader=","
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
" commented for coc 4 lines
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <C-]> :call LanguageClient_textDocument_definition()<CR>:normal! m'<CR>
" nmap <leader>t :call LanguageClient_textDocument_documentSymbol()<CR>
" nmap <leader>o :call LanguageClient_contextMenu()<CR>
" Better completion behavior for TAB and CR
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

autocmd FileType elixir nmap gd <Plug>(coc-definition)
autocmd FileType elixir nmap gD :vs<CR><Plug>(coc-definition)
autocmd FileType elixir nmap K :call CocActionAsync('doHover')<CR>
autocmd FileType elixir nmap <leader>t :CocList outline<CR>
nmap <Leader>fs <Plug>(easymotion-overwin-f)
nmap <Leader>ff <Plug>(easymotion-sn)
autocmd FileType elixir nmap <localleader>f :MixFormat<CR>
nmap <localleader>tt :TestNearest<CR>
nmap <localleader>tr :TestLast<CR>
nmap <localleader>tb :TestFile<CR>
nmap <localleader>ta :TestSuite<CR>
imap fd <Esc>
vmap fd <Esc>
