require("lualine").setup({
	options = {
		theme = {
			normal = {
				a = { bg = "#FFFFFF" },
				b = { bg = "#FFFFFF" },
				c = { bg = "#FFFFFF" },
				x = { bg = "#424242", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
			insert = {
				x = { bg = "#345C7D", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
			visual = {
				x = { bg = "#9E7B1C", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
			replace = {
				x = { bg = "#6A4C7C", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
			command = {
				x = { bg = "#993333", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
			inactive = {
				x = { bg = "#555555", fg = "#FFFFFF", gui = "bold" },
				y = { bg = "#2e2e2e", fg = "#FFFFFF" },
				z = { bg = "#050505", fg = "#FFFFFF" },
			},
		},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		icons_enabled = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { {
			"mode",
			fmt = function(x)
				return x:sub(1, 1):lower()
			end,
		} },
		lualine_y = {
			{
				"filetype",
				cond = function()
					local hide = { TelescopePrompt = true, toggleterm = true }
					return not hide[vim.bo.filetype]
				end,
			},
			{
				"lsp",
				fmt = function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					for _, client in pairs(clients) do
						if client.name ~= "copilot" then
							return "  " .. client.name
						end
					end
					return "  off"
				end,
				color = { bg = "#1a1a1a", fg = "#FFFFFF" },
			},
		},
		lualine_z = { { "branch", icon = "" } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "oil" },
})
