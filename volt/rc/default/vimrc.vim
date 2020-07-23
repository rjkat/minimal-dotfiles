
filetype plugin indent on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" system integration {{{

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" use system clipboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
" }}}

" editor preferences {{{

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

set shortmess=a

syntax on
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set foldlevelstart=-1

" don't show ugly pipes in vertical split
set fillchars=""
set notermguicolors
set shell=bash
set number

set colorcolumn =80
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set shiftround
set ignorecase
set smartcase
set splitbelow
set splitright

" search highlighting color
highlight Search cterm=NONE ctermbg=blue

highlight StatusLine ctermbg=141 ctermfg=16
highlight StatusLineTerm ctermbg=141 ctermfg=16
highlight StatusLineTermNC ctermbg=darkgrey ctermfg=white

let g:netrw_list_hide= '.*\.swp$,\~$,\.orig$'

" show trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

augroup editing_cmds
    autocmd!
    " highlight extra whitespace on load
    autocmd BufReadPost * highlight ExtraWhitespace ctermbg=red guibg=red

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

augroup END
" }}}

" commands {{{
" replace spaces with tabs
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif
" }}}

" custom key mappings/abbreviations {{{
" make up/down obey wrapping
noremap j gj
noremap k gk
noremap - $

" delete to end of line
noremap D d$

" put search results in centre of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Don't use Ex mode, use Q for formatting
map Q gq

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" open help in new tab
cabbrev help tab help
" }}}

" searching {{{
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ -p\ ~/.ignore\ --ignore='*~'\ --nogroup\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" allow search with spaces
function! Ag(args) abort
  execute "silent! grep!" shellescape(a:args)
  cwindow
  redraw!
endfunction

command -nargs=+ -complete=file Ag call Ag(<q-args>)

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>

" open search results in new tab
set switchbuf+=usetab,newtab
" }}}

" syntax {{{
augroup custom_syntax
    autocmd!

    autocmd BufNewFile,BufRead *.vimrc setlocal foldmethod=marker
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    autocmd BufNewFile,BufRead *.jmd setlocal filetype=markdown
    autocmd BufNewFile,BufRead *.template setlocal filetype=html

    " mbuild syntax highlighting
    autocmd BufNewFile,BufRead *.p2_plugin setlocal filetype=python
    autocmd BufRead,BufNewFile *.pro setlocal filetype=prolog
    autocmd BufRead,BufNewFile *.pl setlocal filetype=prolog
    autocmd BufRead,BufNewFile *.tpp setlocal filetype=cpp
augroup END

" }}}

" mappings {{{
let g:mapleader = ","
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>v :set paste!<cr>
nnoremap <leader>d :DiffOrig<cr>
" }}}
