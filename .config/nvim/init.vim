" ---- install plugins ---- 
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }         
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/jsonc.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set hidden
set nowrap

" ---- color schemes ----
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
set background=dark

" ---- relative line numbers ----
set number relativenumber
set nu rnu

" tweak highlighting of the line numbers
" more fadded
highlight LineNr guifg=#3c3836 
" less faded
"highlight LineNr guifg=#665c54 

highlight SignColumn guibg=bg
highlight CursorLineNr guibg=bg guifg=#d79921

" ---- tabs ----
"  we should figure out how to override this with editor config
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab


" ---- nerdtree ----
noremap <C-\> :NERDTreeToggle<CR>


" ---- splits ----
set splitbelow
set splitright

" This should let us see the file name on splits
" [buffer number] followed by filename:
set statusline=[%n]\ %t
" show line#:column# on the right hand side
set statusline+=%=%l:%c


" ---- search ----
" remove search highlighting 
nnoremap <leader>/ :noh<return>


" ---- coc.settings ----
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


" ---- prettier ----
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ---- treat tsconfig.json as jsonc to allow comments ----
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc


" ---- jsx / tsx highlighting ----
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

hi tsxTag guifg=#83a598
hi tsxTagName guifg=#689d6a
hi tsxCloseTag guifg=#83a598
hi tsxCloseString guifg=#689d6a
hi tsxCloseTagName guifg=#689d6a
hi tsxAttributeBraces guifg=#d5c4a1
hi tsxEqual guifg=#bdae93
hi tsxAttrib guifg=#fabd2f cterm=italic


" ---- rust format on save ----
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 0


" ---- FZF ----

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

nnoremap <silent> <C-o> :Files<CR>
nnoremap <silent> <C-p> :GitFiles<CR>


" ---- auto reload after saving ----
augroup myvimrchooks
    au!
    autocmd bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END


