# udpipe.models.ud - liberal udpipe models

This repository is a collection of linguistic models made with the udpipe R package (https://CRAN.R-project.org/package=udpipe). 

## License

- The models pubished here are models released under a licence which allow for commercial usage in contrast to the models which are made available at https://github.com/jwijffels/udpipe.models.ud.2.0 (that repository contains a lot more models for many more languages but under a non-commercial license due to licensing restrictions on the data used for training).
- Each of the models has its own license terms and you are responsible for complying with the license terms applicable to those parts of the models which you use. If you do not agree with the license terms, you must stop using these models and destroy all copies that you have obtained.
- The license for every model included in this repository is specified in the appropriate language/treebank directory. 
- The .R source code which is used to build the models is made available under the Mozilla Public License Version 2.0.
- The data which is used when constructing the models is data from the respective treebanks available at https://github.com/UniversalDependencies and fastText word vectors released at https://github.com/facebookresearch/fastText/blob/master/pretrained-vectors.md

## Currently available models

| Language        | model name                                      | model size  | data source         |
| ----------------|:-----------------------------------------------:| -----------:| -------------------:|
| Croatian        | croatian/hr-ud-2.1-20180104.udpipe              | xxx MB      | UD_Croatian         |
| Dutch           | dutch/nl-ud-2.1-20180104.udpipe                 | xxx MB      | UD_Dutch            |
| English         | english/en-ud-2.1-20180104.udpipe               | xxx MB      | UD_English          |
| French          | fr_sequoia-ud-2.1-20180104.udpipe               | xxx MB      | UD_French-Sequoia   |
| Polish          | polish/pl-ud-2.1-20180104.udpipe                | 195 MB      | UD_Polish           |
| Portuguese      | portuguese/pt-ud-2.1-20180104.udpipe            | xxx MB      | UD_Portuguese       |
| Spanish         | spanish-ancora/es_ancora-ud-2.1-20180104.udpipe | xxx MB      | UD_Spanish-AnCora   |
| Swedish         | swedish/sv-ud-2.1-20180104.udpipe               | xxx MB      | UD_Swedish          |


## Example usage

If you want to use the models, download the model from the respective folder and proceed as follows to annotate text with `udpipe_annotate`.
For more documentation on udpipe: look at the vignettes at https://CRAN.R-project.org/package=udpipe

```
library(udpipe)
download.file(url = https://raw.githubusercontent.com/bnosac/udpipe.models.ud/master/polish/pl-ud-2.1-20180104.udpipe, 
              destfile = "ud_polish.udpipe", mode = "wb")
m <- udpipe_load_model("ud_polish.udpipe")
x <- udpipe_annotate(m, "Budynek otrzymany od parafii wymaga remontu, a placówka nie otrzymała jeszcze żadnej dotacji.")
x <- as.data.frame(x)
x

 doc_id paragraph_id sentence_id token_id     token     lemma upos                      xpos                                                                                          feats head_token_id dep_rel
   doc1            1           1        1   Budynek   budynek NOUN           subst:sg:acc:m3                                                  Animacy=Inan|Case=Acc|Gender=Masc|Number=Sing             5     obj
   doc1            1           1        2 otrzymany otrzymany  ADJ ppas:sg:acc:m3:imperf:aff Animacy=Inan|Aspect=Imp|Case=Acc|Gender=Masc|Number=Sing|Polarity=Pos|VerbForm=Part|Voice=Pass             1    amod
   doc1            1           1        3        od        od  ADP             prep:gen:nwok                                                            AdpType=Prep|Case=Gen|Variant=Short             4    case
   doc1            1           1        4   parafii   parafia NOUN            subst:sg:gen:f                                                                Case=Gen|Gender=Fem|Number=Sing             2     obl
   doc1            1           1        5    wymaga   wymagac VERB         fin:sg:ter:imperf                               Aspect=Imp|Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin             0    root
   doc1            1           1        6   remontu    remont NOUN           subst:sg:gen:m3                                                  Animacy=Inan|Case=Gen|Gender=Masc|Number=Sing             5     obj
...
```

## Reproduce

The subdirectories contain the models which have .udpipe extension as well as the R code and the log which was used to generate the model.
If you want to contribute, use a similar flow and submit a pull request. Please be clear on the license of your model.

If you want to build a model just proceed as follows (example on dutch)

```
Rscript dutch/train.R > dutch/train.log
```

## Support in text mining

Need support in text mining?
Contact BNOSAC: http://www.bnosac.be

