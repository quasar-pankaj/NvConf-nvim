return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'TechnicalDC/cmp-abl',
		'saadparwaiz1/cmp_luasnip',
		'L3MON4D3/LuaSnip',
	},
	config = function ()
		-- Setup nvim-cmp.
		local cmp = require'cmp'

		local max_count = 15

		local function border(hl_name)
			return {
				{ "┌", hl_name },
				{ "─", hl_name },
				{ "┐", hl_name },
				{ "│", hl_name },
				{ "┘", hl_name },
				{ "─", hl_name },
				{ "└", hl_name },
				{ "│", hl_name },
			}
		end

		--   פּ ﯟ   some other good icons
		local kind_icons = {
			Text          = "",
			Method        = "m",
			Function      = "",
			Constructor   = "",
			Field         = "",
			Variable      = "",
			Class         = "",
			Interface     = "",
			Module        = "",
			Property      = "",
			Unit          = "",
			Value         = "",
			Enum          = "",
			Keyword       = "",
			Snippet       = "",
			Color         = "",
			File          = "",
			Reference     = "",
			Folder        = "",
			EnumMember    = "",
			Constant      = "",
			Struct        = "",
			Event         = "",
			Operator      = "",
			TypeParameter = "",
		}

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = {
					winhighlight = "FloatBorder:None,CursorLine:PmenuSel,Normal:None",
					border = border(None),
					scrollbar = false,
				},
				documentation = {
					border = border(None),
					winhighlight = "FloatBorder:None,CursorLine:PmenuSel,Normal:None",
				},
			},
			mapping = cmp.mapping.preset.insert({
				['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
				['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = {
				-- fields = {"abbr", "kind"},
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					-- Kind icons
					-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					vim_item.menu = ({
						copilot	= "[Copilot]",
						luasnip	= "[LuaSnip]",
						nvim_lua = "[Nvim Lua]",
						nvim_lsp = "[LSP]",
						buffer	= "[Buffer]",
						abl		= "[ABL]",
						path		= "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = 'luasnip' }, -- For luasnip users.
				{ name = 'nvim_lsp' },
				{
					name = "nvim_lua",
					option = {
						max_item_count = max_count
					}
				},
				{
					name = 'buffer',
					option = {
						keyword_length = 1
					}
				},
				{ name = 'path' },
				{ name = 'orgmode' },
			}),
			experimental = {
				ghost_text = false
			}
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("progress", {
			sources = cmp.config.sources({
				{
					name = 'abl',
					option = {
						max_item_count = max_count
					}
				}, -- For Progress 4GL
				{ name = "path" },
				{ name = 'luasnip' }, -- For luasnip users.
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({'/','?'}, {
			formatting = {
				fields = { "kind", "abbr" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						buffer = "[Buffer]"
					})[entry.source.name]
					return vim_item
				end,
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{
					name = 'buffer',
					option = {
						max_item_count = max_count
					}
				}
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			formatting = {
				fields = { "kind", "abbr" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{
					name = 'path',
					option = {
						max_item_count = max_count
					}
				}
			},
			{
				{
					name = 'cmdline',
					option = {
						max_item_count = max_count
					}
				}
			})
		})
	end
}
