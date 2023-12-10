return {
	-- LSP Support
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = function()
			require('lsp-zero').setup_servers({ 'rust_analyzer' })
		end,
	},
	{ 'neovim/nvim-lspconfig', depends = { 'VonHeikemen/lsp-zero.nvim' } },
	{
		'williamboman/mason-lspconfig.nvim',
		depends = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim', 'VonHeikemen/lsp-zero.nvim' },
		config = function()
			local util = require('lspconfig/util')
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "rust_analyzer" },
			}

			require("lspconfig").lua_ls.setup {
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
						client.config.settings = vim.tbl_deep_extend('force',
							client.config.settings, {
								Lua = {
									runtime = {
										-- Tell the language server which version of Lua you're using
										-- (most likely LuaJIT in the case of Neovim)
										version = 'LuaJIT'
									},
									-- Make the server aware of Neovim runtime files
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME
											-- "${3rd}/luv/library"
											-- "${3rd}/busted/library",
										}
										-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
										-- library = vim.api.nvim_get_runtime_file("", true)
									}
								}
							})

						client.notify("workspace/didChangeConfiguration",
							{ settings = client.config.settings })
					end
					return true
				end

			}
			require("lspconfig").rust_analyzer.setup {
				filetypes = { "rust" },
				root_dir = util.root_pattern("Cargo.toml"),
				setting = {
					['rust-analyzer'] = {
						cargo = { allFeatures = true }
					}
				}

			}

			vim.keymap.set("n", "<Leader>ff", "<CMD>lua vim.lsp.buf.format()<CR>")
		end
	},
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'L3MON4D3/LuaSnip', 'VonHeikemen/lsp-zero.nvim' }
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
		end
	},
}
