URIBASE=                    http://purl.obolibrary.org/obo
ONT=                        pain
ONTBASE=                    $(URIBASE)/$(ONT)
EDIT_FORMAT=                owl
SRC=						$(ONT)-edit.$(EDIT_FORMAT)
RELEASEDIR=                 ../..
MIRRORDIR=                  mirror
IMPORTDIR=                  imports
SUBSETDIR=                  subsets
CATALOG=                    catalog-v001.xml
ROBOT=                      robot --catalog $(CATALOG)
RELEASEDIR=                 ../..
TODAY ?=                    $(shell date +%Y-%m-%d)
VERSION=                    $(TODAY)
RELEASE_ARTEFACTS=			$(ONT).owl

all: $(RELEASE_ARTEFACTS)

release: $(RELEASE_ARTEFACTS)
	@echo "\n** releasing $^ **"
	cp $^ $(RELEASEDIR)

clean:
	rm -f $(RELEASE_ARTEFACTS)

$(ONT).owl: $(SRC)
	@echo "\n** building $@ **"
	$(ROBOT) \
		merge -i $< \
		reason --reasoner hermit \
		annotate \
			--ontology-iri $(URIBASE)/$@ \
			--version-iri $(ONTBASE)/releases/$(VERSION)/$@ \
			--annotation owl:versionInfo $(VERSION) \
		reduce \
		convert -o $@.tmp.owl && mv $@.tmp.owl $@

$(MIRRORDIR)/uberon.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/uberon.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@


$(IMPORTDIR)/uberon: $(MIRRORDIR)/uberon.owl
	$(ROBOT) \
	  extract \
	  --method STAR \
	  --input $< \
	  --term-file $@_terms.txt \
	  --annotate-with-source true \
	  --individuals exclude \
	  remove \
	    --select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
	  annotate \
	    --ontology-iri $(URIBASE)/$(ONT)/uberon_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl