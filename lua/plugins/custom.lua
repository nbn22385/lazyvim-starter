-- TODO: split into separate files
return {
  {
    {
      "rose-pine/neovim",
      name = "rose-pine",
      opts = function(_, opts)
        opts.variant = "moon"
        opts.dark_variant = "moon"
      end,
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "rose-pine",
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = LazyVim.config.icons.diagnostics.Error,
                warn = LazyVim.config.icons.diagnostics.Warn,
                info = LazyVim.config.icons.diagnostics.Info,
                hint = LazyVim.config.icons.diagnostics.Hint,
              },
            },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            -- Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              "diff",
              symbols = {
                added = LazyVim.config.icons.git.added,
                modified = LazyVim.config.icons.git.modified,
                removed = LazyVim.config.icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            { "filetype", icon_only = false, icons_enabled = false, separator = "", padding = { left = 1, right = 1 } },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = { { "branch", icon = "" } },
        },
      },
    },
    { "akinsho/bufferline.nvim", enabled = false },
    {
      "folke/flash.nvim",
      keys = {
        { "s", mode = { "n", "x", "o" }, false },
        { "S", mode = { "n", "x", "o" }, false },
      },
    },
    { "snacks.nvim", opts = { dashboard = { enabled = false } } },
    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      },
    },
  },
}
