return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_format" },
        zig = { lsp_format = "fallback" }
      },
      format_on_save = {
        async = false,
        timeout_ms = 1000,
        lsp_fallback = true,
        lsp_format = "fallback",
      },
    })

    Vmap({ "n", "v" }, "<leader>fmt", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file" })
  end,
}
