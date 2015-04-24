" コマンドラインの高さ(GUI使用時)
set cmdheight=1
let s:ext = fnamemodify(bufname(""), ":e")

"フォント関連
set guifont=Andale\ Mono:h16
set antialias
hi NonText guibg=NONE guifg=NONE
hi Normal guibg=grey5
hi LineNr gui=bold
hi LineNr guifg=#DDDDDD

" 画面サイズ
set lines=100
set columns=240

"全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey 

" フルスクリーン化（煩わしいのでとめた）
" if has("gui_running")
"   set fuoptions=maxvert,maxhorz
"   au GUIEnter * set fullscreen
" endif
