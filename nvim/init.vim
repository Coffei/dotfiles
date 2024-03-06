" VIM compatibility
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" General config
" disable elixir in vim-polyglot
let g:polyglot_disabled = ['elixir']

lua require('plugins')

" Plugin config
" Neogit
lua require('neogit').setup {integrations = {diffview = true}, signs = { section = { '', '' }, item = { '', '' }}, mappings = {popup = {["V"] = "RevertPopup", ["v"] = false}}}
" Diffview
lua require('diffview').setup()

" some good defaults
syntax on
set mouse=a
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard=unnamedplus
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set ignorecase
set smartcase
set splitright
set splitbelow
set wildmode=longest,list,full
set wildmenu
set textwidth=100
set spell
colorscheme gruvbox
set number relativenumber
set signcolumn=auto

" Fire NVIM config
"
if exists('g:started_by_firenvim')
  set textwidth=80
  set guifont=Fira\ Code:h15
endif

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
au BufEnter gitlab.dev.altworx.com_*.txt set filetype=markdown
au BufEnter trello.com_*.txt set filetype=markdown

" caret in gnome-terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" lazygit integration
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Set syntax fold method as default
set foldmethod=syntax
" Set indent folding as syntax is not working well for some langs (e.g. Elixir)
" disabled since it seemed to be working just fine last time I checked
autocmd FileType elixir setlocal foldmethod=indent
autocmd FileType javascript setlocal foldmethod=indent
autocmd FileType javascriptreact setlocal foldmethod=indent
" open 20 fold levels by default
set foldlevelstart=20
" Move swap files
set directory=~/.nvim/swapfiles//

" Fugitive
fun DiffWhitespacesToggle()
    if &diffopt =~ 'iwhiteall'
        set diffopt-=iwhiteall
        echom 'Diff whitespace ignore turned OFF'
    else
        set diffopt+=iwhiteall
        echom 'Diff whitespace ignore turned ON'
    endif
endfun

command! Gn silent! execute "tabnew|G|only"
command! Go silent! execute "G|only"
command! DiffWhitespacesToggle :call DiffWhitespacesToggle()

" Visualize trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

"FZF settings
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
  \                 [
  \                     'coc_status',
  \                     'linter_checking'
  \                 ],
  \                 [ 'readonly', 'filename', 'modified' ]
  \             ],
  \     'right': [ [ 'lineinfo' ],
  \	               [ 'percent' ],
  \                [ 'fileformat', 'fileencoding', 'filetype' ],
  \                [ 'gitbranch' ]]
  \   }
  \ }
let g:lightline#ale#indicator_ok = '✓'

" configure fugitive-gitlab
let g:fugitive_gitlab_domains = {'ssh://gitlab.altworx': 'https://gitlab.dev.altworx.com'}

" COC
command! -nargs=0 Format :call CocAction('format')
call lightline#coc#register()
let g:coc_snippet_next = '<C-l>'

" used below in keybindings
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Testing
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

set shell=bash
let test#strategy = "neovim"

" for coc bindings below
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Custom bindings
let mapleader=" "
let maplocalleader=","
nmap <leader>p :Files<CR>
nmap <leader>c :Commands<CR>
nmap <leader>bb :Buffers<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bl :BLines<CR>
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>W :noa w<CR>
nmap <leader>l <C-W>l
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>o <C-W>o
nmap <leader>O :tabonly<CR>
nmap <leader>Q :tabclose<CR>
nmap <leader>N :tabnew<CR>
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
nmap <leader>gg :Neogit<CR>
nmap <leader>gd :DiffviewOpen<CR>
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

autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap gd <Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap gD :vs<CR><Plug>(coc-definition)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap K :call CocActionAsync('doHover')<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap <leader>t :CocFzfList outline<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap <leader>a <Plug>(coc-codeaction)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap <leader>e :CocFzfList diagnostics --current-buf<CR>
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown nmap <leader>r <Plug>(coc-references)
autocmd FileType elixir,java,rust,javascript,javascriptreact,typescript,typescriptreact,typescript.tsx,python,markdown vmap <leader>f <Plug>(coc-format-selected)
nmap <Leader>fs <Plug>(easymotion-overwin-f)
nmap <Leader>ff <Plug>(easymotion-sn)
nmap <localleader>tt :TestNearest<CR>
nmap <localleader>tr :TestLast<CR>
nmap <localleader>tb :TestFile<CR>
nmap <localleader>ta :TestSuite<CR>
imap fd <Esc>
vmap fd <Esc>
tnoremap fd <C-\><C-N>
nmap - :NERDTreeFind<CR>
