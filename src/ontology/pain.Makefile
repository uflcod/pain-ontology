## Customize Makefile settings for pain
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# -------------------------------------------
# testing onology with the HermiT reasoner
# -------------------------------------------

test-dl: odkversion sparql_test robot_reports $(REPORTDIR)/validate_profile_owl2dl_$(ONT).owl.txt
	$(ROBOT) reason --input $(SRC) --reasoner HERMIT  --equivalent-classes-allowed asserted-only \
                --exclude-tautologies structural --output $(TMPDIR)/$@.owl &&\
	echo "\n*** DL Test Successful ***\n"

# ----------------------------------------
# ontology imports
# ----------------------------------------

IMPORTS =  omo pato uberon ro omrse go nbo cl emro bfo cob
IMPORT_ROOTS = $(patsubst %, $(IMPORTDIR)/%_import, $(IMPORTS))
IMPORT_OWL_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl)
IMPORT_FILES = $(IMPORT_OWL_FILES)

.PHONY: .FORCE
.PHONY: all_imports
all_imports: $(IMPORT_FILES)

.PHONY: all-imports
all-imports:
#	@echo $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS)) # testing
	$(MAKE) $(patsubst %, $(IMPORTDIR)/%_import.owl, $(IMPORTS))


$(IMPORTDIR)/omo_import.owl: $(MIRRORDIR)/omo.owl
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(ROBOT) \
		filter \
			--input $(lastword $^) \
			--select annotation-properties \
		annotate \
			--annotate-defined-by true \
		merge \
			--include-annotations true \
			--input $(TMPDIR)/omo_onotlogy_annotations.owl \
		annotate \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
		convert \
			--format ofn \
	--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/emro_import.owl: $(MIRRORDIR)/emro.owl  $(IMPORTDIR)/emro_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)

$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl $(IMPORTDIR)/pato_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")

# remove pato:quality in order to avoid confusion with bfo:quality
	$(ROBOT) \
		remove \
			--input $@ \
			--term http://purl.obolibrary.org/obo/PATO_0000001 \
		convert --format ofn \
	--output $@.tmp.owl && mv $@.tmp.owl $@


$(IMPORTDIR)/go_import.owl: $(MIRRORDIR)/go.owl $(IMPORTDIR)/go_terms.txt 
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")

$(IMPORTDIR)/cl_import.owl: $(MIRRORDIR)/cl.owl $(IMPORTDIR)/cl_terms.txt 
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")
		
$(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl $(IMPORTDIR)/uberon_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")

# remove uneeded NCBI Taxon terms
	$(ROBOT) \
		remove \
			--input $@ \
			--select "<http://purl.obolibrary.org/obo/NCBITaxon_*>" \
		convert --format ofn \
	--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/nbo_import.owl: $(MIRRORDIR)/nbo.owl $(IMPORTDIR)/nbo_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")
		
$(IMPORTDIR)/omrse_import.owl: $(MIRRORDIR)/omrse.owl $(IMPORTDIR)/omrse_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")
	
$(IMPORTDIR)/ro_import.owl: $(MIRRORDIR)/ro.owl $(IMPORTDIR)/ro_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self ancestors")

# BD (2026-04-08): IAO not needed for now
# $(IMPORTDIR)/iao_import.owl: $(MIRRORDIR)/iao.owl $(IMPORTDIR)/iao_terms.txt
# 	@echo "\n *** building $@ *** \n"
# 	$(call onotlogy-annotation,$<)
# 	$(call extract-ontology,$@,$<,$(lastword $^),BOT)

$(IMPORTDIR)/bfo_import.owl:  $(MIRRORDIR)/bfo.owl $(IMPORTDIR)/bfo_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)

$(IMPORTDIR)/cob_import.owl:  $(MIRRORDIR)/cob.owl $(IMPORTDIR)/cob_terms.txt
	@echo "\n *** building $@ *** \n"
	$(call onotlogy-annotation,$<)
	$(call extract-ontology,$@,$<,$(lastword $^),BOT)
