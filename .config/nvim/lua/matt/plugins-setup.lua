local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  --icons
  use('kyazdani42/nvim-web-devicons')
  use('yamatsum/nvim-nonicons')

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  })

  -- improve matchit functions and adds tree-sitter support?!
  use('andymass/vim-matchup')

  -- syntax highlighting (better for typescript / react"
  --use 'sheerun/vim-polyglot'
  --use 'leafgarland/typescript-vim'

  -- rust support
  use('rust-lang/rust.vim')

  -- jsonc support
  use('neoclide/jsonc.vim')

  -- support for editor config
  use('editorconfig/editorconfig-vim')

  -- lsp
  use('neovim/nvim-lspconfig')
  use('williamboman/nvim-lsp-installer') -- todo: change
  use('hrsh7th/nvim-compe') -- todo: change
  use('jose-elias-alvarez/null-ls.nvim')

  -- telescope
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  --treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  })
  use('nvim-treesitter/playground')

  -- colorscheme
  --use 'npxbr/gruvbox.nvim'
  use('gruvbox-community/gruvbox')
  use('sainnhe/gruvbox-material')

  --statusline
  use('glepnir/galaxyline.nvim')

  -- flutter support
  use('akinsho/flutter-tools.nvim')

  -- makes it easier to use jk to escape
  use('max397574/better-escape.nvim')

  -- git integration
  use('lewis6991/gitsigns.nvim')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
