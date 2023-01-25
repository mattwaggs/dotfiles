local cspell_custom_file_path = vim.fn.findfile('~/.config/langs/cspell.json')

local cspell_config_file_path = function()
  local custom_path = nil
  if cspell_custom_file_path ~= '' then
    custom_path = cspell_custom_file_path
  end
  return custom_path
end

local cspell_config_args = function()
  if cspell_config_file_path ~= nil then
    return cspell_custom_file_path
  else
    return nil
  end
end

local cspell = {
  config = {
    create_config_file = false,
    find_json = cspell_config_file_path,
  },
  disable_filetypes = {
    'NvimTree',
  },
  extra_args = {
    '--config',
    cspell_config_args(),
    '--cache',
    '--gitignore',
    '--no-gitignore',
    '--locale',
    'en-US',
  },
}

local prettierd = {
  prefer_local = 'node_modules/.bin',
}

local eslintd = {
  condition = function(utils)
    return utils.root_has_file('.eslintrc.json')
  end,
}

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local codeactions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

local source = {
  formatting.markdownlint,
  formatting.stylua,
  formatting.prettierd.with(prettierd),
  --diagnostics.cspell.with(cspell),
  --codeactions.cspell.with(cspell),
  diagnostics.eslint.with(eslintd),
  codeactions.eslint.with(eslintd),
}

local on_attach = function(current_client, bufnr)
  if current_client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == 'null-ls'
          end,
          bufnr = bufnr,
        })
      end,
    })
  end
end

null_ls.setup({
  sources = source,
  on_attach = on_attach,
  debug = false,
  fallback_severity = vim.diagnostic.severity.WARN,
  float = false,
  virtual_text = true,
  signs = true,
  severity_sort = true,
  update_in_insert = true,
  debounce = 350,
})

-- local require('null-ls').setup({
--   sources = {
--     -- null ls will only be used with buffers compatible with these soucres
--     require('null-ls').builtins.formatting.stylua,
--     require('null-ls').builtins.formatting.prettierd.with({
--       prefer_local = 'node_modules/.bin',
--     }),
--     require('null-ls').builtins.code_actions.eslint_d,
--     require('null-ls').builtins.formatting.terraform_fmt,
--     require('null-ls').builtins.diagnostics.cspell.with({}),
--     require('null-ls').builtins.code_actions.cspell,
--   },
--
--   -- you can reuse a shared lspconfig on_attach callback here
--   on_attach = function(client)
--     print(vim.inspect(client))
--     if client.server_capabilities.documentFormattingProvider then
--       vim.cmd([[
--             augroup LspFormatting
--             autocmd! * <buffer>
--             autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
--             augroup END
--             ]])
--     end
--   end,
-- })
