local plugins = {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer", -- rust lsp
        "clangd",
        "clang-format",
        "typescript-language-server",
        "prettier",
        "pyright", -- python lsp (autocomplete, etc)
        "mypy", -- python static checking
        "ruff", -- python static checking
        "black", -- python formatting
      }
    }
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  -- To get version numbers etc in rust Cargo.toml
  -- {
  --   "saecki/crates.nvim",
  --   ft = {"rust", "toml"},
  --   config = function(_, opts)
  --     local crates = require('crates')
  --     crates.setup(opts)
  --     crates.show()
  --   end,
  -- },
  -- -- To get version numbers etc in rust Cargo.toml (cont)
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function()
  --     local M = require "plugins.configs.cmp"
  --     table.insert(M.sources, {name = "crates"})
  --     return M
  --   end,
  -- }
  -- wakatime for tracking development time / stats
  -- {
  --   "wakatime/vim-wakatime",
  --   lazy = false
  -- }
}
return plugins
