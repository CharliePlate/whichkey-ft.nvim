## Whichkey-FT
A small, lightweight plugin to create filetype specific whichkey bindings. 

Default Config
```
{
	enable = true, -- If false, plugin is disabled
	filetypes = {},  -- filetype with nested table that includes mappings. Example below
	whichkey_opts = {   --default options for whichkey.register
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	},
}
```

Install using Packer
```
use({"charlieplate/whichkey-ft.nvim", requires={"folke/which-key.nvim"}})
```

Example config with Go and Typescript mappings
```
require("whichkey-ft").setup({
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
})
```

Currently, this creates a global keymapping. This fits my use case, but could certainly consider adding a buffer specific keybinding.
