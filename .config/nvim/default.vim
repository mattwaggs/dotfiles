" Install Plugins ------------------------- {{{
call plug#begin('~/.vim/plugged')

" hack to improve perf
let g:loaded_matchparen = 1

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }         
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/jsonc.vim'
Plug 'leafgarland/typescript-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer', {'branch': 'main'}
Plug 'hrsh7th/nvim-compe'

" null-ls is used to provide formatting
Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Color schemes
"Plug 'morhetz/gruvbox'
Plug 'rktjmp/lush.nvim', {'branch': 'main'}
Plug 'npxbr/gruvbox.nvim', {'branch': 'main'}
"Plug 'sainnhe/gruvbox-material'

"Status Line Stuff
Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons'

Plug 'yamatsum/nvim-nonicons', {'branch': 'main'}
Plug 'lewis6991/gitsigns.nvim', {'branch': 'main'}

" add flutter lsp stuff 
Plug 'akinsho/flutter-tools.nvim', { 'branch': 'main' }

" makes it easier to use jk to escape
Plug 'max397574/better-escape.nvim'

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
set tabstop=8 softtabstop=4 expandtab shiftwidth=2 smarttab
set list
set listchars=tab:>-
set ff=unix

set noshowmode
" }}}

" Color Scheme Settings ------------------- {{{
set termguicolors

let g:gruvbox_invert_selection=0
colorscheme gruvbox

"let g:gruvbox_material_palette = 'original'
"let g:gruvbox_material_better_performance = 1
"colorscheme gruvbox-material

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
let NERDTreeIgnore=['node_modules', 'obj', 'bin', '.DS_Store']
" }}}

" Status Line ----------------------------- {{{
" set statusline=[%n]\ %f   " Buffer number + path to the file
" set statusline+=%=        " Switch to the right side
" set statusline+=%c\:      " Current column
" set statusline+=[%l       " Current line
" set statusline+=/         " Separator
" set statusline+=%L]       " Total lines
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

"hi tsxTag guifg=#83a598
"hi tsxTagName guifg=#689d6a
"hi tsxCloseTag guifg=#83a598
"hi tsxCloseString guifg=#689d6a
"hi tsxCloseTagName guifg=#689d6a
"hi tsxAttributeBraces guifg=#d5c4a1
"hi tsxEqual guifg=#bdae93
"hi tsxAttrib guifg=#fabd2f cterm=italic
" }}}

" Markdown ----------------------- {{{
augroup markdown
  au!
  "au BufRead,BufNewFile *.md setlocal textwidth=80
  "au bufwritepost *.md norm gggqG
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

autocmd BufRead,BufNewFile *.bicep set filetype=bicep


autocmd BufRead,BufNewFile *.prisma set filetype=prisma

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "comment",
    "css",
    "dart",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "jsdoc",
    "json",
    "jsonc",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "php",
    "prisma",
    "proto",
    "python",
    "rust",
    "scss",
    "swift",
    "toml",
    "vim",
    "yaml"
  },
  ignore_install = { "javascript", "typescript", "tsx" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["generic_name.identifier"] = "matt_cc",
    },
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false
  },
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
  }
}
EOF

" Treesitter Helper
" press leader t on a thing and see what treesitter capture groups apply to
" that thing. Helpful for debugging syntax hightlights
nnoremap <leader>t :TSHighlightCapturesUnderCursor<CR>

" Custom (better) CSharp syntax highlighting
" -> This depends on some custom tree sitter queries and the gruvbox plugin
"    from npxbr/gruvbox.nvim
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

" Load other configs
lua require('config.lsp')
lua require('config.telescope')
lua require('config.statusline')
lua require('config.null-ls')

" lsp flutter tools - not as good as flutter-coc
"lua << EOF
"  require("flutter-tools").setup{} -- use defaults
"EOF

nnoremap <leader>ev :lua require('config.telescope').search_dotfiles()<CR>

lua <<EOF
require("better_escape").setup {
  mapping = {"jk", "jj", "kj"}
}
EOF

