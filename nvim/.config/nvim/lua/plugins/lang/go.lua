return {
  {
    "leoluz/nvim-dap-go",
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "gomodifytags", "impl", "gopls", "delve", "goimports", "gofumpt", "golangci-lint" } },
  },
}
