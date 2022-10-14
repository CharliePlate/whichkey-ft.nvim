local M = {}
local whichkey = require("which-key")

M.config = {
	enable = true,
	filetypes = {},
	whichkey_opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	},
}

M.create_autocmd = function(filetype)
	vim.api.nvim_create_autocmd("BufWinEnter", {
		pattern = "*." .. filetype,
		command = 'lua require("packages.whichkey-filetype").create_mapping("' .. filetype .. '")',
	})
end

M.create_mapping = function(ft)
	local opts = M.config.whichkey_opts
	local mappings = M.config.filetypes[ft]
	whichkey.register(mappings, opts)
end

M.setup = function(config)
	if not config.enabled then
		return
	end
	if config then
		M.config = vim.tbl_deep_extend("force", M.config, config)
	end
	local filetypes = config
	for ft, _ in pairs(filetypes) do
		M.create_autocmd(ft)
	end
end

return M
