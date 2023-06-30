filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'stsewd/fzf-checkout.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'janko-m/vim-test'
Plugin 'mhinz/vim-mix-format'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fubitive'
Plugin 'shumphrey/fugitive-gitlab.vim'
Plugin 'tpope/vim-commentary'
Plugin 'easymotion/vim-easymotion'
" Themes
Plugin 'morhetz/gruvbox'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jparise/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-speeddating'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'neoclide/coc.nvim'
" Projectionist for navigating between related elixir files
Plugin 'tpope/vim-projectionist'
Plugin 'c-brenn/fuzzy-projectionist.vim'
Plugin 'andyl/vim-projectionist-elixir'
Plugin 'preservim/nerdtree'
" Plugin 'inkarkat/vim-ShowTrailingWhitespace' "kinda broken recently
Plugin 'KabbAmine/zeavim.vim'
if has('nvim')
    Plugin 'sindrets/diffview.nvim'
endif
call vundle#end()

filetype plugin indent on
