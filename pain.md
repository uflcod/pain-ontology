Pain Ontology #pylode { position: fixed; top: 130px; left: -80px; font-size: small; transform: rotate(-90deg); color: grey; } #pylode a { font-size: 2em; font-weight: bold; text-decoration: none; color: #005A9C; } #pylode a:hover { color: #333; } #pylode #p { color: #329545; } #pylode #y { color: #f9cb33; } #pylode #version { font-size: 1.0em; } .cardinality { font-style: italic; color: #aa00aa; } dl { /\*border: 1px solid navy;\*/ /\*padding:5px;\*/ } dt { font-weight: bold; padding: 0; } dd { margin-bottom: 10px; padding-top: 7px; } #metadata ul, #classes ul { list-style-type: none; } #metadata ul li, #classes ul li { margin-left: -40px; } ul.hlist { list-style-type: none; border: 1px solid navy; padding:5px; background-color: #F4FFFF; } ul.hierarchy { border: 1px solid navy; padding: 5px 25px 5px 25px; background-color: #F4FFFF; } ul.hlist li { display: inline; margin-right: 10px; } .entity { border: 1px solid navy; margin:5px 0 5px 0; padding: 5px; } .entity th { width: 150px; vertical-align: top; } .entity th, .entity td { padding-bottom: 20px; } .entity table th { text-align: left; } section#overview img { max-width: 1000px; } h1, h2, h3, h4, h5, h6 { text-align: left } h1, h2, h3 { color: #005A9C; background: white } h1 { font: 170% sans-serif; line-height: 110%; } h2 { font: 140% sans-serif; margin-top:40px; } h3 { font: 120% sans-serif; margin-top: 20px; padding-bottom: 5px; border-bottom: 1px solid navy; } h4 { font: bold 100% sans-serif } h5 { font: italic 100% sans-serif } h6 { font: small-caps 100% sans-serif } body { padding: 2em 70px 2em 70px; margin: 0; font-family: sans-serif; color: black; background: white; background-position: top left; background-attachment: fixed; background-repeat: no-repeat; text-align: justify; } section { max-width: 1500px; } .figure { margin-bottom: 20px; } :link { color: #00C; background: transparent } :visited { color: #609; background: transparent } a:active { color: #C00; background: transparent } .sup-c, .sup-op, .sup-fp, .sup-dp, .sup-ap, .sup-p, .sup-ni, .sup-con, .sup-col { cursor:help; } .sup-c { color:orange; } .sup-op { color:navy; } .sup-fp { color:lightskyblue; } .sup-dp { color:green; } .sup-ap { color:darkred; } .sup-p { color:black; } .sup-ni { color:brown; } .sup-con { color:orange; } .sup-col { color:darkred; } sup { margin-left: -3px; } code { font-size: large; color: darkred; } /* less prominent links for properties */ .proplink { color: #336; text-decoration: none; } #toc { position: fixed; top: 0; right: 0; z-index: 2; height: 100%; overflow-y: auto; padding: 10px; border: solid 1px navy; font-size: small; width: 180px; } #toc h3 { margin-top: 5px; } #toc ul { list-style: none; padding-left: 0; } #toc .first > li { margin-top: 5px; } #toc .second, #toc .third { padding-left: 10px; } #content { width: calc(100% - 150px); } .hover_property { cursor: help; text-decoration: none; border-bottom: dashed 1px; } .setclass { list-style-type: none; } code{ word-wrap: break-word; } table { table-layout: fixed; width: 100%; } td { word-wrap: break-word; }   \[ { "@id": "http://purl.obolibrary.org/obo/pain.owl", "@type": \[ "https://schema.org/DefinedTermSet" \], "https://schema.org/name": \[ { "@value": "Pain Ontology" } \] } \] 

Pain Ontology
=============

Metadata
--------

**IRI**

`http://purl.obolibrary.org/obo/pain.owl`

