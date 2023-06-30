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

" fix for vim-elixir not doing ftdetect atm
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir

" configure fugitive-gitlab
let g:fugitive_gitlab_domains = {'ssh://gitlab.altworx': 'https://gitlab.dev.altworx.com'}

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

fun LazyGit()
    call term_start('lazygit', #{term_finish: 'close'})
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
command! LazyGit :call LazyGit()
command! DiffWhitespacesToggle :call DiffWhitespacesToggle()
command! -nargs=0 Format :call CocAction('format')

" Visualize trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

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
let g:fzf_checkout_git_options = '--sort=-committerdate'
" sneak
let g:sneak#s_next = 1

" Lightline
set noshowmode
let g:lightline = {
  \   'component_expand' : {
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_infos': 'lightline#ale#infos',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \     'linter_ok': 'lightline#ale#ok',
  \   },
  \   'component_type' : {
  \     'linter_checking': 'right',
  \     'linter_infos': 'right',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'right',
  \   },
  \   'component_function': {
  \       'gitbranch': 'FugitiveHead'
  \     },
  \   'active': {
  \     'left': [
  \                 [ 'mode', 'paste' ],
  \                 [
  \                     'coc_info',
  \                     'coc_hints',
  \                     'coc_errors',
  \                     'coc_warnings',
  \                     'coc_ok',
  \                     'linter_errors',
  \                     'linter_warnings',
  \                     'linter_infos',
  \                     'linter_ok'
  \                 ],
  \                 [ 'coc_status', 'linter_checking' ],
  \                 [ 'readonly', 'filename', 'modified' ]
  \             ],
  \     'right': [ [ 'lineinfo' ],
  \	               [ 'percent' ],
  \                [ 'fileformat', 'fileencoding', 'filetype' ],
  \                [ 'gitbranch' ]]
  \   }
  \ }
let g:lightline#ale#indicator_ok = '✓'

" register lightline components:
call lightline#coc#register()

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
" Defold lua scripts
au BufRead,BufNewFile *.script set filetype=lua

" Set syntax fold method as default
set foldmethod=syntax
" Set indent folding as syntax is not working well for some langs (e.g. Elixir)
" disabled since it seemed to be working just fine last time I checked
autocmd FileType elixir setlocal foldmethod=indent
autocmd FileType javascript setlocal foldmethod=indent
autocmd FileType javascriptreact setlocal foldmethod=indent
" open 20 fold levels by default
set foldlevelstart=20

"Move swap files
set directory=~/.vim/swapfiles//

" Ale
let g:ale_linters = {
 \  'elixir': ['credo'],
 \  'javascript': ['eslint', 'fecs', 'jscs', 'jshint', 'standard', 'xo'],
 \  'javascriptreact': ['eslint', 'fecs', 'jscs', 'jshint', 'standard', 'xo']
 \  }
let g:lint_delay = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_disable_lsp = 1

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

" vim-orgmode config
let g:org_todo_keywords=['TODO(t)', 'IN-PROGRESS(i)', 'REVIEW(r)', 'DONE(d)']
let g:org_agenda_files = ['~/Documents/notes/todo.org']
" ORG indentation
autocmd FileType org setlocal shiftwidth=2 tabstop=2

" COC config
let g:coc_snippet_next = '<C-l>'

" for coc bindings below
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Custom shortcuts
let mapleader=" "
let maplocalleader=","
nmap <leader>p :Files<CR>
nmap <leader>c :Commands<CR>
nmap <leader>/ :Rg<CR>
nmap <leader>q :q<CR>
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
nmap <leader>bb :Buffers<CR>
nmap <leader>bl :BLines<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bD :BufOnly<CR>
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
nmap <leader>gg :G<CR>
nmap <leader>go :Go<CR>
nmap <leader>gn :Gn<CR>
nmap <leader>gb :GBranches<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gf :Git fetch<Space>
nmap <leader>gl :LazyGit<CR>
" Better completion behavior for TAB and CR
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap gd <Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap gD :vs<CR><Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap K :call CocActionAsync('doHover')<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap <leader>t :CocFzfList outline<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap <leader>a <Plug>(coc-codeaction)
" doesn't work atm
" autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap <leader>a :CocFzfList actions<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap <leader>e :CocFzfList diagnostics --current-buf<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python nmap <leader>r <Plug>(coc-references)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python vmap <leader>f <Plug>(coc-format-selected)
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
