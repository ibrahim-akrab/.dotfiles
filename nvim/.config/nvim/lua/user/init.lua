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
      numberwidth = 6,
      mouse = "",
      swapfile = false,
    },
    g = {
      gui_font_default_size = 15,
      gui_font_size = 15,
      gui_font_face = "FiraCode Nerd Font",
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
      {"ellisonleao/glow.nvim", config = function() require("glow").setup() end},
      { "nvim-telescope/telescope-project.nvim"},
      {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
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
        config = function()
          require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
          }
          require('telescope').load_extension('projects')
        end,
      },
      { "folke/tokyonight.nvim"},
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
      },
      {
        'nyngwang/murmur.lua',
        config = function ()
          require('murmur').setup {
            -- cursor_rgb = {
            --  guibg = '#393939',
            -- },
            -- cursor_rgb_always_use_config = false, -- if set to `true`, then always use `cursor_rgb`.
            -- yank_blink = {
            --   enabled = true,
            --   on_yank = nil, -- Can be customized. See `:h on_yank`.
            -- },
            max_len = 80,
            min_len = 3, -- this is recommended since I prefer no cursorword highlighting on `if`.
            exclude_filetypes = {},
            callbacks = {
              -- to trigger the close_events of vim.diagnostic.open_float.
              function ()
                -- Close floating diag. and make it triggerable again.
                vim.cmd('doautocmd InsertEnter')
                vim.w.diag_shown = false
              end,
            }
          }

          -- To create IDE-like no blinking diagnostic message with `cursor` scope. (should be paired with the callback above)
          vim.api.nvim_create_autocmd({ 'CursorHold' }, {
            group = FOO,
            pattern = '*',
            callback = function ()
              -- skip when a float-win already exists.
              if vim.w.diag_shown then return end

              -- open float-win when hovering on a cursor-word.
              if vim.w.cursor_word ~= '' then
                vim.diagnostic.open_float()
                vim.w.diag_shown = true
              end
            end
          })

          -- To create special cursorword coloring for the colortheme `typewriter-night`.
          -- remember to change it to the name of yours.
          vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
            group = FOO,
            pattern = 'typewriter-night',
            callback = function ()
              vim.api.nvim_set_hl(0, "murmur_cursor_rgb", { fg = "#0a100d", bg = "#ffee32" })
            end
          })
        end,
      },
      -- {
      --   "yamatsum/nvim-cursorline",
      --   config = function ()
      --     require('nvim-cursorline').setup {
      --       cursorline = {
      --         enable = true,
      --         timeout = 1000,
      --         number = false,
      --       },
      --       cursorword = {
      --         enable = true,
      --         min_length = 3,
      --         hl = { underline = true },
      --       }
      --     }
      --   end,
      -- },
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
      ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
      ["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
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
          ["f"] = {
            p = {"<cmd>Telescope projects<cr>", "Search Projects"},
          }
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
