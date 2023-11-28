## Customize Makefile settings for pain
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# ontology imports
# ----------------------------------------

IMPORTS =  omo mfoem pato uberon ro iao omrse go

IMPORT_ROOTS = $(patsubst %, $(IMPORTDIR)/%_import, $(IMPORTS))
IMPORT_OWL_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl)
IMPORT_FILES = $(IMPORT_OWL_FILES)

.PHONY: all_imports
all_imports: $(IMPORT_FILES)

.PHONY: all-imports
all-imports:
#	@echo $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS))
#	make  imports/omo_import.owl

$(IMPORTDIR)/omo_import.owl: $(MIRRORDIR)/omo.owl
	@echo "*** building $@ ***"
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

$(IMPORTDIR)/mfoem_import.owl: $(MIRRORDIR)/mfoem.owl $(IMPORTDIR)/mfoem_terms.txt 
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/go_import.owl: $(MIRRORDIR)/go.owl $(IMPORTDIR)/go_terms.txt 
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@
		
$(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl $(IMPORTDIR)/uberon_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		remove \
			--select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl $(IMPORTDIR)/pato_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/omrse_import.owl: $(MIRRORDIR)/omrse.owl $(IMPORTDIR)/omrse_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/ro_import.owl: $(MIRRORDIR)/ro.owl $(IMPORTDIR)/ro_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/iao_import.owl: $(MIRRORDIR)/iao.owl $(IMPORTDIR)/iao_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		filter \
			--input $< \
			--term-file $(word 2, $^) \
			--select "annotations self ancestors" \
			--axioms logical \
			--signature true \
			--trim true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		annotate \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
			--version-iri $(URIBASE)/$(ONT)/$@ \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

# ----------------------------------------
# Mirroring upstream ontologies
# ----------------------------------------

.PHONY: all-mirrors
all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS))

download-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS))

$(MIRRORDIR)/%.owl: mirror-% | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ] && [ -f $(TMPDIR)/mirror-$*.owl ]; then if cmp -s $(TMPDIR)/mirror-$*.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." &&\
		cp $(TMPDIR)/mirror-$*.owl $@; fi; fi

.PHONY: mirror-%
mirror-%: | $(TMPDIR)
	@echo "*** mirroring $* ***"
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then \
		curl -L $(URIBASE)/$*.owl \
			--create-dirs -o $(MIRRORDIR)/$(notdir $*).temp.owl --retry 4 --max-time 200 && \
		$(ROBOT) convert \
			--input $(MIRRORDIR)/$(notdir $*).temp.owl \
			--output $(MIRRORDIR)/$(notdir $*).owl && \
		rm  $(MIRRORDIR)/$*.temp.owl; fi