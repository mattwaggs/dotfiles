-- some convenience mapping functions
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

-- clear search highlights
nmap('<leader>/', ':nohl<CR>')

-- toggle file explorer
-- nmap('<c-\\>', ':Neotree toggle position=float<CR>')
nmap('<c-\\>', ':NvimTreeToggle<CR>')
nmap('<space>e', ':NvimTreeFindFileToggle<CR>')

-- delete single character without copying into register
nmap('x', '"_x')

-- navigation
nmap('<c-h>', '^')
nmap('<c-l>', '$')
nmap('<c-j>', '<c-d>')
nmap('<c-k>', '<c-u>')

-- ctrl-u to uppercase a word in insert mode
imap('<c-u>', '<esc>viwUea')

-- surround with quotes
nmap('<leader>"', 'viw<esc>a"<esc>bi"<esc>lel')
nmap("<leader>'", "viw<esc>a'<esc>bi'<esc>lel")

-- clean up whitespace
nmap('<leader>ww', ':%s/\\s\\+$//e<cr>')

-- search neovim config files
nmap('<leader>ev', ":lua require('config.telescope').search_dotfiles()<CR>")
