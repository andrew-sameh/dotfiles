-- return {
--   "alexghergh/nvim-tmux-navigation",
--   config = function()
--     local nvim_tmux_nav = require("nvim-tmux-navigation")
--
--     nvim_tmux_nav.setup({
--       disable_when_zoomed = false, -- defaults to false
--     })
--
--     vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
--     vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
--     vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
--     vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
--   end,
-- }

return {
  "christoomey/vim-tmux-navigator",
  enabled = true,
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", "Navigate Window Left" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", "Navigate Window Down" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", "Navigate Window Up" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", "Navigate Window Right" },
  },
}
