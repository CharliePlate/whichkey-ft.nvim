local M = {}
local whichkey = require("which-key")

M.config = {
	enable = true,
	filetypes = {
		go = {
			L = {
				name = "Go",
				i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
				t = { "<cmd>GoMod tidy<cr>", "Tidy" },
				a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
				A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
				E = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
				g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
				f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
				e = { "<cmd>GoIfErr<cr>", "Go If Err" },
				c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
			},
		},
		typescript = {
			t = {
				name = "TypeScript",
				a = { "<cmd>TSLspOrganize<cr>", "Organize Imports" },
				A = { "<cmd>TSLspOrganize<cr>", "Organize Imports" },
				f = { "<cmd>TSLspFixCurrent<cr>", "Fix Current" },
				F = { "<cmd>TSLspFixCurrent<cr>", "Fix Current" },
				r = { "<cmd>TSLspRenameFile<cr>", "Rename File" },
				R = { "<cmd>TSLspRenameFile<cr>", "Rename File" },
				i = { "<cmd>TSLspImportAll<cr>", "Import All" },
				I = { "<cmd>TSLspImportAll<cr>", "Import All" },
			},
		},
	},
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

-- M.setup()
