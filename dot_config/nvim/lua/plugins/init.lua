return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- ful status updates for LSP
      -- Replaced by noice.nvim
      -- 'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    }
  },

  'jose-elias-alvarez/null-ls.nvim',
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-buffer', 'onsails/lspkind.nvim' },
  },
  {
    'L3MON4D3/LuaSnip',
    lazy = false,
    config = function()
      -- This is the painpoint for loading time. Make sure to use only the snippets you need and not to load
      -- snippets everytime
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local/share/nvim/lazy/friendly-snippets" } })
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config       = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  -- "mg979/vim-visual-multi",
  -- "asiryk/auto-hlsearch.nvim",
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  "rafamadriz/friendly-snippets",
  "ziontee113/query-secretary",
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  'p00f/nvim-ts-rainbow',
  'folke/lsp-colors.nvim',
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true; -- Bind default mappings
      }
    end
  },
  -- 'dstein64/vim-startuptime',
  {
    'nvim-treesitter/playground',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  {
    'RRethy/vim-illuminate',
    lazy = false,
  },
  { -- Better tooling for Golang
    "olexsmir/gopher.nvim",
    dependencies = { -- dependencies
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  -- Alpha
  -- "goolord/alpha-nvim",
  -- Easy movements
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "\\", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "\\\\", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", --  for stability; omit to  `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to  defaults
      })
    end
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    priority = 100,
  },
  -- Colorschemes
  'navarasu/onedark.nvim',
  'Mofiqul/dracula.nvim',
  'Mofiqul/vscode.nvim',
  'folke/tokyonight.nvim',
  'catppuccin/nvim',

  -- Fancier statusline
  { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help indent_blankline.txt`
      require('indent_blankline').setup {
        char = '┊',
        show_trailing_blankline_indent = false,
      }
    end }, -- Add indentation guides even on blank lines

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end
  },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

}
