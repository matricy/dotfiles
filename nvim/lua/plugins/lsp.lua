return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- Enable completion capabilities for all LSPs
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("sourcekit", {
				cmd = { "sourcekit-lsp" },
				filetypes = { "swift" },
				root_markers = { "Package.swift", ".git" },
				capabilities = capabilities,
			})

			vim.lsp.enable("sourcekit")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- Keymaps (only available when LSP is attached)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					local tele = require("telescope.builtin")

					-- Navigation
					map("gd", tele.lsp_definitions, "Goto Definition")
					map("<leader>ft", tele.lsp_type_definitions, "Goto Type")
					map("<leader>fr", tele.lsp_references, "Goto References")
					map("<leader>fi", tele.lsp_implementations, "Goto Impl")

					-- Search symbols
					map("<leader>fs", tele.lsp_document_symbols, "Doc Symbols")
					map("<leader>fS", tele.lsp_dynamic_workspace_symbols, "Workspace Symbols")

					-- Info & diagnostics
					map("K", vim.lsp.buf.hover, "Hover")
					map("<leader>k", vim.lsp.buf.signature_help, "Signature Help")
					map("<leader>E", vim.diagnostic.open_float, "Diagnostic Float")

					-- Actions
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>wf", vim.lsp.buf.format, "Format")

					-- Visual mode code action
					vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, {
						buffer = ev.buf,
						desc = "LSP: Code Action",
					})

					-- Auto-format on save
					if
							client
							and not client:supports_method("textDocument/willSaveWaitUntil")
							and client:supports_method("textDocument/formatting")
					then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = ev.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
							end,
						})
					end
				end,
			})
		end,
	},
}
