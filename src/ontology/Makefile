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

# ===== ontology mirrors ===== #
$(MIRRORDIR)/uberon.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/uberon.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@

$(MIRRORDIR)/cob.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/cob.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@

 $(MIRRORDIR)/mfoem.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/mfoem.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@

$(MIRRORDIR)/omo.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/omo.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@

# ===== ontology imports ===== #
$(IMPORTDIR)/omo: $(MIRRORDIR)/omo.owl
	$(ROBOT) \
	  annotate \
	    --input $< \
        --annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/omo_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/cob: $(MIRRORDIR)/cob.owl
	$(ROBOT) \
	  annotate \
	    --input $< \
        --annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/cob_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/mfoem: $(MIRRORDIR)/mfoem.owl
	$(ROBOT) \
	  extract \
	    --method MIREOT \
	    --input $< \
		--upper-term OGMS:0000060 \
	    --lower-term MFOEM:000203 \
		--lower-term GO:0048266 \
	  annotate \
	  	--annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/mfoem_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/uberon: $(MIRRORDIR)/uberon.owl
	$(ROBOT) \
	  extract \
	    --method STAR \
	    --input $< \
	    --term-file $@_terms.txt \
	    --individuals exclude \
	  remove \
	    --select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
	  annotate \
	  	--annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/uberon_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl