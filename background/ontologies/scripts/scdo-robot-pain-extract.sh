# create local mirror
robot merge \
  --input-iri http://purl.obolibrary.org/obo/scdo.owl \
  --output temp-mirror.owl

# run STAR extract for term in order to get axioms
robot extract --method STAR \
  --input temp-mirror.owl \
  --term http://purl.obolibrary.org/obo/SCDO_0000851 \
  --output temp-star-pain.owl

# get hierarchy and children for term
robot extract --method MIREOT \
  --input temp-mirror.owl \
  --lower-term http://purl.obolibrary.org/obo/SCDO_0000851 \
  --branch-from-term http://purl.obolibrary.org/obo/SCDO_0000851 \
  --output temp-mireot.owl
 
# merge STAR and MIREOT extracted ontologies
robot merge \
  --input temp-star-pain.owl \
  --input temp-mireot.owl \
  reduce --output ../owl/scdo-pain.owl
