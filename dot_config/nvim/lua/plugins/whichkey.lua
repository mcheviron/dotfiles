return {
    {
        "folke/which-key.nvim",
        config = function()
            local status_ok, which_key = pcall(require, "which-key")
            if not status_ok then
                return
            end

            local setup = {
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                -- operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<cr>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                window = {
                    border = "none", -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0,
                },
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height of the columns
                    width = { min = 20, max = 50 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                    align = "left", -- align columns left, center or right
                },
                ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
                show_help = true, -- show help message on the command line when the popup is visible
                triggers = "auto", -- automatically setup triggers
                -- triggers = {"<leader>"} -- or specify a list manually
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for key maps that start with a native binding
                    -- most people should not need to change this
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
            }

            local opts = {
                mode = "n", -- NORMAL mode
                prefix = "<leader>",
                buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
                silent = true, -- use `silent` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
                nowait = true, -- use `nowait` when creating keymaps
            }

            local mappings = {
                ["a"] = { ":Alpha<cr>", "Alpha" },
                -- ["w"] = { "<cmd>w!<CR>", "Save" },
                -- ["q"] = { "<cmd>q!<CR>", "Quit" },
                -- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
                -- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
                -- g = {
                --   name = "Git",
                --   g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
                --   j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
                --   k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
                --   l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
                --   p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
                --   r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                --   R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                --   s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                --   u = {
                --     "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                --     "Undo Stage Hunk",
                --   },
                --   o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                --   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                --   c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                --   d = {
                --     "<cmd>Gitsigns diffthis HEAD<cr>",
                --     "Diff",
                --   },
                -- },
                ["b"] = {
                    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
                    "Buffers",
                },
                ["e"] = { "<cmd>NeoTreeFloatToggle<cr>", "Explorer" },
                ["L"] = { "<cmd>Lazy<cr>", "Lazy" },
                ["z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
                s = {
                    name = "Search",
                    -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                    -- R = { "<cmd>Telescope registers<cr>", "Registers" },
                    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
                    f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
                    w = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Word" },
                    g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep" },
                    d = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Diagnostics" },
                    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
                    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                    c = { "<cmd>Telescope commands<cr>", "Commands" },
                    t = { "<cmd>TodoTelescope<cr>", "TODO" }
                },
                l = {
                    name = "LSP",
                    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
                    d = {
                        "<cmd>Telescope diagnostics bufnr=0<cr>",
                        -- "<cmd>Lspsaga show_buf_diagnostics<CR>",
                        "Document Diagnostics",
                    },
                    w = {
                        "<cmd>Telescope diagnostics<cr>",
                        "Workspace Diagnostics",
                    },
                    i = { "<cmd>LspInfo<cr>", "Info" },
                    -- j = {
                    --   "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                    --   "Next Diagnostic",
                    -- },
                    -- k = {
                    --   "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
                    --   "Prev Diagnostic",
                    -- },
                    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
                    -- q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
                    r = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
                    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                    S = {
                        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                        "Workspace Symbols",
                    },
                },
                -- t = {
                --   name = "Terminal",
                --   l = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
                --   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "htop" },
                --   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
                --   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "ncdu" },
                --   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
                --   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
                --   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
                -- },
                g = {
                    name = "Golang",
                    e = { '<cmd>GoIfErr<cr>', "GoIfErr" },
                    f = {
                        name = "Fill",
                        s = { "<cmd>GoFillStruct<cr>", "Fill Struct" },
                        S = { "<cmd>GoFillSwitch<cr>", "Fill Switch" },
                        p = { "<cmd>GoFixPlurals<cr>", "Fix Plurals" },
                    },
                    m = {
                        name = "Mod",
                        i = { function()
                            local mod_name = vim.fn.input "Module name: "
                            vim.api.nvim_command("GoModInit " .. mod_name)
                        end, "GoModInit"
                        },
                        t = { "<cmd>GoModTidy<cr>", "GoModTidy" },
                    },
                    g = { function()
                        local url = vim.fn.input("URL: ")
                        vim.api.nvim_command("GoGet " .. url)
                    end, "go get" },
                    r = { "<cmd>GoRename<cr>", "GoRename" },
                    i = { function()
                        local interface = vim.fn.input("Interface: ")
                        vim.api.nvim_command("GoImpl " .. interface)
                    end, "GoImpl" },
                    C = { function()
                        local query = vim.fn.input("Query: ")
                        vim.api.nvim_command("GoCheat " .. query)
                    end, "GoCheat" },
                    d = { function()
                        local query = vim.fn.input("Query: ")
                        vim.api.nvim_command("GoDoc " .. query)
                    end, "GoDoc" },
                    c = { ':GoCmt<cr>', "GoComment" },
                    G = { ':GoGenerate %<cr>', "go generate" },
                    t = {
                        name = "Tag",
                        a = { function()
                            local tag = vim.fn.input("Tag: ")
                            vim.api.nvim_command("GoAddTag " .. tag)
                        end, "GoAddTag" },
                        r = { function()
                            local tag = vim.fn.input("Tag: ")
                            vim.api.nvim_command("GoRmTag " .. tag)
                        end, "GoRmTag" },
                        c = { "<cmd>GoClearTag<cr>", "GoClearTag" }
                    },
                    T = {
                        name = "Test",
                        f = { "<cmd>GoAddTest<cr>", "Generate function test" },
                        F = { "<cmd>GoAddAllTest -parallel<cr>", "Generate tests for all functions" },
                        E = { "<cmd>GoAddExpTest -parallel<cr>", "Generate tests for all exported functions" },
                        r = {
                            name = "Run",
                            f = { "<cmd>GoTestFunc<cr>", "Run func test" },
                            s = { "<cmd>GoTestFunc -s<cr>", "Select func to test" },
                            F = { "<cmd>GoTestFile<cr>", "Run file test" },
                            p = { "<cmd>GoTestPkg<cr>", "Run package test" },
                        }
                    },
                },
            }
            which_key.setup(setup)
            which_key.register(mappings, opts)
        end
    }
}
