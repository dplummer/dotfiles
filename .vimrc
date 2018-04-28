set rubydll=/usr/local/Cellar/ruby/2.5.1/lib/libruby.dylib
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/donaldp/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/donaldp/.vim/bundles')
  call dein#begin('/Users/donaldp/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/donaldp/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('chriskempson/base16-vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('ervandew/supertab')
  call dein#add('godlygeek/tabular')
  call dein#add('lucidstack/hex.vim')
  call dein#add('mileszs/ack.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('slashmili/alchemist.vim')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-rails')
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('fatih/vim-go')

  " Command-T
  " If macvim complains about C extension, run :call dein#recache_runtimepath()
  " https://github.com/wincent/command-t/issues/196
  call dein#add('wincent/command-t')

  call dein#add('Raimondi/delimitMate')
  call dein#add('ElmCast/elm-vim')
  call dein#add('keith/rspec.vim')
  call dein#add('geoffharcourt/vim-matchit')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set background=dark
colorscheme base16-eighties

syntax on
filetype plugin indent on
set history=50
set wildmode=list:longest,full
set wildmenu                " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.swp,*.swo " stuff to ignore when tab completing
set shortmess+=r
set showmode
set mouse=a
set nowrap
set shiftround
set expandtab
set smarttab
set ts=2
set bs=2                    " backspace over everything
set sw=2
set autoindent
set formatoptions-=t
set nobackup
set nowritebackup
set background=dark

"vertical/horizontal scroll off settings for readability
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

set clipboard+=unnamed      " Yanks go on clipboard instead.
set ruler                   " Ruler on
set timeoutlen=250          " Time to wait after ESC (default causes an annoying delay)
set incsearch               " Incremental search results
set hlsearch                " highlight search results
" t - auto wrap text using textwidth
" c - auto wrap comments using textwidth
" q - allow formatting of comments with gq
" q - automatically insert the current comment leader after hitting <Enter> in
"     insert mode
set formatoptions=tcqr
set showmatch               " Show matching brackets.
set mat=5                   " Bracket blinking.
set novisualbell            " No blinking .
set noerrorbells            " No noise.


" set comma as leader
let mapleader = ","

" disable this autocomment bullshit
au FileType * setl fo-=cro

" line numbers
set nu
set rnu

" move between splits easily
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" make Y consistent with C and D (yank to EOL)
nnoremap Y y$


" rebind my favorite commands from Git.vim for Fugitive
nmap <leader>ga :Gwrite<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gl :Glog 
nmap <leader>gd :Gdiff<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gr :Gremove
nmap <leader>gw :Gbrowse<cr>
nmap <leader>du :diffupdate<cr>
nmap <leader>gg :Ggrep 
nmap <leader>co :copen<cr>
nmap <leader>to :tabo \| only<cr>
nmap <leader>wv :vsplit<cr>
nmap <leader>ws :split<cr>

" ack binding
let g:ackprg = 'ag --nogroup --nocolor --column'
map <leader>a :Ack <C-r><C-w> 

" Put a color line to help identify too-long lines
set colorcolumn=101
set textwidth=98

nmap <leader>R :RainbowParenthesesToggle<cr>

set wildignore+=*.o,*.obj,.git,*.png,*.ico,*.jp*g,*.gif,*.psd,*.beam

" list and invisible characters
set list
" set listchars=tab:»\ ,eol:¬
set tabstop=4
set listchars=tab:\│\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:¬
set termguicolors
highlight SpecialKey ctermfg=grey ctermbg=black
highlight SpecialKey guifg=#333333 guibg=#222222

" set max width on git commit messages to 72 chars
autocmd Filetype gitcommit setlocal spell textwidth=72

" make cmdline tab completion similar to bash
set wildmode=list:longest

" map no highlight
map <Leader>h :noh<CR>

" NERD Project Tree
map <leader>n :NERDTreeToggle<cr>
let g:NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '^_build$', '^deps$']
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" disable left scrollbar
set guioptions-=L
set guioptions-=r

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0 
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . fnameescape(a:file)

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Use silversurfer for ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" autoformat elm code
let g:elm_format_autosave = 1

" previous file
nmap <leader><leader> <C-^>
