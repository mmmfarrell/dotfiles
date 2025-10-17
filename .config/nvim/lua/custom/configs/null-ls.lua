local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.cmake_format,
  },

  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft ~= "cmake" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    vim.api.nvim_create_autocmd("InsertLeave", {
      buffer = bufnr,
      callback = function()
        -- This suppresses the error from none-ls' flush
        pcall(function()
          require("null-ls.rpc").flush()
        end)
      end,
    })
  end,
}

return opts
