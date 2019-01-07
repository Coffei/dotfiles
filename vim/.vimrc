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

" caret in gnome-terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
" \ if v:insertmode == 'i' | 
" \   silent execute '!echo -ne "\e[6 q"' | redraw! |
" \ elseif v:insertmode == 'r' |
" \   silent execute '!echo -ne "\e[4 q"' | redraw! |
" \ endif
" au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif

" disable elixir in vim-polyglot
let g:polyglot_disabled = ['elixir']

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]
      \            ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
"      \  'right': [ [ 'lineinfo' ],
"      \             [ 'percent' ],
"      \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
"      \             [ 'filetype', 'fileencoding' ] ]

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
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

"Enabling syntastic for Elixir by compiling the files
" let g:syntastic_elixir_checkers = ['elixir']
" let g:syntastic_enable_elixir_checker = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Ale
" let g:ale_elixir_elixir_ls_release = '/home/jtrantin/Apps/elixir-ls/bin/'
" let g:ale_linters = {'elixir': ['elixir-ls', 'credo']}

"Enable credo via neomake
call neomake#configure#automake('w')
let g:neomake_elixir_enabled_makers = ['credo']

"xoxo Wojtek Mach
"Fixes test execution in umbrella apps
function! ElixirUmbrellaTransform(cmd) abort
    if match(a:cmd, 'apps/') != -1
        return '(' . substitute(a:cmd, 'mix test\(\s*--no-color\)* apps/\([^/]*/\)', '\cd apps/\2 \&\& mix test\1 \3', '') . ')'
    else
        return a:cmd
    end
endfunction
"let test#filename_modifier = ":p"

let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
let g:test#transformation = 'elixir_umbrella'

" Fix for Glog to open in quickfix
autocmd QuickFixCmdPost *grep* cwindow

"Elixir LS
"LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'elixir': ['elixir-ls'],
    \ }

" vim-lsp
" if executable('elixir-ls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'elixir-ls',
"         \ 'cmd': {server_info->['elixir-ls']},
"         \ 'whitelist': ['elixir'],
"         \ })
" endif
" let g:lsp_signs_enabled = 1         " enable signs
" let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼',}
" let g:lsp_signs_hint = {'text': '→'}

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
