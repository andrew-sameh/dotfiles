return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = (function()
      -- Determine current hour for greeting and ascii art selection.
      local time = os.date("*t")
      local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
      local hour = time.hour
      local name = "Andrew"
      local greetings = {
        [1] = "  Sleep well",
        [2] = "  Good morning",
        [3] = "  Good afternoon",
        [4] = "  Good evening",
        [5] = "󰖔  Good night",
      }

      local greetingIndex = 2
      local ansiArt = "gopher"
      if hour < 7 or hour == 23 then
        greetingIndex = 1
        ansiArt = "thisisfine"
      elseif hour < 12 then
        greetingIndex = 2
        ansiArt = "gopher"
      elseif hour >= 12 and hour < 13 then
        greetingIndex = 3
        ansiArt = "apple"
      elseif hour >= 13 and hour < 18 then
        greetingIndex = 3
        ansiArt = "gopher_red"
      elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
        ansiArt = "unicorn"
      elseif hour >= 21 then
        greetingIndex = 5
        ansiArt = "thisisfine"
      end
      -- local greeting = greetings[greetingIndex]
      local greeting = datetime .. "  " .. greetings[greetingIndex] .. ", " .. name

      -- Construct the ascii art file path.
      local dotfiles = vim.fn.expand("$DOTFILES")
      local ascii_art_path = dotfiles .. "/nvim/.config/nvim/ansi/" .. ansiArt .. ".sh"
      local static_header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
      local logo = [[
                                                                    
       ████ ██████           █████      ██                    
      ███████████             █████                            
      █████████ ███████████████████ ███   ███████████  
     █████████  ███    █████████████ █████ ██████████████  
    █████████ ██████████ █████████ █████ █████ ████ █████  
  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
 ██████  █████████████████████ ████ █████ █████ ████ ██████]]
      return {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,

          -- Static Headers
          -- header = [[
          --        ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
          --        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
          --        ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
          --        ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
          --        ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
          --        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
          -- ]],
          header = logo .. "\n\n" .. greeting,

          ---@type snacks.dashboard.Item[]
          -- stylua: ignore
          -- preset.keys = {
          --   { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          --   { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          --   { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          --   { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          --   { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          --   { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          --   { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          --   { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          --   { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          -- }
        },
        -- item field formatters
        formats = {
          key = { "%s", hl = "DashboardKey" },
          footer = { "%s", align = "center" },
          header = { "%s", hl = "DashboardHeader", align = "center" },
          title = { "%s", hl = "DashboardTitle" },
        },
        sections = {
          -- {
          --   section = "terminal",
          --   cmd = "cat |" .. vim.fn.shellescape(ascii_art_path),
          --   height = 24,
          --   width = 45,
          --   padding = 0,
          --   indent = 5,
          -- },
          -- { padding = 0, align = "center", text = { header, hl = "header" } },
          -- { padding = 2, align = "center", text = { greeting(), hl = "header" } },
          { section = "header", hl = "header" },
          { section = "keys", gap = 0, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      }
    end)(),
  },
}
