# robot can't parse SIO from the URL, so I had to download it
robot merge \
  --input ../owl/sio.owl \
  --strict \
  --output temp-mirror.owl

# run STAR extract for term in order to get axioms
robot extract --method STAR \
  --input temp-mirror.owl \
  --term http://semanticscience.org/resource/SIO_000951 \
  --output temp-star-pain.owl

# get hierarchy and children for term
robot extract --method MIREOT \
  --input temp-mirror.owl \
  --lower-term http://semanticscience.org/resource/SIO_000951 \
  --branch-from-term http://semanticscience.org/resource/SIO_000951 \
  --output temp-mireot.owl
 
# merge STAR and MIREOT extracted ontologies
robot merge \
  --input temp-star-pain.owl \
  --input temp-mireot.owl \
  reduce --output ../owl/sio-pain.owl
