return {
    {
        "bjarneo/aether.nvim",
        name = "aether",
        priority = 1000,
        opts = {
            disable_italics = false,
            colors = {
                -- Monotone shades (base00-base07)
                base00 = "#0D1418", -- Default background
                base01 = "#3b4850", -- Lighter background (status bars)
                base02 = "#0D1418", -- Selection background
                base03 = "#3b4850", -- Comments, invisibles
                base04 = "#D7D6C5", -- Dark foreground
                base05 = "#fdfcfb", -- Default foreground
                base06 = "#fdfcfb", -- Light foreground
                base07 = "#D7D6C5", -- Light background

                -- Accent colors (base08-base0F)
                base08 = "#C89C6C", -- Variables, errors, red
                base09 = "#e4c9ac", -- Integers, constants, orange
                base0A = "#CCCBB9", -- Classes, types, yellow
                base0B = "#89ae96", -- Strings, green
                base0C = "#A6C6C8", -- Support, regex, cyan
                base0D = "#89bacd", -- Functions, keywords, blue
                base0E = "#b8adb6", -- Keywords, storage, magenta
                base0F = "#f3f3ee", -- Deprecated, brown/yellow
            },
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "aether",
        },
    },
}
