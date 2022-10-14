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
		ts = {
			L = {
				name = "JS",
				i = { "<cmd>TSInstallFromGrammar<Cr>", "Install TS Grammar" },
				u = { "<cmd>TSUpdate<Cr>", "Update TS Grammars" },
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

M.setup = function()
	if not M.config.enable then
		return
	end
	local filetypes = M.config.filetypes
	for ft, _ in pairs(filetypes) do
		M.create_autocmd(ft)
	end
end

return M

-- M.setup()
