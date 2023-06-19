return {
  -- You can also add new plugins here as well:
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {'fedepujol/bracket-guides', lazy = false},
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
    lazy=false,
    dependencies = {"mason-lspconfig.nvim"},
  },
}
