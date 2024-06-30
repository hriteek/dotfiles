" this will install the plugin is not installed, when you open the vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ------------------
" Plug Starting
" ------------------
call plug#begin("~/.vim/plugged")
" theme
Plug 'gruvbox-community/gruvbox'
" Plug 'dracula/vim'

" for highlighting the yanked test
Plug 'machakann/vim-highlightedyank'

" " Vim plugin for sort
" Plug 'christoomey/vim-sort-motion'

" " Vim plugin for git
" Plug 'tpope/vim-fugitive'

" " Coc Autocomplete
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Quick Scope => to search horizontally
Plug 'unblevable/quick-scope'

" Airline
Plug 'itchyny/lightline.vim'

" Better Comments
Plug 'tpope/vim-commentary'

" " For navigation with tmux
" Plug 'christoomey/vim-tmux-navigator'

" For some surrounging command
Plug 'tpope/vim-surround'

" " For undotree
" Plug 'mbbill/undotree'

" " Emmet
" Plug 'mattn/emmet-vim' 

" smart number toggle
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" " Prettier
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" " syntax highlighting for JSX
" Plug 'maxmellon/vim-jsx-pretty' 

" " syntax highlighting for javascript 
" Plug 'pangloss/vim-javascript'

" " FZF : fuzzy finder
" Plug 'junegunn/fzf', {  'do':{ -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" " ale : Linters, FOrmatters & Fixer
" Plug 'dense-analysis/ale'

" File Manage
" Plug 'scrooloose/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'tsony-tsonev/nerdtree-git-plugin'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'

call plug#end()
" ------------------
" Plug Ending
" ------------------

" ------------------
" Theme Setting
" ------------------
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox
" colorscheme dracula

" ------------------
" Key Mapping
" ------------------

" ------------------
" => Spell checking
" ------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zs
map <leader>s? z=


" Remap VIM 0 to first non-blank character
" map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


" I hate escape more than anything else
inoremap jk <Esc>
" inoremap kj <Esc>

" to app a extra empty line below
" nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" If you want to stay in the line where you have been before 
" nmap <S-Enter> O<Esc>k
" nmap <CR> o<Esc>k

" ------------------
" =>  Better window navigation
" ------------------
" nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-l> <C-w>l

" Disable highlight when <leader><cr> is pressed
" map <silent> <leader><cr> :noh<cr>
nnoremap <leader>n :noh<CR>


" terminal mode mapping
tnoremap <Esc> <C-\><C-n>
" nnoremap <leader>m :split term://bash<CR>
nnoremap <leader>m :bot term<CR>

" ------------------
" SETTINGS
" ------------------
" set leader key
"
  "
" let g:mapleader = "\<Space>"
let g:mapleader = "\\"

syntax enable                           " Enables syntax highlighing
set incsearch                           " Increment serach
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set softtabstop=2                       " Insert 2 spaces of spaces in tab when editing
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard+=unnamed                  " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set relativenumber                      " Show relative numbering
set showcmd                             " Show command in bottom bar 
set showmatch                           " Show matching braces when text indicate is over them
set noerrorbells                        " Disable audible bell
set incsearch                           " incremental search (as string is bing typed)
set hls                                 " highlight search
set hlsearch                            " highlight search
set wildmenu                            " visual autocomplete for command menu
set ignorecase                          " smart case-sensitive search
set smartcase                           " smart case-sensitive search
set splitbelow                          " open new vertical split bottom
set splitright                          " open new horizontal split right
set laststatus=2                        " to color the lightline
set backspace=indent,eol,start
let g:netrw_banner=0                    " disable netrw
set noswapfile                          " for no .swap files
" let loaded_netrwPlugin = 1
set undodir=~/.vim/undodir
set undofile
" set colorcolumn=80                      " this is for the line in side to show the limit 
highlight ColorColumn ctermbg=0 guibg=lightgray

"----------------------------- FZF  ----------------------------------------
let g:fzf_layout = {'window' :{ 'width': 0.8, 'height':0.8}}
" nnoremap <C-p> :FZF<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <C-f> :Rg<CR> 
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" CTRL+T to open it in new tab
" CTRL+S to open below (split view)
" CTRL+T to open to the side (vertical split)
" Enter to open it in the currently selected panel

