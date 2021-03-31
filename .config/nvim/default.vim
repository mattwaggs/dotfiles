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
Plug 'OmniSharp/omnisharp-vim'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
set splitbelow
set splitright
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
" }}}

" Color Scheme Settings ------------------- {{{
set termguicolors

let g:gruvbox_invert_selection=0

colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
hi Visual term=reverse cterm=reverse guibg=#2b3e36

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
let NERDTreeIgnore=['node_modules', 'obj', 'bin']
" }}}

" Status Line ----------------------------- {{{
set statusline=[%n]\ %f   " Buffer number + path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%c\:      " Current column
set statusline+=[%l       " Current line
set statusline+=/         " Separator
set statusline+=%L]       " Total lines
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

" These colors may be specific to gruvbox
hi tsxTag guifg=#83a598
hi tsxTagName guifg=#689d6a
hi tsxCloseTag guifg=#83a598
hi tsxCloseString guifg=#689d6a
hi tsxCloseTagName guifg=#689d6a
hi tsxAttributeBraces guifg=#d5c4a1
hi tsxEqual guifg=#bdae93
hi tsxAttrib guifg=#fabd2f cterm=italic
" }}}

" Markdown ----------------------- {{{
augroup markdown
  au!
  au BufRead,BufNewFile *.md setlocal textwidth=80
  au bufwritepost *.md norm gggqG
augroup END
" }}}

" Syntax Folding (not vimscript) ---------- {{{
set foldmethod=syntax
set foldlevelstart=99
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
	au bufwritepost ~/.config/nvim/* source ~/.config/nvim/init.vim
	  \ | setlocal foldmethod=marker
augroup END
" }}}

set backupcopy=yes


