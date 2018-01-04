# udpipe.models.ud - liberal udpipe models

This repository is a collection of linguistic models made with the udpipe R package (https://CRAN.R-project.org/package=udpipe). 

## Available models

The models are located in the models folder and allow to do Tokenisation, POS tagging, Lemmatisation and Dependency Parsing for the following languages.

| Language  | model name                               | size  | data source          | license      |
| ----------|------------------------------------------| -----:|----------------------|--------------|
| Afrikaans | afrikaans-ud-2.1-20180104.udpipe         | xxxMB | UD_Afrikaans         | CC BY-SA 4.0 |
| Croatian  | croatian-ud-2.1-20180104.udpipe          | xxxMB | UD_Croatian          | CC BY-SA 4.0 |
| Czech     | czech-cac-ud-2.1-20180104.udpipe         | xxxMB | UD_Czech-CAC         | CC BY-SA 4.0 |
| Dutch     | dutch-ud-2.1-20180104.udpipe             | xxxMB | UD_Dutch             | CC BY-SA 4.0 |
| English   | english-ud-2.1-20180104.udpipe           | xxxMB | UD_English           | CC BY-SA 4.0 |
| Finnish   | finnish-ud-2.1-20180104.udpipe           | xxxMB | UD_Finnish           | CC BY-SA 4.0 |
| French    | french-sequioa-ud-2.1-20180104.udpipe    | xxxMB | UD_French-Sequoia    | LGPL-LR      |
| Irish     | irish-ud-2.1-20180104.udpipe             | xxxMB | UD_Irish             | CC BY-SA 3.0 |
| Japanese  | japanese-ktc-ud-2.1-20180104.udpipe      | xxxMB | UD_Japanese-KTC      | CC BY-SA 4.0 |
| Norwegian | norwegian-bokmaal-ud-2.1-20180104.udpipe | xxxMB | UD_Norwegian-Bokmaal | CC BY-SA 4.0 |
| Persian   | persian-ud-2.1-20180104.udpipe           | xxxMB | UD_Persian           | CC BY-SA 4.0 |
| Polish    | polish-ud-2.1-20180104.udpipe            | 195MB | UD_Polish            | GPL-3.0      |
| Portuguese| portuguese-ud-2.1-20180104.udpipe        | xxxMB | UD_Portuguese        | CC BY-SA 4.0 |
| Romanian  | romanian-ud-2.1-20180104.udpipe          | xxxMB | UD_Romanian          | CC BY-SA 4.0 |
| Serbian   | serbian-ud-2.1-20180104.udpipe           | xxxMB | UD_Serbian           | CC BY-SA 4.0 |
| Slovak    | slovak-ud-2.1-20180104.udpipe            | xxxMB | UD_Slovak            | CC BY-SA 4.0 |
| Spanish   | spanish-ancora-ud-2.1-20180104.udpipe    | xxxMB | UD_Spanish-AnCora    | GPL-3.0      |
| Swedish   | swedish-ud-2.1-20180104.udpipe           | xxxMB | UD_Swedish           | CC BY-SA 4.0 |

Create an issue if languages from Universal Dependencies (http://universaldependencies.org) which you like to have included are missing.

## Example usage

If you want to use the models, download the model from the respective folder and proceed as follows to annotate text with `udpipe_annotate`.
For more documentation on udpipe: look at the vignettes at https://CRAN.R-project.org/package=udpipe

```
library(udpipe)
download.file(url = https://raw.githubusercontent.com/bnosac/udpipe.models.ud/master/models/polish-ud-2.1-20180104.udpipe, 
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

## License

- The models pubished here are models released under a licence which allow for commercial usage in contrast to the models which are made available at https://github.com/jwijffels/udpipe.models.ud.2.0 (that repository contains a lot more models for many more languages but these were released under a non-commercial license).
- Each of the models has its own license terms and you are responsible for complying with the license terms applicable to those parts of the models which you use. If you do not agree with the license terms, you must stop using these models and destroy all copies that you have obtained.
- The license for every model included in this repository is specified in the appropriate src/treebank directory. 
- The .R source code which is used to build the models is made available under the Mozilla Public License Version 2.0.
- The data which is used when constructing the models is data from the respective treebanks available at https://github.com/UniversalDependencies and fastText word vectors released at https://github.com/facebookresearch/fastText/blob/master/pretrained-vectors.md

## Reproducibility

In order to reproduce the model, execute the train.R code inside the src/treebank folders. The src/treebank folders contain the R code and the log which was used to generate the model. The log contains as well accuracy statistics of the model.
If you want to contribute, use a similar flow and submit a pull request. Please be clear on the license of your model.

If you want to reproduce model building, just proceed as follows (example on dutch) and wait a few hours depending on your CPU power.

```
Rscript src/dutch/train.R > src/dutch/train.log
```

## Support in text mining

Need support in text mining?
Contact BNOSAC: http://www.bnosac.be

