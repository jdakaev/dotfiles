return 
-- init.lua:
{
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },

	keys = {
		{ "<leader>ff", function() require('telescope.builtin').find_files() end},
		{ "<leader>fh", function() require('telescope.builtin').help_tags() end},
		{ "<leader>fg", function() require('telescope.builtin').live_grep() end},
		{ "<leader>fb", function() require('telescope.builtin').buffers() end},
	}
}

