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
          -- TabLineSel = { bg = colors.pink },
          -- CmpBorder = { fg = colors.surface2 },
          -- Pmenu = { bg = colors.none },
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
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
