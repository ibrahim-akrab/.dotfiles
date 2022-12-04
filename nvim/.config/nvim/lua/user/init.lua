RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

local config = {
  --   -- set vim options here (vim.<first_key>.<second_key> =  value)
    options = {
      opt = {
        relativenumber = true, -- sets vim.opt.relativenumber
        numberwidth = 5,
        mouse = "",
      },
      g = {
        gui_font_default_size = 14,
        gui_font_size = 14,
        gui_font_face = "DroidSansMono Nerd Font",
      },
    },

  --   -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ahmedkhalf/project.nvim",
      --   config = function()
      --     require("project_nvim").setup {
      --       -- your configuration comes here
      --       -- or leave it empty to use the default settings
      --       -- refer to the configuration section below
      --     }
      --   end
      -- },
      {
        "folke/trouble.nvim",
        config = function()
          require("trouble").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
        end
      },
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim",
        config = function ()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer",
          }
        end,
      }
    },
    ["mason-lspconfig"] = {
      ensure_installed = { "rust_analyzer"},
    }
  },

  --   -- Extend LSP configuration
    lsp = {
      skip_setup = { "rust_analyzer"},
      -- enable servers that you already have installed without mason
      servers = {
        -- "pyright"
      },
      -- easily add or disable built in mappings added during LSP attaching
      mappings = {
        n = {
          -- ["<leader>lf"] = false -- disable formatting keymap
        },
      },
      -- add to the server on_attach function
      -- on_attach = function(client, bufnr)
      -- end,

      -- override the lsp installer server-registration function
      -- server_registration = function(server, opts)
      --   require("lspconfig")[server].setup(opts)
      -- end,

      -- Add overrides for LSP server settings, the keys are the name of the server
      ["server-settings"] = {
        -- example for addings schemas to yamlls
        -- yamlls = {
        --   settings = {
        --     yaml = {
        --       schemas = {
        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        --       },
        --     },
        --   },
        -- },
      },
    },

  --   -- Mapping data with "desc" stored directly by vim.keymap.set().
  --   --
  --   -- Please use this mappings table to set keyboard mapping since this is the
  --   -- lower level configuration and more robust one. (which-key will
  --   -- automatically pick-up stored data by this setting.)
    mappings = {
      -- first key is the mode
      i = {
        ["<C-+>"] = {
          function() ResizeGuiFont(1)  end,
          desc = "Increase font size"
        },
        ["<C-->"] = {
          function() ResizeGuiFont(-1)  end,
          desc = "Decrease font size"
        },
        ["<C-BS>"] = {
          function() ResetGuiFont()  end,
          desc = "Reset font size"
        },
      },
      n = {
        ["<C-+>"] = {
          function() ResizeGuiFont(1)  end,
          desc = "Increase font size"
        },
        ["<C-->"] = {
          function() ResizeGuiFont(-1)  end,
          desc = "Decrease font size"
        },
        ["<C-BS>"] = {
          function() ResetGuiFont()  end,
          desc = "Reset font size"
        },
        ["<C-\\>"] = {"<cmd>ToggleTerm<cr>", desc="Toggle terminal" },
      },
      t = {
        ["<C-\\>"] = {"<cmd>ToggleTerm<cr>", desc="Toggle terminal" },
      }
      -- n = {
      --   -- second key is the lefthand side of the map
      --   -- mappings seen under group name "Buffer"
      --   ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      --   ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      --   ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      --   ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      --   -- quick save
      --   -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      -- },
      -- t = {
      --   -- setting a mapping to false will disable it
      --   -- ["<esc>"] = false,
      -- },
    },
  --
  --   -- Modify which-key registration (Use this with mappings table in the above.)
    ["which-key"] = {
      -- Add bindings which show up as group name
      register = {
        -- first key is the mode, n == normal mode
        n = {
          -- second key is the prefix, <leader> prefixes
          ["<leader>"] = {
            -- third key is the key to bring up next level and its displayed
            -- group name in which-key top level menu
            T = {"<cmd>TroubleToggle<cr>", "Trouble"},
          },
        },
      }, },
  --
  --   -- This function is run last
  --   -- good place to configuring augroups/autocommands and custom filetypes
    polish = function()
      -- Set key binding
      -- Set autocommands
      RefreshGuiFont()
    end,
}

return config
