local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'css',
    'dart',
    'dockerfile',
    'go',
    'graphql',
    'html',
    'hcl',
    'jsdoc',
    'json',
    'jsonc',
    'kotlin',
    'lua',
    'make',
    'markdown',
    'php',
    'prisma',
    'proto',
    'python',
    'rust',
    'scss',
    'swift',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  -- auto_install = true,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  matchup = { -- depends on the matchup plugin
    enable = true, -- mandatory, false will disable the whole extension
  },
})

-- additional highlighting for c#

-- Treesitter Helper
-- press leader t on a thing and see what treesitter capture groups apply to
-- that thing. Helpful for debugging syntax hightlights

vim.api.nvim_command([[
nnoremap <leader>t :TSHighlightCapturesUnderCursor<CR>
]])

-- Custom (better) CSharp syntax highlighting
-- -> This depends on some custom tree sitter queries and the gruvbox plugin
--    from npxbr/gruvbox.nvim
vim.api.nvim_command([[
highlight! link c_sharpTSType GruvboxBlue
highlight! link c_sharpTSInclude GruvboxPurple
highlight! link c_sharpTSKeyword GruvboxOrange
highlight! link c_sharpTSKeywordReturn GruvboxRed
highlight! link c_sharpTSKeywordOperator GruvboxPurple
highlight! link c_sharpTSVariable GruvboxFg2
highlight! link c_sharpTSMethod GruvboxGreen
highlight! link c_sharpTSPunctBracket GruvboxFg3
highlight! link c_sharpTSPunctDelimiter GruvboxFg2
highlight! link c_sharpTSConstructor GruvboxYellow
highlight! link c_sharpTSOperator GruvboxOrange
highlight! link c_sharpTSTypeBuiltin GruvboxYellow
highlight! link c_sharpTSConstBuiltin GruvboxPurple
highlight! link c_sharpTSField GruvboxFg2
highlight! link member_access_expression_name GruvboxAqua
highlight! link using_directive GruvboxPurple
]])

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
