set encoding=utf-8

scriptencoding utf-8

augroup myVimrc
    autocmd!
augroup END

filetype off
filetype plugin indent off


let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 各種設定
" {{{

" 表示系（ステータスラインの表示はlightlineプラグインが優先される）
set number       "行番号表示
set laststatus=2 "ステータスラインを常に表示

"カラー表示
syntax enable
"オートインデント
set smartindent
" <BS>で何でも消せる
set backspace=start,eol,indent

" タブスペースのデフォルトは半角スペース2文字
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab

" 検索系
set ignorecase  "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase   "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch  "検索結果文字列の非ハイライト表示

" 現在行に下線を表示する
set cursorline
function! s:highlight_settings()
  highlight CursorLine ctermbg=NONE
  highlight CursorIME ctermbg=NONE
  highlight CursorLineNr ctermbg=234
  highlight LineNr ctermbg=NONE
endfunction
autocmd myVimrc ColorScheme * call <SID>highlight_settings()

" コマンド履歴
set history=100

" 補完時にプレビューウインドウを表示させない
set completeopt=menuone,menu

" "タブ、空白、改行の可視化
set list
set listchars=eol:¬,tab:>\ ,extends:<,trail:_

" 折りたたみ機能の有効化
set foldmethod=marker

" 隠れバッファの有効化
set hidden

" Go
autocmd myVimrc BufRead,BufNew,BufNewFile *.go setlocal filetype=go

" }}}


" dein関係
" {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/dotfiles/dein.toml'
  " let s:lazy_toml = '~/dotfiles/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  " call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif


if dein#check_install()
  call dein#install()
endif

" required
filetype plugin indent on
" }}}


" キーマッピング
" {{{

" <leader>に設定するキー
let mapleader = " "


noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <S-h> g^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> g$
noremap :  ;
noremap ;  :
noremap / /\v

nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''
" nnoremap s <Nop>
" nnoremap <silent> ss :split<CR>
" nnoremap <silent> sv :vsplit<CR>
" nnoremap <silent> sh <C-w>h
" nnoremap <silent> sj <C-w>j
" nnoremap <silent> sk <C-w>k
" nnoremap <silent> sl <C-w>l
nnoremap <Leader>n  :NERDTree<CR>
nnoremap <Leader>v  :vs<CR>:<C-u>VimShell<CR>
nnoremap <Leader>o  :OtenkiTomorrow<CR>
nnoremap <Leader>oh :Otenki hachinohe<CR>
nnoremap <Leader>q  :QuickRun<CR>
nnoremap <Leader>ub :Unite<Space>buffer<CR>
nnoremap <Leader>uf :Unite<Space>file<CR>
nnoremap <Leader>um :Unite<Space>file_mru<CR>

inoremap <C-f> <C-x><C-o>
inoremap <silent> <C-u> <Esc>u<Insert>
inoremap <silent> <C-r> <Esc><C-r><Insert>
inoremap <silent> <C-p> <Esc>p<Insert>

vmap <Enter> <Plug>(EasyAlign)

imap <F2> <nop>
set pastetoggle=<F2>
" }}}


" プラグイン設定
" {{{

" Uniteの設定
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" reference http://qiita.com/joker1007/items/c8962f9325a5433dc50d
let g:unite_source_grep_command = 'ag' " unite grep のバックエンドを ag にして高速化する
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" カラースキーム
colorscheme Iceberg
highlight Normal ctermbg=none

" otenki.vimの設定
let g:otenki_cityname_data = 'hakodate'

" neocompleteの設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_underbar_comletion = 1
let g:neocomplete#enable_camel_case_comletion = 1
let g:neocomplete#max_list = 10
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.ruby = ['::']
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.ruby =
"       \ '[^. *\t]\.\w*\|\h\w*::'

" vim-quickrunの設定
let g:quickrun_config = {
            \ "_" : {
            \   "runner"                    : "vimproc",
            \   "runner/vimproc/updatetime" : 60,
            \   "outputter/buffer/running_mark" : mocho#echo()
            \ },
            \ }

" gist-vimの設定
let g:github_user = 'mizukmb'
let g:gist_curl_options = "-k"
let g:gist_detect_filetype = 1

" gitgutterの設定
let g:gitgutter_max_signs = 100000

" lightlineの設定
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map':    {'c': 'NORMAL'},
            \ 'active':      {
            \   'left': [ [ 'mode', 'paste' ], ['mocho'] ]
            \ },
            \ 'component_function': {
            \   'modified':         'MyModified',
            \   'readonly':         'MyReadonly',
            \   'filename':         'MyFilename',
            \   'mocho':            'MyMocho',
            \   'filetype':         'MyFiletype',
            \   'fileformat':       'MyFileformat',
            \   'fileencoding':     'MyFileencoding',
            \   'mode':             'MyMode'
            \ }
            \ }


function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyMocho()
    return winwidth(0) > 70 ? StatusMocho() : ''
endfunction


" }}}


" その他設定
" {{{

" ファイルを開いた際に、前回終了時の行で起動
autocmd myVimrc BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
            \ endif

" Go setting
function! s:golang_settings()
    " Go言語はハードタブ推奨
    setlocal noexpandtab
    let g:syntatic_mode_map = {
                \ 'active_filetypes' : [ 'go' ] 
                \ }
    let g:syntatic_go_checkers = ['go', 'golint']
endfunction
autocmd myVimrc FileType go call <SID>golang_settings()

" Ruby settig
function! s:ruby_settings()
    setlocal tabstop=2 shiftwidth=2 softtabstop=2 
endfunction
autocmd myVimrc FileType ruby call <SID>ruby_settings()

" HTML setting
function! s:html_settings()
    setlocal tabstop=2 shiftwidth=2 softtabstop=2
    " let g:quickrun_config['html'] = {
    "       \ 'outputter' : 'browser',
    "       \ }
endfunction
autocmd myVimrc FileType html call <SID>html_settings()

" JSON setting
function! s:json_settings()
  setlocal tabstop=4 shiftwidth=4 softtabstop=4
endfunction
autocmd myVimrc FileType json call <SID>json_settings()
" }}}

