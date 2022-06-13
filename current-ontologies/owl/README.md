# Ontologies  

This directory contains ontologies from which their `pain` term, the hierarchy containing `pain`, any children of `pain`, and a number of related axioms and associated terms have been extracted (using [robot](http://robot.obolibrary.org/)).  

Details on how `robot` is used to extract the ontologies can be found by viewing the `*.sh` files in the `../scripts` directory. For example, the script `hp-robot-pain-extract.sh` shows how `hp-pain.owl` was created by extracting `pain` from the Human Phenotype Ontology (HP).  

One (aggrevating) exception is the Semanticscience Integrated Ontology (SIO). For some reason, `robot` is not able to download the ontology. So, the ontology had to be manually downloaded (`sio.owl`) and then `sio-pain.owl` was created using the manual download.  
