# ----------------------------------------
# Subset assets
# ----------------------------------------


SUBSETS = icop

SUBSET_ROOTS = $(patsubst %, $(SUBSETDIR)/%, $(SUBSETS))
SUBSET_FILES = $(foreach n,$(SUBSET_ROOTS), $(foreach f,$(FORMATS_INCL_TSV), $(n).$(f)))

.PHONY: all_subsets
all_subsets: $(SUBSET_FILES)

# ----------------------------------------
# Subsets
# ----------------------------------------

$(SUBSETDIR)/icop.owl: $(ONT).owl $(SPARQLDIR)/icop-subset.rq $(SUBSETDIR)/icop-annotations.owl | $(SUBSETDIR)
	@echo "\n** building $@ **"
	$(ROBOT) query -i $< -q $(word 2, $^) $@.tmp.csv &&\
	tail -n +2 $@.tmp.csv > $@.tmp.txt &&\
	rm $@.tmp.csv &&\
	$(ROBOT) extract --method STAR \
			--input $< \
			--term-file $@.tmp.txt \
		--output $@.tmp.owl &&\
	$(ROBOT) merge \
			--include-annotations true \
			--input $(word 3, $^) \
			--input  $@.tmp.owl \
		annotate \
			--ontology-iri $(URIBASE)/$(ONT)/$(notdir $@) \
			--version-iri $(URIBASE)/$(ONT)/releases/$(VERSION)/$(notdir $@) \
			--annotation owl:versionInfo $(VERSION) \
		--output $@ &&\
	rm $@.tmp.owl
.PRECIOUS: $(SUBSETDIR)/icop.owl

