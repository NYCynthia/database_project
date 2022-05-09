let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Tutoring/cynthia_l
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd meetapp
set stal=2
tabnew
tabnew
tabrewind
edit ~/Tutoring/cynthia_l/meetapp/app/routes.py
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 77 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 90 + 84) / 168)
argglobal
balt ~/Tutoring/cynthia_l/meetapp/app/routes.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 165 - ((13 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 165
normal! 060|
lcd ~/Tutoring/michael_b/scl/track/templates/track
wincmd w
argglobal
if bufexists("~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html") | buffer ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html | else | edit ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html | endif
if &buftype ==# 'terminal'
  silent file ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html
endif
balt ~/Tutoring/cynthia_l/meetapp/app/templates/view_club.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 19 - ((18 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 0153|
lcd ~/Tutoring/cynthia_l
wincmd w
exe 'vert 1resize ' . ((&columns * 77 + 84) / 168)
exe 'vert 2resize ' . ((&columns * 90 + 84) / 168)
tabnext
edit ~/Tutoring/cynthia_l/meetapp/app/routes.py
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe '2resize ' . ((&lines * 16 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
exe '3resize ' . ((&lines * 20 + 20) / 40)
exe 'vert 3resize ' . ((&columns * 84 + 84) / 168)
argglobal
balt ~/Tutoring/cynthia_l/meetapp/app/forms.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 135 - ((14 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 135
normal! 022|
lcd ~/Tutoring/cynthia_l
wincmd w
argglobal
if bufexists("~/Tutoring/cynthia_l/meetapp/app/forms.py") | buffer ~/Tutoring/cynthia_l/meetapp/app/forms.py | else | edit ~/Tutoring/cynthia_l/meetapp/app/forms.py | endif
if &buftype ==# 'terminal'
  silent file ~/Tutoring/cynthia_l/meetapp/app/forms.py
endif
balt ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 31 - ((2 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 018|
lcd ~/Tutoring/cynthia_l
wincmd w
argglobal
if bufexists("~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql") | buffer ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql | else | edit ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql | endif
if &buftype ==# 'terminal'
  silent file ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql
endif
balt ~/Tutoring/cynthia_l/meetapp/app/forms.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 73 - ((10 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 73
normal! 0
lcd ~/Tutoring/cynthia_l
wincmd w
exe 'vert 1resize ' . ((&columns * 83 + 84) / 168)
exe '2resize ' . ((&lines * 16 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 84 + 84) / 168)
exe '3resize ' . ((&lines * 20 + 20) / 40)
exe 'vert 3resize ' . ((&columns * 84 + 84) / 168)
tabnext
edit ~/Tutoring/cynthia_l/meetapp/app/routes.py
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 85 + 84) / 168)
exe '2resize ' . ((&lines * 24 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 82 + 84) / 168)
exe '3resize ' . ((&lines * 12 + 20) / 40)
exe 'vert 3resize ' . ((&columns * 82 + 84) / 168)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 218 - ((22 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 218
normal! 0211|
lcd ~/Tutoring/cynthia_l
wincmd w
argglobal
if bufexists("~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html") | buffer ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html | else | edit ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html | endif
if &buftype ==# 'terminal'
  silent file ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html
endif
balt ~/Tutoring/cynthia_l/meetapp/app/routes.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 34 - ((6 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 34
normal! 0
lcd ~/Tutoring/cynthia_l
wincmd w
argglobal
if bufexists("~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql") | buffer ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql | else | edit ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql | endif
if &buftype ==# 'terminal'
  silent file ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql
endif
balt ~/Tutoring/cynthia_l/meetapp/app/routes.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 116 - ((4 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 116
normal! 026|
lcd ~/Tutoring/cynthia_l
wincmd w
exe 'vert 1resize ' . ((&columns * 85 + 84) / 168)
exe '2resize ' . ((&lines * 24 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 82 + 84) / 168)
exe '3resize ' . ((&lines * 12 + 20) / 40)
exe 'vert 3resize ' . ((&columns * 82 + 84) / 168)
tabnext 1
set stal=1
badd +1 ~/Tutoring/cynthia_l/meetapp/app/routes.py
badd +1 ~/Tutoring/cynthia_l/meetapp
badd +1 ~/Tutoring/cynthia_l/meetapp/app/templates/view_event.html
badd +7 ~/Tutoring/cynthia_l/meetapp/app/templates/create_user.html
badd +30 ~/Tutoring/cynthia_l/meetapp/app/forms.py
badd +33 ~/Tutoring/cynthia_l/meetapp/ddl_meetapp.sql
badd +33 ~/Tutoring/cynthia_l/meetapp/app/templates/view_club.html
badd +9 ~/Tutoring/cynthia_l/meetapp/app/templates/create_event.html
badd +1 ~/Tutoring/cynthia_l/meetapp/app/templates/create_club.html
badd +57 ~/Tutoring/michael_b/scl/track/templates/track/business_detail.html
badd +18 ~/Tutoring/cynthia_l/meetapp/app/templates/base.html
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
