return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = function(_, opts)
      math.randomseed(os.time())
      local choose = function(choices)
        return choices[math.random(1, #choices)]
      end
      opts.custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.sky },
          Comment = { fg = colors.teal },
          WinSeparatorInactive = { fg = colors.surface2 },
          DashboardHeader = {
            fg = choose({
              colors.sky,
              colors.flamingo,
              colors.pink,
              colors.blue,
              colors.yellow,
              colors.peach,
              colors.rosewater,
              colors.red,
              colors.maroon,
              colors.mauve,
              colors.teal,
            }),
          },
          DashboardTitle = { fg = colors.teal, bold = true },
          DashboardKey = { fg = colors.peach, bold = true },
        }
      end

      opts.transparent_background = true
      return opts
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- Set up dynamic window highlighting after colorscheme is loaded
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "catppuccin*",
        callback = function()
          local colors = require("catppuccin.palettes").get_palette()
          -- Set active window border color
          vim.api.nvim_set_hl(0, "WinSeparatorActive", { fg = colors.mauve })
          vim.api.nvim_set_hl(0, "WinSeparatorInactive", { fg = colors.surface2 })
        end,
      })
      -- Apply highlighting based on window focus
      vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        callback = function()
          vim.wo.winhighlight = "WinSeparator:WinSeparatorActive"
        end,
      })

      vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
        callback = function()
          vim.wo.winhighlight = "WinSeparator:WinSeparatorInactive"
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
