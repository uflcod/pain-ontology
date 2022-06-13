# create local mirror
robot merge \
  --input-iri http://purl.obolibrary.org/obo/ncit.owl \
  --output temp-mirror.owl
  
# run STAR extract for term in order to get axioms
robot extract --method STAR \
  --input temp-mirror.owl \
  --term http://purl.obolibrary.org/obo/NCIT_C3303 \
  --term http://purl.obolibrary.org/obo/NCIT_C143725 \
  --output temp-star-pain.owl

# get hierarchy and children for term
robot extract --method MIREOT \
  --input temp-mirror.owl \
  --lower-term http://purl.obolibrary.org/obo/NCIT_C3303 \
  --lower-term http://purl.obolibrary.org/obo/NCIT_C143725 \
  --branch-from-term http://purl.obolibrary.org/obo/NCIT_C3303 \
  --branch-from-term http://purl.obolibrary.org/obo/NCIT_C143725 \
  --output temp-mireot.owl
 
 # merge STAR and MIREOT extracted ontologies
robot merge \
  --input temp-star-pain.owl \
  --input temp-mireot.owl \
  reduce --output ../owl/ncit-pain.owl
