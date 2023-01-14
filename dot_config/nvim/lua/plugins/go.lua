return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua', -- recommanded if need floating window support
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end
  },
  -- { -- Better tooling for Golang
  --   "olexsmir/gopher.nvim",
  --   dependencies = { -- dependencies
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- }
}
