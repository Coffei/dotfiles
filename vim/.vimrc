" disable elixir in vim-polyglot
let g:polyglot_disabled = ['elixir']

so ~/.vim/plugins.vim

syntax on
set mouse=a
" set mouse even on alacritty without proper termfiles
if $TERM == 'alacritty'
  set ttymouse=sgr
endif
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard=unnamedplus
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
" Theming
set background=dark
colorscheme solarized8_high
set number relativenumber
set ignorecase
set smartcase
set updatetime=500

set splitright
set splitbelow
set laststatus=2
set wildmode=longest,list,full
set wildmenu
set textwidth=100
set formatoptions-=t
set colorcolumn=100
set spell

" Custom commands
fun GitLL()
    let height = (&lines - 8) / 2
    if has('nvim')
        split term://git log --oneline -20
    else
        call term_start('git log --oneline -' . height)
    endif
    sleep 1m
    call cursor(1, 1)
endfun

fun DiffWhitespacesToggle()
    if &diffopt =~ 'iwhiteall'
        set diffopt-=iwhiteall
        echom 'Diff whitespace ignore turned OFF'
    else
        set diffopt+=iwhiteall
        echom 'Diff whitespace ignore turned ON'
    endif
endfun

command! BufOnly silent! execute "%bd|e#|bd#"
command! Gn silent! execute "tabnew|G|only"
command! Go silent! execute "G|only"
if has('nvim')
    command! Tig silent! :split term://tig
else
    command! Tig silent! :call term_start('tig', {'term_finish': 'close'})
endif
command! GitLL :call GitLL()
command! DiffWhitespacesToggle :call DiffWhitespacesToggle()
command! -nargs=0 Format :call CocAction('format')

" caret in gnome-terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" alias `vterm` to `vertical terminal`
cnoreabbrev <expr> vterm ((getcmdtype() is# ':' && getcmdline() is# 'vterm')?('vertical terminal'):('vterm'))

" FZF settings
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_preview_window = 'right:40%' " Disable FZF preview window
let g:fzf_commands_expect = 'alt-enter' " Directly execute commands with alt-enter
command! -bang Commits call fzf#vim#commits({'options': '--preview-window "right:40%"'}, <bang>0)
command! -bang BCommits call fzf#vim#buffer_commits({'options': '--preview-window "right:40%"'}, <bang>0)
let g:fzf_checkout_git_options = '--sort=-committerdate'

" AirLine
let g:airline_detect_spell=0
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let airline#extensions#ale#show_line_numbers = 0
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tmuxline#enabled = 1

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
" Defold lua scripts
au BufRead,BufNewFile *.script set filetype=lua

" Project root for vinegar
" autocmd FileType netrw nnoremap <buffer> gr :edit ./<CR>

" Set syntax fold method as default
set foldmethod=syntax
" Set indent folding as syntax is not working well for some langs (e.g. Elixir)
" disabled since it seemed to be working just fine last time I checked
autocmd FileType elixir setlocal foldmethod=indent
" open 20 fold levels by default
set foldlevelstart=20

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
if has('nvim')
    set shell=bash
    let test#strategy = "neovim"
else
    let test#strategy = "vimterminal"
endif

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
" ORG indentation
autocmd FileType org setlocal shiftwidth=2 tabstop=2

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
nmap <leader>c :Commands<CR>
nmap <leader>q :q<CR>
nmap <leader>d :bd<CR>
nmap <leader>D :BufOnly<CR>
nmap <leader>w :w<CR>
nmap <leader>W :noa w<CR>
nmap <leader>l <C-W>l
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>s <C-W>s
nmap <leader>v <C-W>v
nmap <leader>o <C-W>o
nmap <leader>O :tabonly<CR>
nmap <leader>Q :tabclose<CR>
nmap <leader>N :tabnew<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>mh :vertical resize<CR>
nmap <leader>mv :res<CR>
nmap <leader>mm <C-W>=
" <leader>number to move between windows spacemacs-like
nnoremap <leader>1 :1wincmd w<CR>
nnoremap <leader>2 :2wincmd w<CR>
nnoremap <leader>3 :3wincmd w<CR>
nnoremap <leader>4 :4wincmd w<CR>
nnoremap <leader>5 :5wincmd w<CR>
nnoremap <leader>6 :6wincmd w<CR>
nnoremap <leader>7 :7wincmd w<CR>
nnoremap <leader>8 :8wincmd w<CR>
nnoremap <leader>9 :9wincmd w<CR>
nnoremap <leader>+ :1wincmd w<CR>
nnoremap <leader>ě :2wincmd w<CR>
nnoremap <leader>š :3wincmd w<CR>
nnoremap <leader>č :4wincmd w<CR>
nnoremap <leader>ř :5wincmd w<CR>
nnoremap <leader>ž :6wincmd w<CR>
nnoremap <leader>ý :7wincmd w<CR>
nnoremap <leader>á :8wincmd w<CR>
nnoremap <leader>í :9wincmd w<CR>
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
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

autocmd FileType elixir,java,rust,javascript,typescript,typescript.tsx,python nmap gd <Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,typescript,typescript.tsx,python nmap gD :vs<CR><Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,typescript,typescript.tsx,python nmap K :call CocActionAsync('doHover')<CR>
autocmd FileType elixir,java,rust,javascript,typescript,typescript.tsx,python nmap <leader>t :CocList outline<CR>
autocmd FileType elixir,java,rust,javascript,typescript,typescript.tsx,python nmap <leader>r <Plug>(coc-references)
nmap <Leader>fs <Plug>(easymotion-overwin-f)
nmap <Leader>ff <Plug>(easymotion-sn)
nmap <localleader>tt :TestNearest<CR>
nmap <localleader>tr :TestLast<CR>
nmap <localleader>tb :TestFile<CR>
nmap <localleader>ta :TestSuite<CR>
imap fd <Esc>
vmap fd <Esc>
if has('nvim')
    tnoremap fd <C-\><C-N>
endif
" NERDTree vinegar-like mapping
nmap - :NERDTreeFind<CR>
