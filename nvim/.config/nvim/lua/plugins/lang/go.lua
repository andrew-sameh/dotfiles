return {
  {
    "leoluz/nvim-dap-go",
    opts = {},
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "gomodifytags", "impl", "gopls", "delve", "goimports", "gofumpt", "golangci-lint" } },
  },
}
