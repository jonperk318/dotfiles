return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "eslint", "pyright" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
