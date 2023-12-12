return {
	-- LSP Support
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = false,
		config = function()
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)
		end,
	},
	{ 'williamboman/mason.nvim', config = true },
	{ 'neovim/nvim-lspconfig',   depends = { 'VonHeikemen/lsp-zero.nvim' } },
	{
		'williamboman/mason-lspconfig.nvim',
		depends = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim', 'VonHeikemen/lsp-zero.nvim', 'williamboman/mason-lspconfig.nvim' },
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { "lua_ls", "rust_analyzer" },
				handlers = {
					require('lsp-zero').default_setup,

				},
			})
		end
	},
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'L3MON4D3/LuaSnip', 'VonHeikemen/lsp-zero.nvim', 'hrsh7th/cmp-nvim-lsp' }
		},
		config = function()
			local cmp = require('cmp')
			local cmp_action = require('lsp-zero').cmp_action()

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					-- `Enter` key to confirm completion
					['<CR>'] = cmp.mapping.confirm({ select = false }),

					-- Ctrl+Space to trigger completion menu
					['<C-Space>'] = cmp.mapping.complete(),

					-- Navigate between snippet placeholder
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),

					-- Scroll up and down in the completion documentation
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
				})
			})

			-- Set up lspconfig.
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			require('lspconfig').rust_analyzer.setup({
				capabilities = capabilities
			})
			require('lspconfig').lua_ls.setup({
				capabilities = capabilities,
				filetypes = { 'rust' }
			})
		end
	},
}
