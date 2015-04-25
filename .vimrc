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
NeoBundle 'Shougo/unite.vim'
" 列整形
NeoBundle 'junegunn/vim-easy-align.git'
NeoBundle 'basyura/bitly.vim.git'
NeoBundle 'basyura/TweetVim.git' " TweetVim
NeoBundle 'basyura/twibill.vim.git'
NeoBundle 'h1mesuke/unite-outline.git'
NeoBundle 'mattn/webapi-vim.git'
NeoBundle 'tyru/open-browser.vim.git' " Vimからブラウザを開くプラグイン
NeoBundle 'yomi322/neco-tweetvim.git'
NeoBundle 'yomi322/unite-tweetvim.git'
NeoBundle 'mizukmb/mocho.git' " mocho.vim（めっちゃすごい！！！！）
NeoBundle 'itchyny/lightline.vim' " lightline.vim（ステータスライン表示プラグイン）
NeoBundle 'tpope/vim-fugitive' " fugitive.vim（Git関連。ステータスラインにブランチ表示させているのもこれ）
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tomtom/tcomment_vim' " コメントON/OFFを手軽に実行
NeoBundle 'tpope/vim-rails' " rails便利プラグイン（modelとかviewとかにすぐ移動できたりする）
NeoBundle 'scrooloose/nerdtree' " ツリー表示
NeoBundle 'tpope/vim-endwise.git' " Rubyでendを自動的につけてくれる
NeoBundle 'deris/vim-shot-f.git' " fの候補をハイライト
NeoBundle 'Shougo/vimshell.vim.git' " vimshell
NeoBundle 'Shougo/vimproc.vim.git' " vimproc(vimshellに必要)
NeoBundle 'mattn/emmet-vim' " HTMLタグ補完
NeoBundle 'altercation/vim-colors-solarized' " カラースキーム
NeoBundle 'w0ng/vim-hybrid'
NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}} " Gocode
" NeoBundleLazy 'faith/vim-go', {"autoload": {"filetypes": ['go']}}
NeoBundle 'jiangmiao/auto-pairs.git' " 括弧補完
NeoBundle 'rbtnn/game_engine.vim' " ゲームエンジン
NeoBundle 'rbtnn/reversi.vim' " リバーシ
NeoBundle 'mizukmb/otenki.vim.git' " 天気予報
NeoBundle 'scrooloose/syntastic' " syntacs check
NeoBundle 'Shougo/neocomplete.vim' " 補完機能
NeoBundle 'marcus/rsense' " Rubyに特化した補完機能
NeoBundle 'supermomonga/neocomplete-rsense.vim' " RsenseをNeocomplteで使うため
" }}}

call neobundle#end()

" required
filetype plugin indent on

" キーマッピング
noremap j gj
noremap k gk
noremap <S-h>   g^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   g$
noremap m  %
noremap %  m
noremap :  ;
noremap ;  :

nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''
nnoremap <Space>n  :NERDTree<CR>
nnoremap <Space>v  :vs<CR>:<C-u>VimShell<CR>
nnoremap <Space>tl  :vs<CR>:TweetVimHomeTimeline<CR>
nnoremap <Space>tm  :vs<CR>:TweetVimMentions<CR>
nnoremap <Space>ts  :TweetVimSay<CR>
nnoremap <Space>o :OtenkiTomorrow<CR>
nnoremap <Space>oh :Otenki hachinohe<CR>

inoremap <C-f> <C-x><C-o>

vmap <Enter> <Plug>(EasyAlign)


" 表示系（ステータスラインの表示はlightlineプラグインが優先される）
set number "行番号表示
set laststatus=2 "ステータスラインを常に表示


" プログラミングヘルプ系
syntax enable "カラー表示
set smartindent "オートインデント
set backspace=start,eol,indent


" タブスペースのデフォルトは半角スペース2文字
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2


" 検索系
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch "検索結果文字列の非ハイライト表示


" カレント行に下線を表示する
set cursorline


" Go言語の設定
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
let g:gofmt_command = 'goimports'


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

" If open Go file
autocmd vimrc BufRead *.go setlocal noexpandtab

" If open Ruby file
autocmd vimrc BufRead *.rb setlocal tabstop=2 shiftwidth=2 softtabstop=2 |
      \ let g:rsenseUseOmniFunc = 1


" lightlineの設定 {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['mocho'], ['otenki'] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'mocho': 'MyMocho',
      \   'otenki': 'MyOtenki',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode'
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
  return g:StatusMocho()
endfunction

function! MyOtenki()
  return g:MyStatusOtenki()
endfunction
" }}}


