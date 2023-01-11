vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
})

-- Use this if you want it to automatically show all diagnostics on the
-- current line in a floating window. Personally, I find this a bit
-- distracting and prefer to manually trigger it (see below). The
-- CursorHold event happens when after `updatetime` milliseconds. The
-- default is 4000 which is much too long
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()')
-- vim.o.updatetime = 300

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap('n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap('n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

vim.api.nvim_command('inoremap <C-space> <C-x><C-o>')

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', [[<Cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]], opts)
  buf_set_keymap('n', '<space>e', '<Cmd>Telescope diagnostics bufnr=0<CR>', opts)
  buf_set_keymap('n', 'gr', [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  buf_set_keymap('n', 'gi', [[<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
  buf_set_keymap('n', '<space>a', [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  elseif client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightingProvider then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end

  if client.name == 'html' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == 'jsonls' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == 'terraformls' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local function setup_servers()
  local lsp_installer = require('nvim-lsp-installer')
  lsp_installer.on_server_ready(function(server)
    local opts = make_config()
    if server.name == 'sumneko_lua' then
      opts.settings = lua_settings
    end
    server:setup(opts)
  end)
end

setup_servers()

require('flutter-tools').setup(make_config()) -- use defaults

-- nvim-compe settings

vim.o.completeopt = 'menuone,noselect'

require('compe').setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { '', '', '', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true,
  },
})
