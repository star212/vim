"�ַ�����
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
set termencoding=cp936
language messages zh_CN.UTF-8 
"��������
set guifont=Consolas:h14:cANSI
set gfw=��Բ:h12:cGB2312

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
"�Զ�����
filetype indent off
"�Ʊ������
set tabstop=4
set shiftwidth=4
"�ÿո����tab������˵tab�ڲ�ͬ����ϵͳ�л�������"
set expandtab
"�˸����ɾ������
set backspace=indent,eol,start

" Set to auto read when a file is changed from the outside
set autoread
"����ָʾ��"
"set list listchars=tab:\|\ 
"hi SpecialKey guifg=#eeeeee 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set cursorcolumn "����и���"

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

"���Ų�ȫ
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

"html����
:let g:html_indent_script1 = "inc"
:let g:html_indent_style1 = "inc"
:let g:html_indent_div1 = "inc"

"������չ�����ļ�����
if has("autocmd")
    autocmd BufRead,BufNewFile *.html,*.shtml,*.vm set filetype=html.xhtml
endif

au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.less set ft=less.css syntax=less.css
au BufRead,BufNewFile *.ftl set ft=ftl.xhtml.html syntax=html

"�����ֵ�
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

"��ݼ�����
nmap <F5> :!%<cr>
"�Ե�ǰ�ļ����е�html tidy�ű�,�������html���󻹿��ԣ���ʽ����2���ո�������"
nmap <F6> :%!tidy -i -f err.txt<cr>
"����ʱ��
imap <leader>t <c-r>=strftime('%c')<cr>
