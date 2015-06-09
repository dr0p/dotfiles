set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ervandew/screen'
Plugin 'flazz/vim-colorschemes'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'moll/vim-bbye'
Plugin 'AndrewRadev/splitjoin.vim'

call vundle#end()

syntax on
filetype plugin indent on

" paste mode
set pastetoggle=<F12>

set t_Co=256
set term=screen-256color
set background=dark
let g:rehash256 = 1

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,coffee,less,python,php,html,css,axlsx,scss,sass set ai sw=2 sts=2 et
  autocmd FileType js set ai sw=4 sts=4 et
  autocmd FileType ruby,eruby,yaml,coffee,less,python,php,html,js,css,axlsx setlocal colorcolumn=80
augroup END

au BufNewFile,BufRead *.axlsx set filetype=ruby


set tw=80
set nocompatible
set nofoldenable
set hidden
set shiftround

set backspace=indent,eol,start

set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files

set laststatus=2
set stl=%{fugitive#statusline()}\ %f\ %m\ %r\ %=\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n
hi StatusLine ctermfg=black ctermbg=yellow
hi StatusLineNC ctermfg=black ctermbg=green

let mapleader = ","

"let g:ctrlp_custom_ignore = '\.git$\|\.bundle$\|coverage$\|tmp$'
"let g:ctrlp_custom_ignore = '^\.git$\|^\.bundle$\|^coverage$\|^log$\|^tmp$'
 let g:ctrlp_custom_ignore = {
   \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.bundle|log|tmp|coverage)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ackprg="ack -H --nocolor --nogroup --column --ignore-dir .bundle --ignore-dir coverage --ignore-dir log --ignore-dir tmp"
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_js_checkers = ['jslint', 'jshint']

map <Leader>t :NERDTreeToggle<CR>
map <Leader>T :NERDTreeFind<CR>
map <Leader>b :b#<CR>
map <Leader>db :e config/database.yml<CR>
map <Leader>a :Ack
map <Leader>d o<cr>debugger<cr><esc>:w<cr>
map <Leader>D O<cr>debugger<cr><esc>:w<cr>

nnoremap <leader><leader> <c-^>
nnoremap ; :
inoremap jj <esc>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>

nmap <leader>f$ :call StripTrailingWhitespace()<CR>

" Remove trailing whitespace on save for ruby files.
au BufWritePre * :%s/\s\+$//e

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
	for key in ['<up>', '<down>', '<left>', '<right>']
	  exe prefix . "noremap " . key . " <nop>"
	endfor
endfor


"functions
function! Preserve(command)
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
  call Preserve("%s/\\s\\+$//e")
endfunction

" Undo
set undolevels=10000
if has("persistent_undo")
	set undodir=~/.vim/undo " Allow undoes to persist even after a file is
	"   closed
	set undofile
endif

" Screen settings
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellInitialFocus = 'shell'
let g:ScreenShellQuitOnVimExit = 0
map <F5> :ScreenShellVertical<CR>
command -nargs=? -complete=shellcmd W  :w | :call ScreenShellSend("load '".@%."';")
map <Leader>r :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
map <Leader>e :w<CR> :call ScreenShellSend("cucumber --format=pretty ".@% . ':' . line('.'))<CR>
map <Leader>b :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>


" have vim recognise .md files as .markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Bbye
:nnoremap <Leader>q :Bdelete<CR>

"delete 4ever
vmap <Leader>d "_dd
