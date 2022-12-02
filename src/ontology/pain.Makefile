## Customize Makefile settings for pain
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


# =========================
# ontology imports
# =========================

.PHONY: update-%
update-%:
#	@echo $(IMPORTDIR)/$* # testing
	make $(IMPORTDIR)/$*

.PHONY: all-imports
all-imports:
#	@echo $(patsubst %, $(IMPORTDIR)/%, $(IMPORTS)) # testing
	make $(patsubst %, $(IMPORTDIR)/%, $(IMPORTS))

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
		--lower-term RO:0002411 \
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

# =========================
# ontology mirrors
# =========================

.PHONY: all-mirrors
all-mirrors:
#	@echo $(patsubst %, mirror-%, $(IMPORTS)) # testing
	make $(patsubst %, mirror-%, $(IMPORTS))