# 	$(call filter-ontology,$@,$<,$(lastword $^),"annotations self")

# ----------------------------------------
# Release Management
# ----------------------------------------

.PHONY: pain_release
pain_release: prepare_release
	@tmp_release_assets="$(patsubst %, $(RELEASEDIR)/%, $(RELEASE_ASSETS))"; \
	for f in $$tmp_release_assets; do \
		$(call remove-obsolete-class,$$f); \
	done

.PHONY: pain_release_fast
pain_release_fast: 
	$(MAKE) pain_release IMP=false PAT=false MIR=false COMP=false

.PHONY: pain_initial_release
pain_initial_release: prepare_initial_release
	@tmp_release_assets="$(patsubst %, $(RELEASEDIR)/%, $(RELEASE_ASSETS))"; \
	for f in $$tmp_release_assets; do \
		$(call remove-obsolete-class,$$f); \
	done

# ----------------------------------------
# Mirroring upstream ontologies
# ----------------------------------------

# force-mirror-% forces the mirror to updates regardless of whether the source has changed or not
.PHONY: mirror-% force-mirror-%
mirror-% force-mirror-%:
	$(call mirror-ontology,$*,,$(firstword $(subst -, ,$@)))

## EMRO is part of the OBO Foundry (accepted on 2026-06-23). This targent is not needed for the pain ontology. It can use the OBO mirror of EMRO. However, this target is kept here in case the OBO purl.
# .PHONY: mirror-emro force-mirror-emro
# mirror-emro force-mirror-emro: | $(MIRRORDIR)
#	$(call mirror-ontology,emro,https://raw.githubusercontent.com/uflcod/emotion-response-ontology/main,$(firstword $(subst -, ,$@)))

# calling $(MIRRORDIR)/%.owl will not force the mirror to be updated
# need to use the -B option will force the mirror to download but will
# only update the mirror directory if the download and mirror are different
# call force-mirror-% to force the mirrored ontology to update
$(MIRRORDIR)/%.owl: | $(MIRRORDIR)
	$(call mirror-ontology,$*,,)

## EMRO is part of the OBO Foundry (accepted on 2026-06-23). This targent is not needed for the pain ontology. It can use the OBO mirror of EMRO. However, this target is kept here in case the OBO purl.
# $(MIRRORDIR)/emro.owl: | $(MIRRORDIR)
# 	$(call mirror-ontology,emro,https://raw.githubusercontent.com/uflcod/emotion-response-ontology/main,)

.PHONY: all-mirrors
all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS))

.PHONY: force-all-mirrors
force-all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, force-mirror-%, $(IMPORTS))

# ----------------------------------------
# Helper Functions
# ----------------------------------------

#### Import Functions ####

# creates a small ontology file containing only the dcterms:source and prov:wasDerivedFrom
# ontology annotations
# parameters $(1): mirror file
define onotlogy-annotation
	$(ROBOT) \
		annotate \
			--remove-annotations \
			--interpolate true \
			--link-annotation dc:source %{version_iri} \
			--annotation prov:wasDerivedFrom %{ontology_iri} \
			--input $(1) \
		extract --method MIREOT \
			--copy-ontology-annotations true \
			--lower-term "owl:Thing" \
		convert --format ofn \
	--output $(TMPDIR)/$(notdir $(basename $(1)))_onotlogy_annotations.owl
endef

# general function for filtering an ontology
# this is used by many of the imports/%_import.owl targets
# parameters: $(1): target; $(2): mirror file; $(3): term file; $(4): selectors (e.g., "annotations self ancestors")
define filter-ontology
	$(ROBOT) \
		filter \
			--input $(2) \
			--term-file $(3) \
			--exclude-terms $(IMPORTDIR)/exclude_terms.txt \
			--select $(4) \
			--axioms all \
			--signature true \
			--trim true \
		annotate \
			--annotate-defined-by true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		merge \
			--include-annotations true \
			--input $(TMPDIR)/$(notdir $(basename $(2)))_onotlogy_annotations.owl \
		annotate \
			--ontology-iri $(URIBASE)/$(ONT)/$(1) \
		convert \
			--format ofn \
	--output $(1).tmp.owl && mv $(1).tmp.owl $(1)
