return {
  "akinsho/nvim-bufferline.lua",
  event = "VeryLazy",
  config = function()
    -- Setting up bufferline
    require("bufferline").setup {
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator_icon = nil,
        indicator = {
          style = "icon", -- icon | undelrine | none
          icon = "|",
        },
        buffer_close_icon = "",
        -- buffer_close_icon = '',
        modified_icon = "●",
        -- close_icon = "",
        -- close_icon = '',
        left_trunc_marker = "",
        right_trunc_marker = "",
        tab_size = 25,
        max_name_length = 25,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc" | false,
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   local s = " "
        --   for e, n in pairs(diagnostics_dict) do
        --     local sym = e == "error" and " "
        --         or (e == "warning" and " " or "i")
        --     s = s .. n .. sym
        --   end
        --   return s
        -- end,
        offsets = { { filetype = "NvimTree", text = "", separator = true } },
        color_icons = true, -- true | false --> whether or not to add the filetype icon highlights
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- slant | padded_slant | thick | thin
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
        sort_by = "insert_at_end"
        -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      },
    }
  end
}
