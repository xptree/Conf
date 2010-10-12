if exists("b:current_syntax")
	finish
endif

syn match listFilePriOne '^\s*1 [^\[\]]*'
syn match listFilePriTwo '^\s*2 [^\[\]]*'
syn match listFilePriRest '^\s*[3-9] [^\[\]]*'
syn match listFileNonStart '^\s*- [^\[\]]*'
syn match listFileProg '^\s*= [^\[\]]*'
syn match listFileUnk '^\s*o [^\[\]]*'
syn match listFileDone '^\s*x [^\[\]]*'
syn match listFileDate '\[[^\]]\+\]$'

let b:current_syntax = "listfile"

hi def listFileNonStart ctermfg=NONE cterm=bold
hi def listFilePriOne ctermfg=1 cterm=bold
hi def listFilePriTwo ctermfg=3
hi def listFilePriRest ctermfg=3 cterm=bold
hi def listFileProg ctermfg=2 cterm=bold
hi def listFileUnk ctermfg=4 cterm=bold
hi def listFileDone ctermfg=4 cterm=NONE
hi def listFileDate ctermfg=4 cterm=NONE