[Title](http://purl.org/dc/terms/title "A name given to the resource. Defined in DCMI Metadata Terms")

Pain Ontology

Classes
-------

### pain c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000000` |
| [Description](http://purl.org/dc/terms/description "An account of the resource. Defined in DCMI Metadata Terms") | * See http://ontology.buffalo.edu/smith/articles/pain.pdf page 6.<br>    <br>* a bodily process in an organism S involving two integrated levels:<br>    <br>    (a) activation of the nociceptive system and associated emotion generating brain components of S, and<br>    <br>    (b) a simultaneous aversive sensory and emotional experience on the part of S,<br>    <br>    where (b) is phenomenologically similar to the sort of aversive experience involved in PCT pain.<br>    <br>* ‘Phenomenologically similar’ means inter alia: (1) that the experience is ‘of’ or is ‘targeted towards’ some region R of the body of S, so that all pain is in this sense (and however diffusely) localized; (2) that the experience involves a dimension of unpleas- antness which – as is shown by the case of pain asymbolia – is not necessarily of the sort that involves suffering or aversion on the part of the subject S. This definition is formulated in such a way that small children and even some ani- mals can experience canonical pain, even though they do not have the cognitive re- sources to represent their experience as one that is caused in this or that way. This ad- dresses one recognized shortcoming of the IASP definition \[Rollin BE. Science and Ethics, Cambridge : Cambridge University Press, 2006.\]. |
| [Super Class Of](https://w3id.org/profile/ontdoc/superClassOf "Inverse of RDFS' subClassOf. Defined in Ontology Documentation Profile") | * [obo:PAIN_0000001](http://purl.obolibrary.org/obo/PAIN_0000001) c<br>* [obo:PAIN_0000002](http://purl.obolibrary.org/obo/PAIN_0000002) c |

### canonical pain c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000001` |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000000](http://purl.obolibrary.org/obo/PAIN_0000000) c |
| [Super Class Of](https://w3id.org/profile/ontdoc/superClassOf "Inverse of RDFS' subClassOf. Defined in Ontology Documentation Profile") | * [obo:PAIN_0000003](http://purl.obolibrary.org/obo/PAIN_0000003) c<br>* [obo:PAIN_0000004](http://purl.obolibrary.org/obo/PAIN_0000004) c |

### variant pain c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000002` |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000000](http://purl.obolibrary.org/obo/PAIN_0000000) c |

### pain with concordant tissue damage (PCT) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000003` |
| [Description](http://purl.org/dc/terms/description "An account of the resource. Defined in DCMI Metadata Terms") | * (1) a bodily process in an organism S involving two integrated levels:<br>    <br>    (1a) activation of the nociceptive system including the pain-associated emotion- generating brain components of S, and<br>    <br>    (1b) a simultaneous sensory and aversive experience on the part of S<br>    <br>    that is, (2) caused by damage to tissue located in a region R of the body of the subject S,<br>    <br>    (3) experienced by S as being caused by this damage,4) such as to involve an aversive reaction on the part of S directed towards that which is presumed by S to be causing this damage,<br>    <br>    (5) concordant with the tissue damage on both levels (1a) and (1b), and also,<br>    <br>    (6) such that the sensory experience is sufficiently intense to communicate the presence of tissue damage to the subject.<br>    <br>* See http://ontology.buffalo.edu/smith/articles/pain.pdf page 5. |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000001](http://purl.obolibrary.org/obo/PAIN_0000001) c |

### pain without concordant tissue damage (PNT) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000004` |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000001](http://purl.obolibrary.org/obo/PAIN_0000001) c |

### pain-related phenomenon without pain (PRP) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000005` |
| [Super Class Of](https://w3id.org/profile/ontdoc/superClassOf "Inverse of RDFS' subClassOf. Defined in Ontology Documentation Profile") | * [obo:PAIN_0000006](http://purl.obolibrary.org/obo/PAIN_0000006) c<br>* [obo:PAIN_0000007](http://purl.obolibrary.org/obo/PAIN_0000007) c |

### pain behavior without pain (PBWP) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000006` |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000005](http://purl.obolibrary.org/obo/PAIN_0000005) c |

### tissue damage without pain (TWP) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000007` |
| [Sub Class Of](http://www.w3.org/2000/01/rdf-schema#subClassOf "The subject is a subclass of a class. Defined in The RDF Schema vocabulary (RDFS)") | [obo:PAIN_0000005](http://purl.obolibrary.org/obo/PAIN_0000005) c |

### pain (IASP) c

|     |     |
| --- | --- |
| IRI | `http://purl.obolibrary.org/obo/PAIN_0000008` |
| [Description](http://purl.org/dc/terms/description "An account of the resource. Defined in DCMI Metadata Terms") | an unpleasant sensory and emotional experience associated with actual or potential tissue damage, or described in terms of such damage \[Merskey H, Albe-Fessard DG, Bonica JJ, et al: Pain terms: A list with definitions and notes on usage. Recommended by the IASP Subcommittee on Taxonomy. Pain 1979; 6:249-252. http://www.iasp-pain.org/source/eforums\]. |

Annotation Properties
---------------------

### title ap

|     |     |
| --- | --- |
| IRI | `http://purl.org/dc/terms/title` |

Namespaces
----------

dcterms

`http://purl.org/dc/terms/`

obo

`http://purl.obolibrary.org/obo/`

owl

`http://www.w3.org/2002/07/owl#`

rdf

`http://www.w3.org/1999/02/22-rdf-syntax-ns#`

rdfs

`http://www.w3.org/2000/01/rdf-schema#`

Legend
------

|     |     |
| --- | --- |
| c   | Classes |
| ap  | Annotation Properties |

made by [p y LODE](https://github.com/rdflib/pyLODE) [3.0.4](https://github.com/rdflib/pyLODE/release/3.0.4)

### Table of Contents

* #### [Metadata](#metadata)
    
* #### [Classes](#classes)
    
    * [pain](#pain)
    * [canonical pain](#canonicalpain)
    * [variant pain](#variantpain)
    * [pain with concordant tissue damage (PCT)](#painwithconcordanttissuedamage(PCT))
    * [pain without concordant tissue damage (PNT)](#painwithoutconcordanttissuedamage(PNT))
    * [pain-related phenomenon without pain (PRP)](#pain-relatedphenomenonwithoutpain(PRP))
    * [pain behavior without pain (PBWP)](#painbehaviorwithoutpain(PBWP))
    * [tissue damage without pain (TWP)](#tissuedamagewithoutpain(TWP))
    * [pain (IASP)](#pain(IASP))
* #### [Annotation Properties](#annotationproperties)
    
    * [title](#title)
* #### [Namespaces](#namespaces)
    
    * [dcterms](#dcterms)
    * [obo](#obo)
    * [owl](#owl)
    * [rdf](#rdf)
    * [rdfs](#rdfs)
* #### [Legend](#legend)