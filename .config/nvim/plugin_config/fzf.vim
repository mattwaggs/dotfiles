" FZF ------------------------------------- {{{
" this should give us fzf previews
command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --theme=gruvbox --color=always {}']}, <bang>0)

command! -bang -nargs=? -complete=dir GitFiles
    \  call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" set the layout of the fzf window
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1 } }

" Hide status line temporarily
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

command! -bang -nargs=? -complete=dir GitFiles

nnoremap <silent> <c-f> :Rg<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GitFiles<CR>
" }}}
