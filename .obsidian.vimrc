" navigate visual lines rather than logical ones
nnoremap j gj
nnoremap k gk

" Clipboard
" yank to system clipboard
set clipboard=unnamed

" [z]pelling [l]ist (emulates `z=`)
exmap contextMenu obcommand editor:context-menu
nnoremap zl :contextMenu

" <Esc> clears highlights
nnoremap <Esc> :nohl

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki<CR>
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>

" Big J/K jumps multiple lines (compared to their smaller siblings j/k)
" To be able to remap keys, they need to be unmapped first
nunmap J
nmap J 15jzz 
nunmap K
nmap K 15kzz 

" H and L for beginning/end of line (big variants of h & l)
nmap H ^
nmap L $
