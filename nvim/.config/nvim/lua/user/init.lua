local config = {
  --   -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      numberwidth = 4,
      mouse = "",
      swapfile = false,
    },
  },


  mappings = {
    i = {
    },
    n = {
      L = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
      H = { function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },
      ["<C-\\>"] = {"<cmd>ToggleTerm<cr>", desc="Toggle terminal" },
      ["<leader>lt"] = {"<cmd>TroubleToggle<cr>", desc="Toggle trouble"},
      ["<leader>fp"] = {"<cmd>Telescope projects<cr>", desc="Find projects"},
    },
    t = {
      ["<C-\\>"] = {"<cmd>ToggleTerm<cr>", desc="Toggle terminal" },
      ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
      ["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    }
  }
}

return config
