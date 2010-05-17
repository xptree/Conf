" vim: fdm=marker
" .vimrc file
" Recommended for vim >= 7, though works with vim 6
" By Lucas Oman
" me@lucasoman.com
" --enable-rubyinterp --prefix=/usr --enable-ruby
" from: http://github.com/lucasoman/Conf/raw/master/.vimrc

set nocompatible
syntax on
filetype on
"filetype plugin on

" fast terminal for smoother redrawing
set ttyfast

" {{{ interface
" lines, cols in status line
set ruler
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P

" a - terse messages (like [+] instead of [Modified]
" t - truncate file names
" I - no intro message when starting vim fileless
set shortmess=atI

" display the number of (characters|lines) in visual mode, also cur command
set showcmd

" current mode in status line
set showmode

" max items in insert menu
if version >= 700
  set pumheight=8
endif

" number column
set number
if version >= 700
  set numberwidth=3
end

" show fold column, fold by markers
set foldcolumn=2
set foldmethod=marker

" line numbering
set showbreak=>\ 

" always show tab line
if version >= 700
  set showtabline=2
endif

" highlight search matches
set hlsearch

" highlight position of cursor
set cursorline
set cursorcolumn

"set statusline=%f\ %2*%m\ %1*%h%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}\ %{getfperm(@%)}]\ 0x%B\ %12.(%c:%l/%L%)
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"set laststatus=2
" }}}
" {{{ colors
" tabe line colors
highlight TabLineFill ctermfg=DarkGray
highlight TabLine ctermfg=7 ctermbg=DarkGray cterm=none
highlight TabLineSel ctermfg=7 cterm=bold ctermbg=DarkGray

" number column colors
highlight LineNr cterm=bold ctermbg=DarkGray cterm=none ctermfg=4

" fold colors
highlight Folded cterm=bold ctermbg=DarkGray cterm=none ctermfg=4
highlight FoldColumn cterm=bold ctermbg=DarkGray cterm=none ctermfg=4

" visual mode colors
highlight Visual ctermbg=7 ctermfg=4

" dictionary menu colors
highlight Pmenu ctermbg=7 ctermfg=0
highlight PmenuSel ctermbg=Yellow ctermfg=0

" diff colors
highlight DiffAdd cterm=none ctermbg=DarkGray
highlight DiffDelete cterm=none ctermbg=DarkGray
highlight DiffChange cterm=none ctermbg=none
highlight DiffText cterm=none ctermbg=DarkGray

" keep cursor column last so it overrides all others
highlight CursorColumn cterm=bold ctermbg=DarkGray cterm=none
highlight CursorLine cterm=bold ctermbg=DarkGray cterm=none

highlight Search cterm=none ctermbg=7 ctermfg=4

" the dark colors kill my eyes
set background=light
" }}}
" {{{ behavior
set omnifunc=syntaxcomplete#Complete

set shiftwidth=2
set tabstop=2
set cindent

" turn off auto-wrap in all cases.
" let's see what happens with below formatoptions
" set tw=0

" show matching enclosing chars for .1 sec
set showmatch
set matchtime=1

" t: autowrap text using textwidth
" l: long lines are not broken in insert mode
" c: autowrap comments using textwidth, inserting leader
" r: insert comment leader after <CR>
" o: insert comment leader after o or O
set formatoptions-=t
set formatoptions+=lcro
set textwidth=80

" context while scrolling
set scrolloff=3

" arrow keys, bs, space wrap to next/prev line
set whichwrap=b,s,<,>,[,]

" backspace over anything
set backspace=indent,eol,start

" case insensitive search if all lowercase
set ignorecase smartcase

" turn off bells, change to screen flash
set visualbell

" gf should use new tab, not current buffer
if version >= 700
	map gf :tabe <cfile><CR>
else
	map gf :bad <cfile><CR>
endif

" show our whitespace
" alternate character: »
"not a big fan of this; will keep just in case
"set listchars=tab:··,trail:·
"set list

" complete to longest match, then list possibilities
set wildmode=longest,list

" turn off swap files
set noswapfile

" }}}
" {{{ filetype dependent
autocmd BufNewFile,BufRead *.html setlocal commentstring=<!--%s-->

" ruby commenstring
autocmd FileType ruby setlocal commentstring=#%s

