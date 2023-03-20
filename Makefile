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

cedict.sort.txt: cedict.dict.txt sortdict.pl
	$(PUSH)

install: ~/Dropbox/7054/dict.txt ~/.cvimrc ~/.ecvimrc

~/Dropbox/7054/dict.txt: | cedict.sort.txt ~/Dropbox/7054
	$(CP) cedict.sort.txt $@

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
