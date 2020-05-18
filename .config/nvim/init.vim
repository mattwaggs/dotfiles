
" Install Plugins ------------------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }         
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/jsonc.vim'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Color schemes
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as':'dracula' }
Plug 'morhetz/gruvbox'

call plug#end()
" }}}

" Basic Global Settings ------------------- {{{
set hidden
set nowrap
set colorcolumn=80
set number relativenumber
set nu rnu
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set splitbelow
set splitright
" }}}

" Color Scheme Settings ------------------- {{{
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'

" the below settings are gruvbox specific
highlight ColorColumn guibg=#32302F 

" tweak highlighting of the line numbers
" more fadded
" highlight LineNr guifg=#3c3836 
" less faded
highlight LineNr guifg=#665c54 

highlight SignColumn guibg=bg
highlight CursorLineNr guibg=bg guifg=#d79921
" }}}

" NERDTree Settings ----------------------- {{{
noremap <C-\> :NERDTreeToggle<CR>
" }}}

" Status Line ----------------------------- {{{
set statusline=[%n]\ %f   " Buffer number + path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%c\:      " Current column
set statusline+=[%l       " Current line
set statusline+=/         " Separator
set statusline+=%L]       " Total lines
" }}}

" COC Settings ---------------------------- {{{
source ~/.config/nvim/cocdefault.vim

let g:coc_global_extensions = [
	\'coc-json',
	\'coc-marketplace',
	\'coc-snippets',
	\'coc-pairs',
	\'coc-tsserver',
	\'coc-eslint',
	\'coc-prettier',
	\'coc-sh',
	\'coc-docker',
	\'coc-yaml',
	\]

" }}}

" Prettier Auto Format -------------------- {{{
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}

" Rust Settings --------------------------- {{{
" format on save
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 0
" }}}

" JSX / TSX settings ---------------------- {{{
augroup typescript
  au!
  " ---- treat tsconfig.json as jsonc to allow comments ----
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END

hi tsxTag guifg=#83a598
hi tsxTagName guifg=#689d6a
hi tsxCloseTag guifg=#83a598
hi tsxCloseString guifg=#689d6a
hi tsxCloseTagName guifg=#689d6a
hi tsxAttributeBraces guifg=#d5c4a1
hi tsxEqual guifg=#bdae93
hi tsxAttrib guifg=#fabd2f cterm=italic
" }}}

" FZF ------------------------------------- {{{
" this should give us fzf previews
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" set the layout of the fzf window
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1 } }

" Hide status line temporarily
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

command! -bang -nargs=? -complete=dir GitFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" }}}

" Custom Bindings ------------------------- {{{

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
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GitFiles<CR>
" }}}

" Markdown specific ----------------------- {{{
augroup markdown
  au!
  au BufRead,BufNewFile *.md setlocal textwidth=80
  "au bufwritepost *.md norm gggqG
augroup END
" }}}

" Syntax Folding (not vimscript) ---------- {{{
set foldmethod=syntax
augroup folding
  au!
  " open all folds on open
  au BufRead,BufWinEnter * normal zR
augroup END
" }}}

" Vimscript file settings ----------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
      \ | setlocal foldmethod=marker
augroup END
" }}}

