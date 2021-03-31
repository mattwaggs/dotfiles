" remove search highlighting
nnoremap <leader>/ :noh<return>

" navigation
nnoremap <c-h> I<esc>
nnoremap <c-l> $
nnoremap <c-j> <c-d>
nnoremap <c-k> <c-u>

" ctrl-u to uppercase a word 
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

" surround with quotes 
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" quick jump to vimrc 
nnoremap <leader>ev :tabe ~/.config/nvim/<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" clean up whitespace
nnoremap <leader>ww :%s/\s\+$//e<cr> 
