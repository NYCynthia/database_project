let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +8 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/__init__.py
badd +68 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py
badd +25 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/index.html
badd +20 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/forms.py
badd +6 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/login.html
badd +13 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/base.html
badd +1 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/meetapp.py
badd +1 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/ddl_meetapp.sql
badd +6 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/create_club.html
badd +33 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/models.py
badd +3 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/config.py
badd +9 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/create_user.html
badd +1 ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/dashboard.html
argglobal
%argdel
$argadd ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/__init__.py
$argadd ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/__pycache__
$argadd ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py
edit ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 100 + 100) / 201)
exe 'vert 2resize ' . ((&columns * 100 + 100) / 201)
argglobal
if bufexists("~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py") | buffer ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py | else | edit ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/routes.py | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 68 - ((41 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
68
normal! 053|
wincmd w
argglobal
if bufexists("~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/view_club.html") | buffer ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/view_club.html | else | edit ~/Desktop/NYU\ Cyberfellow/Database\ Systems/meetapp/app/templates/view_club.html | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 4 - ((3 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 100 + 100) / 201)
exe 'vert 2resize ' . ((&columns * 100 + 100) / 201)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
