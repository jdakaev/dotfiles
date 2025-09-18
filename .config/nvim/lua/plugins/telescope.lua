return 
-- init.lua:
{
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },

	keys = {
		{ "<leader>ff", require('telescope.builtin').find_files},
		{ "<leader>fh", require('telescope.builtin').help_tags},
		{ "<leader>fg", require('telescope.builtin').live_grep},
		{ "<leader>fb", require('telescope.builtin').buffers},
	}
}

