return {
  -- You can also add new plugins here as well:
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "rust_analyzer",
      },
    },
  },
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {"folke/tokyonight.nvim", lazy = false},
  {"lunarvim/Onedarker.nvim", lazy = false},
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    config = function()
      require("monokai-pro").setup()
    end
  },
  {
    "folke/trouble.nvim",
    lazy = false,
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "rust" },
    opts = function()
      return {
        server = require("astronvim.utils.lsp").config "rust_analyzer",
      }
    end,
  },
}