autocmd FileTYpe python setlocal nocindent autoindent
"}}}
" {{{ mapped shortcuts
let mapleader = "\\"
" quicker aliases for navigating tabs
nmap H gT
nmap L gt
nmap <C-l> :call MoveTab(0)<CR>
nmap <C-h> :call MoveTab(-2)<CR>
" easier move screen up/down
nmap <C-j> <C-e>
nmap <C-k> <C-y>
" creates a fold from a block of code in {}s
nmap <Leader>pf $va}zf
" php syntax check
nmap <Leader>ps :!php -l %<CR>
nmap <Leader>pr :!php % \| less -F<CR>
nmap <Leader>ph :!php --rf <cword><CR>
nmap <Leader>ff :call ToggleFoldFuncs()<CR>
" turns of highlighting
nmap <Leader>/ :nohl<CR>
" search for highlighted text
vmap // y/<C-R>"<CR>
" keep block highlighted when indenting
vmap >> >gv
vmap << <gv
nmap <Leader>l o----------------------------------------------------<CR><ESC>
" phpdoc comments
nmap <Leader>cc o/**<CR>$Rev$<CR>$Date$<CR>$Id$<CR>$Author$<CR>$HeadURL$<CR><CR><CR><CR>@author Lucas Oman <lucas.oman@bookit.com><CR><BS>/<ESC>kkk$a 
nmap <Leader>cb o/**<CR><CR><CR>@author Lucas Oman <lucas.oman@bookit.com><CR>@param <CR>@return <CR>@example <CR><BS>/<ESC>kkkkkk$a 
nmap <Leader>cv o/**<CR><CR><CR>@var <CR><BS>/<ESC>kkk$a
nmap <Leader>cp o/**<CR><CR><CR>@author Lucas Oman <me@lucasoman.com><CR>@param <CR>@return <CR>@example <CR><BS>/<ESC>kkkkkk$a 
vmap <Leader>cc :s!^!//!<CR>
vmap <Leader>cu :s!^//!!<CR>
" svn
nmap <Leader>sc :!svnconsole.php<CR><CR>
nmap <Leader>sk :!svn propset svn:keywords "Rev Date Id Author HeadURL" %<CR>
" Open Current (path)
nmap <Leader>oc :tabe %:h<CR>
" ctags
nmap <Leader>tf :call CtagsFind(expand('<cword>'))<CR>
nmap <Leader>ts :exe('stj '.expand('<cword>'))<CR>
" fix a block of XML; inserts newlines, indents properly, folds by indent
nmap <Leader>fx :setlocal filetype=xml<CR>:%s/></>\r</g<CR>:1,$!xmllint --format -<CR>:setlocal foldmethod=indent<CR>
"f keys
nmap <F2> :call ToggleColumns()<CR>
imap <F2> <C-o>:call ToggleColumns()<CR>
nmap <F3> :call LoadSession()<CR>
nmap <F4> :!updater<CR>
set pastetoggle=<F5>
nmap <F6> :!updatedev.php<CR>
nmap <F7> :!updatedev.php %:p<CR>
nmap <F8> :call WriteTrace()<CR>
nmap <F9> :!php --rf <cword><CR>
" }}}
" snippets{{{
let s:snippets = {}
let s:snippets['^\s*if$'] = " () {\<CR>}\<ESC>k^f)i" 
let s:snippets['function$'] = "  () {\<CR>}\<ESC>k^t(i" 
let s:snippets['^\s*class$'] = "  {\<CR>}\<ESC>kt{i"
let s:snippets['^\s*interface$'] = "  {\<CR>}\<ESC>kt{i"
let s:snippets['^\s*foreach$'] = " () {\<CR>}\<ESC>k^f)i" 
let s:snippets['^\s*while$'] = " () {\<CR>}\<ESC>k^f)i" 
"}}}
" Commands {{{
" grep for given string (second is case insensitive)
" eg: :F lib/ BadXMLException
com! -nargs=+ F :call CommandFind("<args>",0)
com! -nargs=+ Fi :call CommandFind("<args>",1)
fun! CommandFind(args,ci)
	let parts = split(a:args,' ')
	let path = l:parts[0]
	call remove(l:parts,0)
	let search = join(l:parts,' ')
	tabe
	set buftype=nofile
	if a:ci
		exe "r !grep -rli '".l:search."' ".l:path." | grep -v '.svn'"
	else
		exe "r !grep -rl '".l:search."' ".l:path." | grep -v '.svn'"
	endif
endfunction
"}}}
"{{{ ToggleColumns()
"make it easy to remove line number column etc. for cross-terminal copy/paste
fun! ToggleColumns()
  if &number
    set nonumber
    set foldcolumn=0
    let s:showbreaktmp = &showbreak
    set showbreak=
		"set nolist
  else
    set number
    set foldcolumn=2
    let &showbreak = s:showbreaktmp
		"set list
  end
endfunction
"}}}
"{{{ ToggleFoldFuncs()
"turns on or off folding php functions
fun! ToggleFoldFuncs()
	if &foldmethod == "marker"
		setlocal foldmethod=expr
		setlocal foldexpr=FoldFuncsExpr(v:lnum)
	else
		setlocal foldmethod=marker
	end
endfunction
fun! FoldFuncsExpr(num)
	"if match(getline(a:num),"function \w+\s?\(") > -1
	if match(getline(a:num),"function ") > -1
		return ">1"
	else
		return "="
	endif
endfunction
"}}}
"WriteTrace() {{{
fun! WriteTrace()
	let lineNum = line('.')
	let lineFile = bufname('%')
	let lineVal = getline(lineNum)

	let allLines = readfile($HOME."/trace.txt")
	let allLines = add(allLines,lineFile.":".lineNum)
	let allLines = add(allLines,lineVal)
	let allLines = add(allLines,"")

	call writefile(allLines,$HOME."/trace.txt")
endfunction
"}}}
"{{{CleverTab()
fun! CleverTab()
	let beginning = strpart( getline('.'), 0, col('.')-1 )
	for key in keys(s:snippets)
		if l:beginning =~ key
			return s:snippets[key]
		endif
	endfor
	if l:beginning =~ '^\s*$' || l:beginning =~ '\s$'
		return "\<Tab>"
	else
		return "\<C-P>"
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
"}}}
"{{{ session stuff
" don't store any options in sessions
if version >= 700
	" localoptions has to be here:
	" for some reason, new session loading code fails to set filetype of files in session
  set sessionoptions=blank,tabpages,folds,localoptions
endif

let s:sessionloaded = 0
let s:loadingsession = 0
let s:sessionfile = ''
let s:netrwsort = ''
autocmd BufRead *.vim call LoadSessionFinish()
fun! LoadSession()
	" save current netrw sort sequence
	let s:netrwsort = g:netrw_sort_sequence
	" show sessions first, then dirs
	let g:netrw_sort_sequence = '\.vim$,[\/]$'
	let s:loadingsession = 1
	e .
endfunction
fun! LoadSessionFinish()
	if s:loadingsession == 1
		let s:loadingsession = 0
		let s:sessionloaded = 1
		" restore previous sort sequence setting
		let g:netrw_sort_sequence = s:netrwsort
		" save session filename for saving on exit
		let s:sessionfile = bufname('%')
		source %
	end
endfunction
fun! SaveSession()
  if s:sessionloaded == 1
		let s:sessionloaded = 0
		" re-save session before exiting
    exe "mksession! ".s:sessionfile
  end
endfunction
autocmd VimLeave * call SaveSession()
" }}}
"{{{ list stuff
if version >= 700
	"autocmd BufNewFile,BufRead *.list highlight CursorLine NONE
	autocmd BufNewFile,BufRead *.list call ListFile()
	"autocmd TabLeave *.list highlight CursorLine cterm=bold ctermbg=0 cterm=none
	autocmd TabEnter *.list call ListFile()

	" 'install' list features
	fun! ListFile()
		setlocal foldmethod=expr
		setlocal foldexpr=ListFoldLevel(v:lnum)
		setlocal shiftwidth=4
		setlocal tabstop=4
		setlocal foldtext=ListFoldLine(v:foldstart)
		setlocal noshowmatch
		setlocal cindent
		" add [n]ew item below current
		map <buffer> ,n o- <C-R>=ListTimestamp()<CR><ESC>^la
		" mark item as [x]
		map <buffer> ,x mz^rxf[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		" mark item as [-]
		map <buffer> ,- mz^r-f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		" mark item as = (in [p]rogress)
		map <buffer> ,p mz^r=f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		" mark item as [o]
		map <buffer> ,o mz^rof[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		" mark item with a rank
		map <buffer> ,1 mz^r1f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		map <buffer> ,2 mz^r2f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		map <buffer> ,3 mz^r3f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		map <buffer> ,4 mz^r4f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		map <buffer> ,5 mz^r5f[hdf]$a<C-R>=ListTimestamp()<CR><ESC>`z
		" add/update [t]imestamp
		map <buffer> ,t mz$a [<ESC>^f[hd$a<C-R>=ListTimestamp()<CR><ESC>`z
	endfunction

	" return properly formatted timestamp
	fun! ListTimestamp()
		return ' ['.strftime('%y-%m-%d %H:%M').']'
	endfunction

	" return fold line format
	fun! ListFoldLine(linenum)
		let s:count = 1
		let s:spaces = ''
		while s:count <= &shiftwidth
			let s:spaces = s:spaces.' '
			let s:count = s:count + 1
		endwhile
		return substitute(getline(a:linenum),"\t",s:spaces,'g')
	endfunction

	" foldexpr function
	fun! ListFoldLevel(linenum)
		let s:prefix = ''
		let s:myline = getline(a:linenum)
		let s:nextline = getline(a:linenum+1)
		let s:mynumtabs = match(s:myline,"[^\t]",0)
		let s:nextnumtabs = match(s:nextline,"[^\t]",0)
		if s:nextnumtabs > s:mynumtabs " if this item has sub-items
			let s:level = s:nextnumtabs
		else " next item is either same or higher level
			let s:level = s:mynumtabs
			if s:nextnumtabs < s:mynumtabs " if next item has higher level, close this fold
				let s:prefix = '<'
				let s:level = s:nextnumtabs+1
			end
		endif
		if a:linenum > 1
			s:pline = getline(a:linenum-1)
			s:pnumtabs = match(s:pline,"[^\t]",0)
			if s:level < s:pnumtabs
			" if this is higher level than prev, start a new fold
				let s:prefix = '>'
			endif
		endif
		return s:prefix.s:level
	endfunction
endif
"}}}
"{{{ tab stuff
"tab line
fun! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'.(i+1).''

		" the filename is made by MyTabLabel()
		let s .= '%{MyTabLabel(' . (i + 1) . ')}  '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	return s
endfunction
fun! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let fullname = bufname(buflist[winnr - 1])
	"let fullname = substitute(fullname,"(\w){1}\w*/","\1/","g")
	let fullname = substitute(fullname,".*/","","")
	if getbufvar(buflist[winnr - 1],"&mod")
		let modified = "+"
	else
		let modified = " "
	endif
	return modified.fullname
