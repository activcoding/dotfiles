return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
        "windwp/nvim-ts-autotag",
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = { enable = true, mode = "topline", line_numbers = true },
        },
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "csv",
            "dockerfile",
            "gitcommit",
            "gitignore",
            "go",
            "hcl",
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
            "sql",
            "yaml",
        },
        auto_install = true,
    },
    config = function(_, opts)
        vim.treesitter.language.register("hcl", { "terraform", "tf" })

        local TS = require("nvim-treesitter")
        TS.setup(opts)

        -- install any missing parsers from ensure_installed
        local installed = TS.get_installed and TS.get_installed() or {}
        local installed_set = {}
        for _, lang in ipairs(installed) do
            installed_set[lang] = true
        end
        local missing = vim.tbl_filter(function(lang)
            return not installed_set[lang]
        end, opts.ensure_installed or {})
        if #missing > 0 then
            TS.install(missing)
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("hero_treesitter", { clear = true }),
            callback = function(ev)
                local ft = ev.match
                local lang = vim.treesitter.language.get_lang(ft) or ft

                -- try to start treesitter highlighting; fall back to legacy syntax
                local ok = pcall(vim.treesitter.start, ev.buf, lang)
                if not ok then
                    vim.bo[ev.buf].syntax = ft
                    return
                end

                -- treesitter-based indentation
                if opts.indent and opts.indent.enable then
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("hero_treesitter_ctx", { clear = true }),
            pattern = { "markdown" },
            callback = function()
                require("treesitter-context").disable()
            end,
        })
    end,
}
