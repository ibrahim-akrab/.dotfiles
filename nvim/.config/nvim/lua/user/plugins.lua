return {
  -- You can also add new plugins here as well:
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {'fedepujol/bracket-guides', lazy = false},
  { "nvim-telescope/telescope-project.nvim", lazy = false},
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function() 
      require("telescope").setup {
      }
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension "file_browser"

    end
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
      require('telescope').load_extension('projects')
    end,
  },
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