endfunction
if version >= 700
	" Use the above tabe naming scheme
	set tabline=%!MyTabLine()
endif

"tab moving
fun! MoveTab(n)
	let which = tabpagenr()
	let which = which + a:n
	exe "tabm ".which
endfunction
"}}}
"svn stuff {{{
com! Sdiff :call SvnDiff(bufname('%'))
com! Slog :call SvnLog(bufname('%'))
com! Sinfo :call SvnInfo(bufname('%'))
com! Sblame :call SvnBlame(bufname('%'))
com! Sdiffs :call SvnDiffSplit(expand('%:h'),expand('%:t'))
nmap <Leader>sr :call SvnModeDiff(expand('<cword>'))<CR>gg

fun! SvnDiff(file)
	let file = SvnModeWindow(a:file)
	exe "r !svn diff ".l:file
	setlocal filetype=diff
endfunction
fun! SvnLog(file)
	let file = SvnModeWindow(a:file)
	exe "r !svn log -v ".l:file
endfunction
fun! SvnInfo(file)
	let file = SvnModeWindow(a:file)
	exe "r !svn info ".l:file
	setlocal filetype=yaml
endfunction
fun! SvnBlame(file)
	let file = SvnModeWindow(a:file)
	exe "r !svn blame ".l:file
endfunction
fun! SvnDiffSplit(path,file)
	exe "!svn export -r HEAD ".a:path."/".a:file." ~/tmp/".a:file
	exe "vert diffsplit ~/tmp/".a:file
