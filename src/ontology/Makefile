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

# =========================
# ontology products
# =========================

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

# =========================
# ontology mirrors 
# =========================
MIRRORS = omo cob mfoem uberon pato
MIRROR_TARGETS = $(patsubst %,  $(MIRRORDIR)/%.owl, $(MIRRORS))

.PHONY: refresh-all-mirrors
refresh-all-mirrors:
	make -B $(MIRROR_TARGETS)

.PHONY: refresh-mirror-%
refresh-mirror-%:
	make -B $(MIRRORDIR)/$*.owl

.PHONY: all-mirrors
all-mirrors: $(MIRROR_TARGETS)

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

$(MIRRORDIR)/pato.owl:
	 $(ROBOT) \
	   convert -I http://purl.obolibrary.org/obo/pato.owl \
	   -o  $@.tmp.owl && mv $@.tmp.owl $@

# =========================
# ontology imports
# =========================
IMPORTS = omo cob mfoem uberon pato
IMPORT_TARGETS = $(patsubst %,  $(IMPORTDIR)/%, $(IMPORTS))
IMPORT_FILES = $(foreach n,$(IMPORT_TARGETS), $(n).owl)

.PHONY: refresh-all-imports
refresh-all-imports:
	make $(IMPORT_TARGETS)

.PHONY: refresh-import-%
refresh-import-%:
	make $(IMPORTDIR)/$*

.PHONY: all-imports
all-imports:
	make $(IMPORT_TARGETS)

$(IMPORTDIR)/omo: $(MIRRORDIR)/omo.owl
	$(ROBOT) \
	  remove \
	    --input $< \
	    --select "owl:deprecated='true'^^xsd:boolean" \
	  remove \
		--select classes \
	  annotate \
        --annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/$@_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/cob: $(MIRRORDIR)/cob.owl
	$(ROBOT) \
	  remove \
	    --input $< \
	    --select "owl:deprecated='true'^^xsd:boolean" \
	  annotate \
        --annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/$@_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/mfoem: $(MIRRORDIR)/mfoem.owl
	$(ROBOT) \
	  extract \
	    --input $< \
	    --method MIREOT \
		--upper-term OGMS:0000060 \
	    --lower-term MFOEM:000203 \
		--lower-term GO:0048266 \
	 remove \
	    --select "owl:deprecated='true'^^xsd:boolean" \
	  annotate \
	  	--annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/$@_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/uberon: $(MIRRORDIR)/uberon.owl
	$(ROBOT) \
	  extract \
	    --input $< \
	    --method MIREOT \
	    --upper-term BFO:0000015 \
		--lower-term GO:0019233 \
	    --individuals exclude \
	  remove \
	    --select "owl:deprecated='true'^^xsd:boolean" \
	  remove \
		--select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
	  annotate \
	  	--annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/$@_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl

$(IMPORTDIR)/pato: $(MIRRORDIR)/pato.owl
	$(ROBOT) \
	  remove \
	    --input $< \
	    --select "owl:deprecated='true'^^xsd:boolean" \
	  extract \
	    --method MIREOT \
		--upper-term PATO:0000001 \
		--lower-term PATO:0002387 \
	    --lower-term PATO:0002414 \
	  annotate \
	  	--annotate-defined-by true \
	    --ontology-iri $(URIBASE)/$(ONT)/$@_import.owl \
	  --output $@.tmp.owl && mv $@.tmp.owl $@_import.owl