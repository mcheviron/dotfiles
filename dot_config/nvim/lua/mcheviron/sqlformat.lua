-- TODO: implement for Python and Rust as well

-- TODO: Implement conditional logic to select the proper
-- logic based on the language and send a friendly message
-- if the language isn't supported
local embedded_sql = vim.treesitter.parse_query(
	"go",

	[[
	(call_expression (selector_expression field: (field_identifier ) @field (#contains? @field  "Exec" "Query" "QueryRow" "Prepare" "QueryContext" "QueryRowContext")) (argument_list (raw_string_literal) @sql))
	]]
)
local run_formatter = function(text)
	local result = string.gsub(text, "`", "")
	local bin = vim.api.nvim_get_runtime_file("sql_format.py", false)[1]
	local j = require("plenary.job"):new {
		command = "python",
		args = { bin },
		writer = { result },
	}
	return j:sync()
end

-- local function run_formatter(unformatted_sql, sql_lang)
-- 	local formatted = vim.fn.systemlist([[echo "]] ..
-- 		string.gsub(unformatted_sql, "`", "") .. [[" | sqlformat -k upper - | sql-formatter -l ]] .. sql_lang)
--
-- 	return formatted
-- end

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "go", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local function format_sql(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].filetype ~= "go" then
		vim.notify "Can only be used in Go"
	end

	local root = get_root(bufnr)
	local changes = {}
	local start
	for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_sql.captures[id]
		if name == "field" then
			local field_range = { node:range() }
			start = field_range[4]
		end
		if name == "sql" then
			-- {start_row, start_col, end_row, end_col}
			local range = { node:range() }
			-- align the query with the method call
			local indent = string.rep(" ", start)
			local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))
			for index, line in ipairs(formatted) do
				formatted[index] = indent .. line
			end
			table.insert(changes, 1,
				{
					start = range[1] + 1,
					final = range[3],
					formatted = formatted
				})
		end
	end
	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
	end
end

vim.api.nvim_create_user_command("SqlFormat", function()
	format_sql(bufnr)
end, {})

local group = vim.api.nvim_create_augroup("sql-formatter", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*.go",
	callback = function()
		format_sql()
	end
})
