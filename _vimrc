"字符编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
"set termencoding=cp936
"解决mac下终端中文显示的问题
let &termencoding=&encoding
language messages zh_CN.UTF-8 
"字体设置
set guifont=Monaco:h14
"set gfw=Monaco:h20:cANSI
set gfw="幼圆:h12"


source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700
set nocompatible
set nobackup
" set fdm=indent
" Enable filetype plugin
filetype plugin on
"解决acp和snipMate的冲突"
let g:acp_behaviorSnipmateLength=1
"绑定补全类型"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"自动缩进
filetype indent off
"制表符长度
set tabstop=4
set shiftwidth=4
"用空格代替tab键，据说tab在不同操作系统中会有问题"
set expandtab

"退格键可删除断行
set backspace=indent,eol,start

" Set to auto read when a file is changed from the outside
set autoread

"缩进指示线"
"set list listchars=tab:\|\ 
"hi SpecialKey guifg=#eeeeee 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set cursorcolumn "光标列高亮"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colo kraihlight
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
set ruler

map <f10> :NERDTreeToggle<cr>

"括号补全
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap ( ()<ESC>i
:inoremap [ []<ESC>i
:inoremap { <c-r>=ClsoeBrace()<CR>
""function ClosePair(char)
""if getline('.')[col('.') - 1] == a:char
""return "\<Right>"
""else
""return a:char
""endif
""endf
function Close()
	return " /"
endf
function ClsoeBrace()
if getline('.')[col('.') - 2] == '='
return "{}\<ESC>i"
elseif getline('.')[col('.') - 3] == '='
return "{}\<ESC>i"
elseif getline('.')[col('.') - 1] == '{'
return "{}\<ESC>i"
elseif getline('.')[col('.') - 2] == '{'
return "{}\<ESC>i"
elseif getline('.')[col('.') - 2] == ','
return "{}\<ESC>i"
elseif getline('.')[col('.') - 3] == ','
return "{}\<ESC>i"
else
return "{\<ENTER>}\<ESC>O"
endif
endf

"html缩进
:let g:html_indent_script1 = "inc"
:let g:html_indent_style1 = "inc"
:let g:html_indent_div1 = "inc"

"设置扩展名的文件类型
if has("autocmd")
    autocmd BufRead,BufNewFile *.html,*.shtml,*.vm set filetype=html.xhtml
endif

au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.less set ft=less.css syntax=less.css
au BufRead,BufNewFile *.ftl set ft=ftl.xhtml.html syntax=html
au BufRead,BufNewFile *.md set syntax=mkd

"设置字典
autocmd filetype javascript set dictionary=$VIM/vimfiles/dict/javascript.dict
autocmd filetype css set dictionary=$VIM/vimfiles/dict/css.dict

"for Taglist
let Tlist_Ctags_Cmd="ctags.exe" 
let Tlist_Auto_Open=0 
let Tlist_Exit_OnlyWindow=1 
let Tlist_Use_Right_Window = 1

"for author
let g:vimrc_author='Smeagol' 
let g:vimrc_email='star212417@163.com' 
let g:vimrc_homepage='http://www.quxing.info' 

nmap <F4> :AuthorInfoDetect<cr> 

"快捷键设置
nmap <F5> :!%<cr>
"对当前文件运行的html tidy脚本,用来输出html错误还可以，格式化是2个空格缩进的"
nmap <F6> :%!tidy -i -f err.txt<cr>
"插入时间
imap <leader>t <c-r>=strftime('%c')<cr>



"FuzzyFinder"
""|:FufFile|         - File mode (|fuf-file-mode|) 
""|:FufCoverageFile| - Coverage-File mode (|fuf-coveragefile-mode|) 
""|:FufDir|          - Directory mode (|fuf-dir-mode|) 
""|:FufMruFile|      - MRU-File mode (|fuf-mrufile-mode|) 
""|:FufMruCmd|       - MRU-Command mode (|fuf-mrucmd-mode|) 
""|:FufBookmarkFile| - Bookmark-File mode (|fuf-bookmarkfile-mode|) 
""|:FufBookmarkDir|  - Bookmark-Dir mode (|fuf-bookmarkdir-mode|) 
""|:FufTag|          - Tag mode (|fuf-tag-mode|) 
""|:FufBufferTag|    - Buffer-Tag mode (|fuf-buffertag-mode|) 
""|:FufTaggedFile|   - Tagged-File mode (|fuf-taggedfile-mode|) 
""|:FufJumpList|     - Jump-List mode (|fuf-jumplist-mode|) 
""|:FufChangeList|   - Change-List mode (|fuf-changelist-mode|) 
""|:FufQuickfix|     - Quickfix mode (|fuf-quickfix-mode|) 
""|:FufLine|         - Line mode (|fuf-line-mode|) 
""|:FufHelp|         - Help mode (|fuf-help-mode|) 
""
nmap <F2> :FufFile<cr>


