set encoding=utf-8

scriptencoding utf-8

augroup vimrc
    autocmd!
augroup END

filetype off
filetype plugin indent off


if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" NeoBudle関係 {{{
" NeoBundleがない場合、インストールする
if !isdirectory(expand('~/.vim/bundle'))
    silent call mkdir(expand('~/.vim/bundle'), 'p')
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    echo "Installed neobundle.vim"
    if v:shell_error
        echorerr "neobundle.vim intallation has failed!"
    endif
endif

call neobundle#begin(expand('~/.vim/bundle'))

" ここにインストールしたいプラグインのリストを書く
" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'

" Vimで非同期処理を実現する
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \   'cygwin' : 'make -f make_cygwin.mak',
            \   'mac'    : 'make -f make_mac.mak',
            \   'unix'   : 'make -f make_unix.mak',
            \   }
            \ }

" vimshell
NeoBundle 'Shougo/vimshell.vim', {
            \ 'depends' :
            \     ['Shougo/vimproc.vim']
            \ }

" Vimでweb-apiを使用する
NeoBundle 'mattn/webapi-vim'

" Vimからブラウザを開く
NeoBundle 'tyru/open-browser.vim'

" 列整形
NeoBundle 'junegunn/vim-easy-align'

" lightline.vim（ステータスライン表示プラグイン）
NeoBundle 'itchyny/lightline.vim'

" fugitive.vim（Git関連。ステータスラインにブランチ表示させているのもこれ）
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" rails便利プラグイン（modelとかviewとかにすぐ移動できたりする）
NeoBundle 'tpope/vim-rails'

" ツリー表示
NeoBundle 'scrooloose/nerdtree'

" RubyやVim Scriptでend(endif)等を自動的につけてくれる
NeoBundle 'tpope/vim-endwise'

" fの候補をハイライト
NeoBundle 'deris/vim-shot-f'

" HTMLタグ補完
NeoBundle 'mattn/emmet-vim'

" カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'

" 括弧補完
NeoBundle 'jiangmiao/auto-pairs'

" 天気予報
NeoBundle 'mizukmb/otenki.vim', {
            \ 'depends' : [
            \   'mattn/webapi-vim'
            \   ]
            \ }

" mocho.vim（めっちゃすごい！！！！）
NeoBundle 'mizukmb/mocho'

" syntacs check
NeoBundle 'scrooloose/syntastic'

" 補完機能
NeoBundle 'Shougo/neocomplete.vim'

" テキストを囲うもの("",'',{}など)の編集を補助する
NeoBundle 'tpope/vim-surround'

" Rubyに特化した補完機能
NeoBundleLazy 'marcus/rsense', {
            \ 'autoload' : {
            \   'filetypes' : 'ruby'
            \   }
            \ }

" RsenseをNeocomplteで使うため
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
            \ 'depends' :
            \   ['Shougo/neocomplete.vim',
            \    'marcus/rsense'],
            \ 'autoload' : {
            \   'filetypes' : 'ruby'
            \   }
            \ }

" Golangの設定（Fmt, Inport, Godocコマンドの提供）
NeoBundleLazy 'vim-jp/vim-go-extra', {
            \ 'autoload' : { 'filetypes' : 'go' }
            \ }
" NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}

" TweetVim
NeoBundleLazy 'basyura/twibill.vim'
NeoBundleLazy 'basyura/TweetVim', {
            \ 'depends' :
            \      ['basyura/twibill.vim',
            \      'tyru/open-browser.vim'],
            \ 'autoload' : {
            \      'commands' :
            \          ['TweetVimHomeTimeline',
            \           'TweetVimMentions',
            \           'TweetVimSay']
            \      }
            \ }

call neobundle#end()

" required
filetype plugin indent on
" }}}


" キーマッピング
" <leader>に設定するキー
let mapleader = " "

noremap j gj
noremap k gk
noremap <S-h> g^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> g$
noremap m  %
noremap %  m
noremap :  ;
noremap ;  :

nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''
nnoremap s <Nop>
nnoremap <silent> ss :split<CR>
nnoremap <silent> sv :vsplit<CR>
nnoremap <silent> sh <C-w>h
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l
nnoremap <Leader>n  :NERDTree<CR>
nnoremap <Leader>v  :vs<CR>:<C-u>VimShell<CR>
nnoremap <Leader>tl :vs<CR>:TweetVimHomeTimeline<CR>
nnoremap <Leader>tm :vs<CR>:TweetVimMentions<CR>
nnoremap <Leader>ts :TweetVimSay<CR>
nnoremap <Leader>o  :OtenkiTomorrow<CR>
nnoremap <Leader>oh :Otenki hachinohe<CR>

inoremap <C-f> <C-x><C-o>
inoremap <silent> <C-u> <Esc>u<Insert>
inoremap <silent> <C-r> <Esc><C-r><Insert>
inoremap <silent> <C-p> <Esc>p<Insert>

vmap <Enter> <Plug>(EasyAlign)

imap <F2> <nop>
set pastetoggle=<F2>


" 表示系（ステータスラインの表示はlightlineプラグインが優先される）
set number       "行番号表示
set laststatus=2 "ステータスラインを常に表示

"カラー表示
syntax enable
"オートインデント
set smartindent
" <BS>で何でも消せる
set backspace=start,eol,indent

" タブスペースのデフォルトは半角スペース4文字
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab

" 検索系
set ignorecase  "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase   "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch  "検索結果文字列の非ハイライト表示

" カレント行に下線を表示する
set cursorline

" コマンド履歴
set history=100

" 補完時にプレビューウインドウを表示させない
set completeopt=menuone,menu


" Uniteの設定
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" TweetVim関係
" 1ページに表示する最大数
let g:tweetvim_tweet_per_page = 50

" emmitの設定
" HTML/CSSファイルのみ有効
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" カラースキーム
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" otenki.vimの設定
let g:otenki_cityname_data = 'hakodate'

" syntasticの設定
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }

" Rsenseの設定
let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:rsenseUseOmniFunc = 1

" neocompleteの設定
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]>\w*\|\h\w*::'

" ファイルを開いた際に、前回終了時の行で起動
autocmd vimrc BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
            \ endif

" Go setting
function! s:golang_settings()
    setlocal noexpandtab
    let g:syntatic_mode_map = {
                \ 'active_filetypes' : [ 'go' ] 
                \ }
    let g:syntatic_go_checkers = ['go', 'golint']
endfunction
autocmd vimrc FileType go call <SID>golang_settings()

" Ruby settig
function! s:ruby_settings()
    setlocal tabstop=2 shiftwidth=2 softtabstop=2 
    let g:rsenseUseOmniFunc = 1
endfunction
autocmd vimrc FileType ruby call <SID>ruby_settings()

" lightlineの設定 {{{
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map':    {'c': 'NORMAL'},
            \ 'active':      {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['otenki'], ['mocho'] ]
            \ },
            \ 'component_function': {
            \   'modified':         'MyModified',
            \   'readonly':         'MyReadonly',
            \   'fugitive':         'MyFugitive',
            \   'filename':         'MyFilename',
            \   'mocho':            'MyMocho',
            \   'otenki':           'MyOtenki',
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

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            let _ = fugitive#head()
            return strlen(_) ? '🍣 '._ : ''
        endif
    catch
    endtry
    return ''
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

function! MyOtenki()
    return winwidth(0) > 70 ? MyStatusOtenki() : ''
endfunction
" }}}

