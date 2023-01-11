
-- Rust Settings 
vim.g.rustfmt_autosave = 1
vim.g.rust_recommended_style = 0

-- JSX / TSX settings
vim.api.nvim_command([[
augroup typescript
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END
]])

-- Markdown
-- commented out as prettier might be handling this...
--vim.api.nvim_command([[
--augroup markdown
--  au!
--  
--  au BufRead,BufNewFile *.md setlocal textwidth=80
--  au bufwritepost *.md norm gggqG
--augroup END
--]])

-- detect bicep file types
vim.api.nvim_command([[
autocmd BufRead,BufNewFile *.bicep set filetype=bicep
]])

-- detect prisma file types
vim.api.nvim_command([[
autocmd BufRead,BufNewFile *.prisma set filetype=prisma
]])
