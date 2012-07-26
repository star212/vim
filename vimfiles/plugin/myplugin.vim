"这个是一个vim插件的模板
"避免脚本重复加载
if exists("loaded_myplugin")
	finish
endif
let loaded_myplugin = 1

"续行功能开启
let s:save_cpo = &cpo
set cpo&vim

"修正错误的单词
iabbrev teh the
iabbrev otehr other
iabbrev synchronisation
		\ synchronization

"局部变量
let s:count = 4

"映射到某个键上，这里是\a
if !hasmapto('<Plug>mypluginAdd')
	map <unique> <Leader>a <Plug>MypluginAdd
endif

"将函数映射到脚本里面
noremap <unique> <script> <Plug>MypluginAdd <SID>Add
"将菜单项映射到这个函数上
noremenu <script> Plugin.Add\ Correction <SID>Add
"将脚本函数映射到局部函数上
noremap <SID>Add :call <SID>Add(expand("aaa"),1)<CR>

function s:Add(from, correct)
	"添加一个单词修正 for 上面的aaa
	"let to = input("type the correction for " . a:from . ": ")
	"exe ":iabbrev " . a:from . " " . to
	"if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
	"let s:count = s:count + 1
	"echo s:count . " corrections now"
	redir @a
	echo "目录："
	g/body/echo getline(".") . "\t\t\t" . line(".")
	redir END
endfunction

"定义Correct命令
if !exists(":Correct")
	command -nargs=1 Corrent :call s:Add(<q-args>, 0)
endif

"关闭续行功能
let &cpo = s:save_cpo