" to ignore node_modues
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"----------------------------- vim-emmet  ----------------------------------------
let g:user_emmet_leader_key='<tab>'
" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.

"----------------------------- vim-tmux-navigator  ----------------------------------------
" nnoremap <silent> <C-J> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-K> :TmuxNavigateDown<cr>
" nnoremap <silent> <C-L> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-H> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-U> :TmuxNavigatePrevious<cr>

"----------------------------- Easymotion  ----------------------------------------
" " Turn on case-insensitive feature
" let g:EasyMotion_smartcase = 1
" " nmap <space>   <Plug>(easymotion-overwin-f)
" " map  <space> <Plug>(easymotion-bd-w)

"----------------------------- Vim fugitive  ----------------------------------------
nmap <leader>gj :diffget //3<CR>
" select the right side of the git conflict files
nmap <leader>gf :diffget //2<CR>
" select the left side of the git conflict files
nmap <leader>gs :G <CR>                
" git status, s for stage and u for unstage
" :Gcommit for commit / cc
" :Gpush
" :Git merge <branch_name>
" press dv on the file that you want to merge the conflict

" undotree remap
nnoremap <leader>u : UndotreeShow<CR>

"----------------------------- vim-javascript  ----------------------------------------
" Enables syntax highlighting for JSDocs.
let g:javascript_plugin_jsdoc = 1
" Enables some additional syntax highlighting for NGDocs
let g:javascript_plugin_ngdoc = 1
" Enables code folding for javascript based on our syntax file.
" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END

"----------------------------- vim-jsx-pretty  ----------------------------------------
let g:vim_jsx_pretty_colorful_config = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:vim_jsx_pretty_template_tags=['html', 'jsx']
let g:vim_jsx_pretty_highlight_close_tag = 0

"----------------------------- vim-prettier  ----------------------------------------
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

"----------------------------- vim-highlightedyank  ----------------------------------------
" highlighting test on yank
" augroup highlight_yank
"     autocmd!
"     autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
" augroup END
if !exists('##TextYankPost')
endif
  map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 100


"----------------------------- Lightline ----------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"----------------------------- NERDtree ----------------------------------------
" " Toggle
" " nmap <leader>r :NERDTreeFind<CR>
" nnoremap <leader>t :NERDTreeToggle %<CR>
" let g:NERDTreeIgnore = ['^node_modules$']
" let g:NERDTreeShowHidden = 1 " dotfiles files and folder to be shown in sidebar
" let g:NERDTreeAutoDeleteBuffer=1 " rename a file, NERDTree will automatically load the new one
" " let g:NERDTreeMinimalUI = 1
" let g:NERDTreeStatusline = ''
" " Open nerd tree at the current file or close nerd tree if pressed again.
" " nnoremap <silent> <expr> <Leader>t g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
" " Automaticaly close nvim if NERDTree is only thing left open
" " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " " sync open file with NERDTree
" " " Check if NERDTree is open or active
" " function! IsNERDTreeOpen()
" "   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" " endfunction

" " " Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" " " file, and we're not in vimdiff
" " function! SyncTree()
" "   if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
" "     NERDTreeFind
" "     wincmd p
" "   endif
" " endfunction

" " " Highlight currently open buffer in NERDTree
" " autocmd BufEnter * call SyncTree()

" " Nerdtree Git Plugin
" let g:NERDTreeGitStatusWithFlags = 1
" let g:NERDTreeGitStatusIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }


"---------------------------------------------------------------------
" toggle word-wrap
function ToggleWrap()
  if (&wrap ==1 )
    set nowrap
  else 
    set wrap
  endif
endfunction

map <F9> :call ToggleWrap()<CR>
map <A-z> :call ToggleWrap()<CR>
map! <F9> ^[:call ToggleWrap()<CR>

"---------------------------------------------------------------------

"---------------------------------------------------------------------
" Quick scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']
"---------------------------------------------------------------------