endef

# general function for extracting terms from an ontology
# the extract method is parameter $(4), but this won't work with MIREOT
# this is used by many of the imports/%_import.owl targets
# note: the ontology is filtered after the extract
# parameters: $(1): target; $(2): mirror file; $(3): term file; $(4): extract method
define extract-ontology
	$(ROBOT) \
		extract --method $(4) \
			--input $(2) \
			--term-file $(3) \
		annotate \
			--annotate-defined-by true \
		filter \
			--term-file $(3) \
			--select "annotations self ancestors" \
			--axioms all \
			--signature true \
			--trim true \
		merge \
			--include-annotations true \
			--input $(TMPDIR)/$(notdir $(basename $(2)))_onotlogy_annotations.owl \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
			--term-file imports/exclude_terms.txt \
			--axioms all \
		annotate \
			--ontology-iri $(URIBASE)/$(ONT)/$(1) \
		convert \
			--format ofn \
	--output $(1).tmp.owl

	$(ROBOT) \
		remove \
			--input $(1).tmp.owl \
			--term-file $(IMPORTDIR)/exclude_terms.txt \
			--axioms all \
		convert --format ofn \
	--output $(1) && rm $(1).tmp.owl
endef

#### Release Functions ####

define remove-obsolete-class
	echo "\n removing ObsoleteClass from $(1) ($$(basename $(1))) \n"; \
	$(ROBOT) \
		remove \
			--input $(1) \
			--term http://www.geneontology.org/formats/oboInOwl#ObsoleteClass \
			--select "self descendants" \
			--signature true \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
	--output $(TMPDIR)/$$(basename $(1)) && mv $(TMPDIR)/$$(basename $(1)) $(1)
endef

#### Mirror Functions ####

# This is a general function for mirroring an ontology. It checks if the mirror needs to be updated by comparing the downloaded 
# file with the existing mirror file. If they are different or if force update is requested, it updates the mirror. 
# Otherwise, it ignores the update.
# $(1) is the name of the ontology to mirror, 
# $(2) is an optional base URL to download from (defaults to $(URIBASE)), 
# and $(3) is a flag to force update regardless of whether the source has changed or not.
define mirror-ontology
	@if [ "$(strip $(MIR))" = "true" ] && \
			[ "$(strip $(IMP))" = "true" ] && \
			[ "$(strip $(IMP_LARGE))" = "true" ]; then \
		echo "*** mirroring $(1) ***"; \
		download_url_base=$(if $(strip $(2)),$(2),$(URIBASE)); \
		echo "url: $$download_url_base/$(1).owl"; \
			\
		curl -L $$download_url_base/$(strip $(1)).owl \
			--create-dirs -o $(TMPDIR)/$(strip $(1)).temp.owl --retry 4 --max-time 200; \
		\
		if [ ! -f "$(MIRRORDIR)/$(strip $(1)).owl" ]; then \
			echo "touch $(MIRRORDIR)/$(strip $(1)).owl " && \
			touch $(MIRRORDIR)/$(strip $(1)).owl; \
		fi; \
		\
		if [ "$(strip $(3))" = "force" ] || \
			! cmp -s $(TMPDIR)/$(strip $(1)).temp.owl $(MIRRORDIR)/$(strip $(1)).owl ; then \
			echo "Mirrors different or update is forced, !!! UPDATING !!!.\n" && \
			$(ROBOT) convert \
			--input $(TMPDIR)/$(strip $(1)).temp.owl \
			--output $(TMPDIR)/$(strip $(1)).owl && \
			cp $(TMPDIR)/$(strip $(1)).temp.owl $(MIRRORDIR)/$(strip $(1)).owl; \
		else \
			echo "Mirrors identical, !!! IGNORING !!!."; \
		fi; \
		rm -f $(TMPDIR)/$(strip $(1)).temp.owl; \
	fi
endef