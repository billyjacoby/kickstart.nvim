return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { 
		"nvim-lua/plenary.nvim",
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	keys = {
		{ "<leader>p", "<cmd>Telescope find_files<cr>", desc = "Find files with Telescope" },
	},
	config = function()
		require('telescope').setup({
			defaults = {
				mappings = {
					i = {
						["<C-h>"] = "which_key"
					}
				}
			},
		})
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
