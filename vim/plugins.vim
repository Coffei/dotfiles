filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'mmorearty/elixir-ctags'
Plugin 'mattreduce/vim-mix'
"Plugin 'slashmili/alchemist.vim'
Plugin 'janko-m/vim-test'
Plugin 'mhinz/vim-mix-format'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
" Plugin 'vim-syntastic/syntastic'
Plugin 'easymotion/vim-easymotion'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'neomake/neomake'
Plugin 'Raimondi/delimitMate'
"Plugin 'w0rp/ale'
Plugin 'maximbaz/lightline-ale'
Plugin 'autozimu/LanguageClient-neovim' " might need special post-install procedures, check readme
call vundle#end()

filetype plugin indent on
