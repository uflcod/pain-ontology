## Customize Makefile settings for pain
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# ontology imports
# ----------------------------------------

ANNOTATE_IMPORT_FILE = \
	annotate \
		--remove-annotations \
		--interpolate true \
		--link-annotation dc:source %{ontology_iri} \
		--annotate-defined-by true \
		--ontology-iri $(URIBASE)/$(ONT)/$@ 
# 		--version-iri $(URIBASE)/$(ONT)/$@ 

IMPORTS =  omo mfoem pato uberon ro iao omrse go nbo cl emro

IMPORT_ROOTS = $(patsubst %, $(IMPORTDIR)/%_import, $(IMPORTS))
IMPORT_OWL_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl)
IMPORT_FILES = $(IMPORT_OWL_FILES)

.PHONY: .FORCE
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
	 $(ANNOTATE_IMPORT_FILE) \
	 convert --format ofn \
	  --output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/emro_import.owl: $(MIRRORDIR)/emro.owl  $(IMPORTDIR)/emro_terms.txt
	@echo "*** building $@ ***"
	$(ROBOT) \
		extract --method BOT \
			--input $< \
			--term-file $(word 2, $^) \
		annotate \
			--remove-annotations \
			--interpolate true \
			--annotation rdfs:comment "Derived from %{ontology_iri}" \
			--annotate-defined-by true \
			--ontology-iri $(URIBASE)/$(ONT)/$@ \
		remove \
			--select "owl:deprecated='true'^^xsd:boolean" \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

# 		--link-annotation dc:source %{version_iri} \

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
		$(ANNOTATE_IMPORT_FILE) \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/cl_import.owl: $(MIRRORDIR)/cl.owl $(IMPORTDIR)/cl_terms.txt 
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(IMPORTDIR)/nbo_import.owl: $(MIRRORDIR)/nbo.owl $(IMPORTDIR)/nbo_terms.txt
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
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
		$(ANNOTATE_IMPORT_FILE) \
		convert --format ofn \
		--output $@.tmp.owl && mv $@.tmp.owl $@
# ----------------------------------------
# Mirroring upstream ontologies
# ----------------------------------------

# This is a general rule for mirroring an ontology. It checks if the mirror needs to be updated by comparing the downloaded 
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


# force-mirror-% forces the mirror to updates regardless of whether the source has changed or not
.PHONY: mirror-% force-mirror-%
mirror-% force-mirror-%:
	$(call mirror-ontology,$*,,$(firstword $(subst -, ,$@)))

.PHONY: mirror-emro force-mirror-emro
mirror-emro force-mirror-emro: | $(MIRRORDIR)
	$(call mirror-ontology,emro,https://raw.githubusercontent.com/uflcod/emotion-response-ontology/main,$(firstword $(subst -, ,$@)))

# calling $(MIRRORDIR)/%.owl will not force the mirror to be updated
# need to use the -B option will force the mirror to download but will
# only update the mirror directory if the download and mirror are different
# call force-mirror-% to force the mirrored ontology to update
$(MIRRORDIR)/%.owl: | $(MIRRORDIR)
	$(call mirror-ontology,$*,,)

$(MIRRORDIR)/emro.owl: | $(MIRRORDIR)
	$(call mirror-ontology,emro,https://raw.githubusercontent.com/uflcod/emotion-response-ontology/main,)

.PHONY: all-mirrors
all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS))

.PHONY: all-mirrors-force
force-all-mirrors:
#	@echo $(patsubst %, $(MIRRORDIR)/%.owl, $(IMPORTS)) # testing
	make $(patsubst %, force-mirror-%, $(IMPORTS))