-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'junegunn/fzf.vim', requires = {'junegunn/fzf'}}
  use 'stsewd/fzf-checkout.vim'
  use 'antoinemadec/coc-fzf'

  use 'tpope/vim-surround'
  use 'elixir-lang/vim-elixir'
  use 'janko-m/vim-test'
  use 'tpope/vim-endwise'
  use 'tpope/vim-commentary'
  use 'easymotion/vim-easymotion'
  use 'ellisonleao/gruvbox.nvim'
  use 'itchyny/lightline.vim'
  use 'josa42/vim-lightline-coc'
  use 'maximbaz/lightline-ale'
  use 'jiangmiao/auto-pairs'
  use 'jparise/ale'
  use 'sheerun/vim-polyglot'
  use 'python-mode/python-mode'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'tpope/vim-projectionist'
  use 'andyl/vim-projectionist-elixir'
  use 'preservim/nerdtree'
  use 'tpope/vim-sleuth'
  use 'justinmk/vim-sneak'
  use {'TimUntersberger/neogit', requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'ibhagwan/fzf-lua'}}
  use 'sindrets/diffview.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'tpope/vim-fugitive'
  use 'tommcdo/vim-fubitive'
  use 'shumphrey/fugitive-gitlab.vim'
  use 'airblade/vim-gitgutter'
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
  use 'mhinz/vim-mix-format'
  use 'kdheepak/lazygit.nvim'
end)
