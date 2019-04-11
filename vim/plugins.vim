filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp' " for deoplete
Plugin 'roxma/vim-hug-neovim-rpc' " for deoplete
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'mmorearty/elixir-ctags'
Plugin 'mattreduce/vim-mix'
Plugin 'janko-m/vim-test'
Plugin 'mhinz/vim-mix-format'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'easymotion/vim-easymotion'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jparise/ale'
Plugin 'autozimu/LanguageClient-neovim' " might need special post-install procedures, check readme
Plugin 'sheerun/vim-polyglot'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-vinegar'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
call vundle#end()

filetype plugin indent on
