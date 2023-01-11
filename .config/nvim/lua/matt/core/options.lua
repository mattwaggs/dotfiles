-- general settings
vim.opt.hidden = true
vim.opt.ff = 'unix'
vim.opt.backupcopy = 'yes'

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs & indentation
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = 'tab:>-'

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.iskeyword:append('-') -- consider string-string as whole word

-- appearance

-- show a column at the 80 char mark
vim.opt.colorcolumn = '80'

-- hide the mode
vim.opt.showmode = false

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes' -- show sign column so that text doesn't shift

vim.cmd([[
  let g:gruvbox_material_foreground = "mix"
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_enable_bold = 1
  colorscheme gruvbox-material
]])

-- the below settings may be gruvbox specific

-- set the color column color
vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg = 0, bg = '#32302F' })

-- set the color of the highlight in visual modes
vim.g.gruvbox_invert_selection = 0
vim.api.nvim_set_hl(0, 'Visual', { reverse = true, bg = '#2b3e36' })

-- tweak highlighting of the line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#665c54' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'bg' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'bg', fg = '#d79921' })

-- enable syntax folding

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldlevel = 99
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

    vim.cmd([[
    autocmd BufReadPost,FileReadPost, * normal zR
    ]])
  end,
})
