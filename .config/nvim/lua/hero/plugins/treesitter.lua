return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = { enable = true, mode = "topline", line_numbers = true },
        },
    },
    config = function()
        require("nvim-treesitter").setup()

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                local ok = pcall(vim.treesitter.start, args.buf)
                if not ok then
                    vim.bo[args.buf].syntax = "on"
                end
            end,
        })

        require("nvim-treesitter").install({
            "csv",
            "dockerfile",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "proto",
            "python",
            "rego",
            "ruby",
            "sql",
            "svelte",
            "yaml",
            "php",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown" },
            callback = function()
                require("treesitter-context").disable()
            end,
        })
    end,
}
