# Makefile for Sphinx documentation
#

WWW_DIR = build/html/
WWW_UPLOAD_URI=kumo.ovgu.de:/var/www/medusa/www/


# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = PYTHONPATH=utils:sphinxext:$$PYTHONPATH sphinx-build
PAPER         =
BUILDDIR      = build

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
ALLSPHINXOPTS_internal   = -d $(BUILDDIR)/doctrees/internal $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source/internal
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = -d $(BUILDDIR)/locale/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
I18NSPHINXOPTS_internal  = -d $(BUILDDIR)/locale/doctrees_internal $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source/internal

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

all: html

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

clean: cleanmo
	-rm -rf $(BUILDDIR)/*

html: html-en

html-%:
	$(SPHINXBUILD) -b html -Dlanguage=$* $(ALLSPHINXOPTS) $(BUILDDIR)/html
	$(SPHINXBUILD) -b html -Dlanguage=$* $(ALLSPHINXOPTS_internal) $(BUILDDIR)/html/internal
	@echo
	@echo "Build [$*] finished. The HTML pages are in $(BUILDDIR)/html."

html2lang-%:
	find $(BUILDDIR)/html -type f -name '*.html' -exec mv \{\} \{\}.$* \;

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

gettext:
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) source/i18n
	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS_internal) source/internal/i18n
	@echo
	@echo "Build finished."

mo:
	for po in $$(find source -type f -name '*.po'); do \
		msgfmt $${po} -o $${po%*.po}.mo ; \
	done

cleanmo:
	find source -type f -name '*.mo' -delete

updatepo: gettext
	for pot in $$(find source -type f -name '*.pot'); do \
		dname=$$(dirname $$pot) ; \
		fname=$$(basename $$pot) ; \
		for po in $$(find $$dname -type f -name $${fname%*t}); do \
			msgmerge --update --backup=none $$po $$pot ; \
		done ; \
	done

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

website: updatepo mo html-de html2lang-de html-en html2lang-en
upload-website: website
	rsync -rvzlhp --delete \
        --exclude=_files --exclude=publications --chmod=Dg+s,g+rw \
        $(WWW_DIR) $(WWW_UPLOAD_URI)

