" vim:et:sw=2:ts=2

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, guifg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermfg='. a:fg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension . '.*$#'
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
  let g:NERDTreeGlyphReadOnly = ''
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeDirArrows = 1
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeWinSize = 30
endfunction

function! s:find_project_root()
  if !exists("loaded_nerd_tree")
      return getcwd()
  endif
  let nerd_root = g:NERDTree.ForCurrentTab().getRoot().path.str()
  let git_root = system('git -C '.shellescape(nerd_root).' rev-parse --show-toplevel 2> /dev/null')[:-2]
  if strlen(git_root)
    return git_root
  endif
  return nerd_root
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
  silent! call NERDTreeHighlightFile('jl', 'green', '#a6e22e')
  silent! call NERDTreeHighlightFile('ini', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('md', 'blue', '#66d9ef')
  silent! call NERDTreeHighlightFile('yml', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('toml', 'blue', '#66d9ef')
  silent! call NERDTreeHighlightFile('config', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('conf', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('json', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('html', 'yellow', '#e6db74')
  silent! call NERDTreeHighlightFile('css', 'cyan', '#66d9ef')
  silent! call NERDTreeHighlightFile('cpp', 'Red', '#f92672')
  silent! call NERDTreeHighlightFile('js', 'Red', '#f92672')
  silent! call NERDTreeHighlightFile('php', 'Magenta', '#ae81ff')
  map <C-o> :NERDTreeToggle<CR>
  augroup nerdtree
      autocmd!
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  augroup END
  command! ProjectFiles execute 'Files' s:find_project_root()
endfunction

" This function determines when a plugin is loaded.
"
" Possible values are:
" * 'start' (a plugin will be loaded at VimEnter event)
" * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
" * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
" <filetypes> and <excmds> can be multiple values separated by comma.
"
" This function must contain 'return "<str>"' code.
" (the argument of :return must be string literal)
function! s:loaded_on()
  return 'start'
endfunction

" Dependencies of this plugin.
" The specified dependencies are loaded after this plugin is loaded.
"
" This function must contain 'return [<repos>, ...]' code.
" (the argument of :return must be list literal, and the elements are string)
" e.g. return ['github.com/tyru/open-browser.vim']
function! s:depends()
  return ['github.com/ctrlpvim/ctrlp.vim', 'github.com/ryanoasis/vim-devicons.vim']
endfunction
