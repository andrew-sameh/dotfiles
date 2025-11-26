-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true

-- Keep your existing options here if you already have this file.
-- Add the OSC52 bits below.

-- Always route yanks to system clipboard
-- vim.opt.clipboard = "unnamedplus"
--
-- -- Use Neovim's built-in OSC52 provider.
-- -- IMPORTANT: do NOT `require` it; access via vim.ui.clipboard.osc52.
-- local osc = vim.ui and vim.ui.clipboard and vim.ui.clipboard.osc52
--
-- if osc and type(osc.copy) == "function" and type(osc.paste) == "function" then
--   -- Full read/write over OSC52 (works if your terminal allows clipboard reads)
--   vim.g.clipboard = {
--     name = "osc52",
--     copy = {
--       ["+"] = osc.copy("+"),
--       ["*"] = osc.copy("*"),
--     },
--     paste = {
--       ["+"] = osc.paste("+"),
--       ["*"] = osc.paste("*"),
--     },
--   }
-- else
--   -- Fallback: let Neovim resolve the osc52 provider internally (0.10+)
--   vim.g.clipboard = "osc52"
-- end
