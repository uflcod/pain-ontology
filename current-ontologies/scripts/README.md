# Scripts

This directory contains shell scripts for creating the ontologies in the `../owl` directory. In general, the scripts work by using [robot](http://robot.obolibrary.org/)) to:

1. Download a copy of the ontology into a temporary ontology named `temp-mirror.owl`.
2. Extract axioms and related entities of the `pain` term into a temporary ontology named `temp-star-pain.owl`.
3. Extract the hierarchy and children of the `pain` term into a temporary ontology named `temp-mireot.owl`.
4. Merge `temp-star-pain.owl` and `temp-mireot.owl` into an ontology named `../owl/<ontology abbreviation>-pain.owl`. For example, the script `hp-robot-pain-extract.sh` shows how `../owl/hp-pain.owl` was created by extracting `pain` from the Human Phenotype Ontology (HP).  

One (aggrevating) exception is the Semanticscience Integrated Ontology (SIO). For some reason, `robot` is not able to download the ontology. So, the ontology `../owl/sio-pain.owl` was created using [OntoFox](https://ontofox.hegroup.org/). See `sio-ontofox.txt` for details used to extract the SIO `pain` term.
