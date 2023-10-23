## Customize Makefile settings for pain
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# ontology imports
# ----------------------------------------

IMPORTS =  omo cob mfoem pato uberon

IMPORT_ROOTS = $(patsubst %, $(IMPORTDIR)/%_import, $(IMPORTS))
IMPORT_OWL_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl)
IMPORT_FILES = $(IMPORT_OWL_FILES)

.PHONY: all-imports
all-imports:
#	@echo $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS))
#	make  imports/omo_import.owl

$(IMPORTDIR)/omo_import.owl: $(MIRRORDIR)/omo.owl.gz
	$(ROBOT) \
	  remove \
		--input $< \
		--select "owl:deprecated='true'^^xsd:boolean" \
	  remove \
		--select classes \
	  annotate \
		--annotate-defined-by true \
		--ontology-iri $(URIBASE)/$(ONT)/$@ \
		--version-iri $(URIBASE)/$(ONT)/$@ \
	convert --format ofn \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/cob_import.owl: $(MIRRORDIR)/cob.owl.gz
	$(ROBOT) \
	  remove \
		--input $< \
		--select "owl:deprecated='true'^^xsd:boolean" \
	  annotate \
		--annotate-defined-by true \
		--ontology-iri $(URIBASE)/$(ONT)/$@ \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/mfoem_import.owl: $(MIRRORDIR)/mfoem.owl.gz
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
		--ontology-iri $(URIBASE)/$(ONT)/$@ \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl.gz
	$(ROBOT) \
	  extract \
		--input $< \
		--method MIREOT \
		--upper-term BFO:0000015 \
		--lower-term GO:0019233 \
		--lower-term RO:0002411 \
		--individuals exclude \
	  remove \
		--select "owl:deprecated='true'^^xsd:boolean" \
	  remove \
		--select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
	  annotate \
	  	--annotate-defined-by true \
		--ontology-iri $(URIBASE)/$(ONT)/$@ \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl.gz
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
		--ontology-iri $(URIBASE)/$(ONT)/$@ \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

# ----------------------------------------
# Mirroring upstream ontologies
# ----------------------------------------

.PHONY: all-mirrors
all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl.gz, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl.gz, $(IMPORTS))

download-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS))

# --- gzip ontology mirrors ---

$(MIRRORDIR)/omo.owl.gz:
	gzip -fk $(MIRRORDIR)/omo.owl

$(MIRRORDIR)/cob.owl.gz: 
	gzip -fk $(MIRRORDIR)/cob.owl

$(MIRRORDIR)/mfoem.owl.gz: 
	gzip -fk $(MIRRORDIR)/mfoem.owl

$(MIRRORDIR)/pato.owl.gz: 
	gzip -fk $(MIRRORDIR)/pato.owl

$(MIRRORDIR)/uberon.owl.gz: 
	gzip -fk $(MIRRORDIR)/uberon.owl

## ONTOLOGY: omo
.PHONY: mirror-omo
.PRECIOUS: $(MIRRORDIR)/omo.owl
mirror-omo: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(URIBASE)/omo.owl --create-dirs -o $(MIRRORDIR)/omo.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/omo.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: cob
.PHONY: mirror-cob
.PRECIOUS: $(MIRRORDIR)/cob.owl
mirror-cob: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(URIBASE)/cob.owl --create-dirs -o $(MIRRORDIR)/cob.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/cob.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: mfoem
.PHONY: mirror-mfoem
.PRECIOUS: $(MIRRORDIR)/mfoem.owl
mirror-mfoem: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(URIBASE)/mfoem.owl --create-dirs -o $(MIRRORDIR)/mfoem.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/mfoem.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: pato
.PHONY: mirror-pato
.PRECIOUS: $(MIRRORDIR)/pato.owl
mirror-pato: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then curl -L $(URIBASE)/pato.owl --create-dirs -o $(MIRRORDIR)/pato.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/pato.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: uberon
.PHONY: mirror-uberon
.PRECIOUS: $(MIRRORDIR)/uberon.owl
mirror-uberon: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then curl -L $(URIBASE)/uberon.owl --create-dirs -o $(MIRRORDIR)/uberon.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/uberon.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


$(MIRRORDIR)/%.owl: mirror-% | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ] && [ -f $(TMPDIR)/mirror-$*.owl ]; then if cmp -s $(TMPDIR)/mirror-$*.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." &&\
		cp $(TMPDIR)/mirror-$*.owl $@; fi; fi