return {
    "ray-x/go.nvim",
    lazy = true,
    devDependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup({
            gofmt = "golines",

            max_line_len = 120,

            golines_args = {
                "-m",
                "120",
                "--base-formatter",
                "goimports",
            },
        })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()",
}
