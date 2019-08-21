" Source the main file, then override the 50 char highlighting crap
source $VIMRUNTIME/syntax/gitcommit.vim
syn match   gitcommitSummary	"^.*" contained containedin=gitcommitFirstLine contains=@Spell
