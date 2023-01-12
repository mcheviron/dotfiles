return {

  "folke/noice.nvim",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      -- Silence some annoying and useless messages
      routes = {
        --------- Silece messages for pasting or deleting lines or making changes
        {
          filter = {
            event = "msg_show",
            find = "lines",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = '',
            find = "before",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = '',
            find = "changes",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = '',
            find = "change",
          },
          opts = { skip = true },
        },
        --------- Silece messages when writing to a buffer
        {
          filter = {
            event = "msg_show",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      -- Make cmdline appear in the middle of the screen
      views = {
        cmdline_popup = {
          position = {
            -- row = 20,
            --NOTE: better to make it adaptive
            -- just keep in mind that the nvim_win_get_height method gets
            -- the number at BufWinEnter so if you resize the window thereafter
            -- the cmdline_popup position won't update
            row = vim.api.nvim_win_get_height(0) / 3,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            -- row = 23,
            row = vim.api.nvim_win_get_height(0) / 3 + 3,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      }
    })
  end

}
