local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here

  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })
  use("folke/which-key.nvim")

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use("lunarvim/darkplus.nvim")

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "wesleimp/stylua.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim" })
  use({ "BurntSushi/ripgrep" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- Debugger
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "theHamsta/nvim-dap-virtual-text" })
  use( { "mfussenegger/nvim-dap-python" } )

  --[[
  --
	-- Lazy loading:
	-- Load on specific commands
	use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
	-- Load on an autocommand event
	use {'andymass/vim-matchup', event = 'VimEnter'}
	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
	use {
	'w0rp/ale',
	ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
	cmd = 'ALEEnable',
	config = 'vim.cmd[[ALEEnable]]--[['
	}
	-- Plugins can have dependencies on other plugins
	use {
	'haorenW1025/completion-nvim',
	opt = true,
	requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
	}
	-- Plugins can also depend on rocks from luarocks.org:
	use {
	'my/supercoolplugin',
	rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
	}
	-- You can specify rocks in isolation
	use_rocks 'penlight'
	use_rocks {'lua-resty-http', 'lpeg'}
	-- Local plugins can be included
	use '~/projects/personal/hover.nvim'
	-- Plugins can have post-install/update hooks
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
	-- Post-install/update hook with neovim command
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	-- Post-install/update hook with call of vimscript function with argument
	use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
	-- Use specific branch, dependency and run lua file after load
	use {
	'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
	requires = {'kyazdani42/nvim-web-devicons'}
	}
	-- Use dependency and run lua function after load
	use {
	'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
	config = function() require('gitsigns').setup() end
	}
	-- You can specify multiple plugins in a single call
	use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
	-- You can alias plugin names
	use {'dracula/vim', as = 'dracula'}
	end)
	--]]
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
