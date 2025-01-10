-- Add Biome to the existing LSP configuration
local servers = {
  biome = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
    },
  },
}

-- Extend the ensure_installed list
local ensure_installed = vim.list_extend(
  { "biome" },
  vim.tbl_keys(servers or {})
)

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "biome")
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        -- Disable formatting in typescript-tools since we'll use Biome
        format = false,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.typescript = { "biome" }
      opts.formatters_by_ft.javascript = { "biome" }
      opts.formatters_by_ft.typescriptreact = { "biome" }
      opts.formatters_by_ft.javascriptreact = { "biome" }
      opts.formatters_by_ft.json = { "biome" }
    end,
  },
} 