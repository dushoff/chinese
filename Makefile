## This is chinese

current: target
-include target.mk
Ignore = target.mk

-include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

## Current cedict files
## https://www.mdbg.net/chinese/dictionary?page=cc-cedict

Ignore += cedict.*
cedict.tgz:
	wget -O $@ "https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz"

cedict.tar: cedict.tgz
	gunzip $<

cedict.txt: cedict.tar
	$(ln)

## Place short into pipeline for debugging
cedict.short.txt: cedict.txt
	cat $< | head -20000 | tail -1000 > $@

Sources += $(wildcard *.pl) 

## This matches the keyword "Taiwan pr." and does something smart
## "also pr." follows the same logic, but was not processed last time
## cedict.taiwan.txt: cedict.short.txt taiwan.pl
cedict.taiwan.txt: cedict.txt taiwan.pl
	$(PUSH)

cedict.dict.txt: cedict.taiwan.txt dict.pl
	$(PUSH)

## You can look at this file through edit if you have concerns about the main file below
cedict.sort.txt: cedict.dict.txt sortdict.pl
	$(PUSH)

install: ~/.cvimrc ~/.ecvimrc
dropInstall: ~/Dropbox/7054/dict.txt

## Avoid remaking dict.txt. Don't edit the cedict, that's automatic
## Hopefully will never need to update, but if so we will want to automatically compare old and new cedict files
~/Dropbox/7054/dict.txt: | cedict.sort.txt ~/Dropbox/7054
	$(CP) cedict.sort.txt $@

## F2 does not work for targets with ~
~/Dropbox/7054:
	cd ~/Dropbox && mkdir 7054

Sources += rc.vim ec.vim
~/.cvimrc: rc.vim
	$(linkelsewhere)

~/.ecvimrc: ec.vim
	$(linkelsewhere)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

## -include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