endfunction

" svn mode
" set svn mode for this window
fun! SvnModeSet(file)
	let w:svnMode = 1
	let w:svnFile = a:file
endfunction
" create new window in svn mode
" uses given file if current window is not already in svn mode
" otherwise, closes current window, creates new, sets svnmode on it and returns svnFile from previous window
fun! SvnModeWindow(file)
	if !SvnMode()
		tabe
		let file = a:file
	else
		let file = w:svnFile
		exe "q!"
		tabe
	endif
	setl buftype=nofile
	call SvnModeSet(l:file)
	return l:file
endfunction
" are we in svnmode?
fun! SvnMode()
	if !exists('w:svnMode') || w:svnMode == 0
		return 0
	endif
	return 1
endfunction
fun! SvnModeError()
	echo "You're not in SVN mode!"
endfunction
" given a revision string ("r1234" or "1234"), displays diff of that revision
fun! SvnModeDiff(rev)
	if SvnMode()
		" extract the rev number from the input
		let matches = matchlist(a:rev,'[^0-9]*\([0-9]*\)[^0-9]*')
		let num = get(l:matches,1)
		let file = SvnModeWindow('')
		exe "r !svn diff -c ".l:num." ".l:file
		setl filetype=diff
	else
		call SvnModeError()
	endif
endfunction
"}}}
"{{{ctags stuff
fun! CtagsFind(file)
	tabe
	exe "tj ".a:file
endfunction
"}}}
"php syntax options {{{
let php_sql_query = 1  "for SQL syntax highlighting inside strings
let php_htmlInStrings = 1  "for HTML syntax highlighting inside strings
"php_baselib = 1  "for highlighting baselib functions
"php_asp_tags = 1  "for highlighting ASP-style short tags
"php_parent_error_close = 1  "for highlighting parent error ] or )
"php_parent_error_open = 1  "for skipping an php end tag, if there exists an open ( or [ without a closing one
"php_oldStyle = 1  "for using old colorstyle
"php_noShortTags = 1  "don't sync <? ?> as php
let php_folding = 1  "for folding classes and functions
" }}}
" netrw {{{
let g:netrw_sort_sequence = '[\/]$,\.php,\.phtml,*,\.info$,\.swp$,\.bak$,\~$'
"}}}
