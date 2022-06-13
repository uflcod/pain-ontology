# create local mirror
robot merge \
  --input-iri http://purl.obolibrary.org/obo/ogms.owl \
  --output temp-mirror.owl

# run STAR extract for term in order to get axioms
robot extract --method STAR \
  --input temp-mirror.owl \
  --term http://purl.obolibrary.org/obo/OGMS_0000085 \
  --output temp-star-pain.owl

# get hierarchy and children for term
robot extract --method MIREOT \
  --input temp-mirror.owl \
  --lower-term http://purl.obolibrary.org/obo/OGMS_0000085 \
  --branch-from-term http://purl.obolibrary.org/obo/OGMS_0000085 \
  --output temp-mireot.owl
 
# merge STAR and MIREOT extracted ontologies
robot merge \
  --input temp-star-pain.owl \
  --input temp-mireot.owl \
  reduce --output ../owl/ogms-pain.owl
