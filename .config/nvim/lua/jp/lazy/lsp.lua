return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "eslint",
                "ts_ls",
                "html",
                "tailwindcss",
                "clangd",
            },
            automatic_enable = true, -- Mason-LSPConfig v2 auto-enables servers by default
        })

        vim.lsp.config('*', {
            -- any custom settings for all servers
        })
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    runtime = { version = 'Lua 5.1' },
                    diagnostics = {
                        globals = { 'bit', 'vim', 'it', 'describe', 'before_each', 'after_each' },
                    },
                },
            },
        })

        -- vue being annoying
        local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
        local vue_plugin_path = vue_ls_path .. "/node_modules/@vue/language-server"
        require("lspconfig").ts_ls.setup({
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vue_plugin_path,
                languages = { "vue" },
              },
            },
          },
          filetypes = { "typescript", "javascript", "vue" },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            update_in_insert = true,
            virtual_text = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
        vim.o.updatetime = 500
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
    end
}
