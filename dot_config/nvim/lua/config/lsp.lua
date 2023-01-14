-- LSP settings.
-- Disable virtual text
vim.diagnostic.config({ virtual_text = true })

-- Adding diagnostic signs for errors and warnings
local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn",  text = "▲" },
    { name = "DiagnosticSignHint",  text = "⚑" },
    { name = "DiagnosticSignInfo",  text = "" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
---- Adding borders to floating windows ----
-- Set borders for floating definitions
-- Making the borders white no matter the colorscheme
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white]]
local handlers = {
    -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('gD', vim.lsp.buf.type_definition, 'Type [D]efinition')
	-- NOTE: use WhichKey keymaps instead (in lsp)
	-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-S-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    clangd = {},
    gopls = {},
    bashls = {},
    pyright = {},
    rust_analyzer = {},
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    tsserver = {},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
	    if server_name == "clangd" then
		    capabilities.offsetEncoding = { "utf-16" }
		    require('lspconfig')[server_name].setup {
		        capabilities = capabilities,
		        on_attach = on_attach,
		        settings = servers[server_name],
		        handlers = handlers
		    }
	    else
		    require('lspconfig')[server_name].setup {
		        capabilities = capabilities,
		        on_attach = on_attach,
		        settings = servers[server_name],
		        handlers = handlers
		    }
	    end
    end,
}


-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
-- NOTE: Install lspkind-nvim and then enable 'formatting' down there
local lspkind = require('lspkind')

cmp.setup {
    snippet = {
        expand = function(args)
	        luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ---@diagnostic disable-next-line: missing-parameter
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        -- NOTE: For tab completion, comment out to use arrow keys only
        ['<Tab>'] = cmp.mapping(function(fallback)
	        if cmp.visible() then
		        cmp.select_next_item()
	        elseif luasnip.expand_or_jumpable() then
		        luasnip.expand_or_jump()
	        else
		        fallback()
	        end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
	        if cmp.visible() then
		        cmp.select_prev_item()
	        elseif luasnip.jumpable( -1) then
		        luasnip.jump( -1)
	        else
		        fallback()
	        end
        end, { 'i', 's' }),
    },
    sources = {
        -- NOTE: the order of sources is reflected in the appearance of suggestions
        -- i.e: having luasnip avove nvim_lsp will prioritise snippets over lsp suggestions
        { name = 'nvim_lua' }, -- source for nvim-lua API
        { name = 'nvim_lsp' }, -- source for nvim builtin lsp-client
        -- { name = "codeium" },
        { name = 'luasnip' }, -- source for snippets
        {
            name = 'path', -- source for path completion
            option = {
                trailing_slash = true,
            },
        },
        { name = 'buffer', keyword_length = 5 }, -- source for text-in-buffer completion
    },
    formatting = {
        format = lspkind.cmp_format(
        -- NOTE: Enable only if you want to know the completion origin
        -- {
        --   mode = "symbol_text",
        --   menu = ({
        --     buffer = "[Buffer]",
        --     nvim_lsp = "[LSP]",
        --     luasnip = "[LuaSnip]",
        --     nvim_lua = "[Lua]",
        --     latex_symbols = "[Latex]",
        --   })
        -- }
        ),
    },
}
-- autopairs when selecting a function
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- null-ls setup
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        ---- C
        null_ls.builtins.diagnostics.cppcheck,

        ---- JS
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint,

        ---- Golang
        null_ls.builtins.formatting.golines.with({ extra_args = vim.split("-m 90", " ", {}) }),
        -- null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        -- null_ls.builtins.diagnostics.revive,

        ---- Python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black.with({
            extra_args = { "-l", "90" }
        }),
        null_ls.builtins.diagnostics.flake8.with({
            extra_args = { "--max-line-length", "90" }
        }),

        ---- SQL
        null_ls.builtins.formatting.sql_formatter.with({
            extra_args = { "-l", "postgresql" }
        }),
        null_ls.builtins.formatting.sqlformat.with({
            extra_args = vim.split("-k upper -i lower", " ", {})
            -- extra_args = { "-k", "upper", "-i", "lower" },
        }),
        -- null_ls.builtins.formatting.sqlfluff.with({
        --   extra_args = { "--dialect", "sql" }, -- change to your dialect
        -- }),
        -- null_ls.builtins.diagnostics.sqlfluff.with({
        --   extra_args = { "--dialect", "mysql" }, -- change to your dialect
        -- }),


        ---- HTML, CSS, js
        null_ls.builtins.formatting.prettier,

        ---- For bash
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt,
    },
})

require('mason-null-ls').setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
})
-- Required when `automatic_setup` is true
require('mason-null-ls').setup_handlers()
