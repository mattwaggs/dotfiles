require('null-ls').setup({
  sources = {
    -- null ls will only be used with buffers compatible with these soucres
    require('null-ls').builtins.formatting.stylua,
    require('null-ls').builtins.formatting.prettier.with({
      prefer_local = 'node_modules/.bin',
    }),
    require('null-ls').builtins.formatting.terraform_fmt,
  },

  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end,
})
