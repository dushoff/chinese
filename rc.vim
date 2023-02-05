source ~/.gcvimrc

write
edit ~/Dropbox/7054/dict.txt
edit #

" mm comes after search to remember line position
" nmap X *Nmm<C-^>1Gn
nmap X *Nmm<C-^>1Gq/<C-Up>:try\|s/9/[75048]/g\|catch\|endtry<C-M><C-M>
nmap Y 1Gq/<C-Up>:s/[750489]/[75048]/g<C-M><C-M>
nmap D 0"cy$<C-^>`mve"cp
nmap E 0"cyt<C-I><C-^>`mve"cp
nmap Z XE
nmap F 0f<TAB>l*Ndd1GnP

imap Z <ESC>Za
imap X <ESC>X
ino !Z Z
ino !X Xa

