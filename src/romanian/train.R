library(utils)
library(udpipe)
settings <- list()
settings$wd <- getwd()
settings$date <- Sys.Date()
settings$language <- "romanian"
settings$treebank <- "ro"
settings$ud <- sprintf("https://raw.githubusercontent.com/UniversalDependencies/%s/master", "UD_Romanian")
settings$ud.train <- sprintf("%s/%s-ud-train.conllu", settings$ud, settings$treebank)
settings$ud.dev <- sprintf("%s/%s-ud-dev.conllu", settings$ud, settings$treebank)
settings$ud.test <- sprintf("%s/%s-ud-test.conllu", settings$ud, settings$treebank)
settings$wordvectors <- "https://s3-us-west-1.amazonaws.com/fasttext-vectors/wiki.ro.vec"
settings$modelname <- sprintf("%s-ud-2.1-%s.udpipe", settings$language, format(settings$date, "%Y%m%d"))
settings$modeloutput <- sprintf("%s/%s", settings$language, settings$modelname)
settings$modeloutput <- file.path(getwd(), "models", sprintf("%s", settings$modelname))
print(settings)
dir.create(sprintf("%s/data", settings$language))
setwd(settings$language)

if(TRUE){
  ## Download the conllu files
  download.file(url = settings$ud.train, destfile = "data/train.conllu")
  download.file(url = settings$ud.dev, destfile = "data/dev.conllu")
  download.file(url = settings$ud.test, destfile = "data/test.conllu")
  
  ## Download the word vectors
  download.file(url = settings$wordvectors, destfile = "data/wordvectors.vec")
}

## Train the model
print(Sys.time())
m <- udpipe_train(file = settings$modeloutput, 
                  files_conllu_training = "data/train.conllu", 
                  files_conllu_holdout = "data/dev.conllu",
                  annotation_tokenizer = list(dimension = 64, epochs = 100, initialization_range = 0.1, 
                                              batch_size = 100, learning_rate = 0.005, dropout = 0.2, early_stopping = 1),
                  annotation_tagger = list(models = 2, templates_1 = "tagger", guesser_suffix_rules_1 = 8, 
                                           guesser_enrich_dictionary_1 = 5, guesser_prefixes_max_1 = 0, 
                                           use_lemma_1 = 1, use_xpostag_1 = 1, use_feats_1 = 1, provide_lemma_1 = 0, 
                                           provide_xpostag_1 = 1, provide_feats_1 = 1, prune_features_1 = 0, 
                                           templates_2 = "lemmatizer", guesser_suffix_rules_2 = 8, guesser_enrich_dictionary_2 = 6, 
                                           guesser_prefixes_max_2 = 4, use_lemma_2 = 1, use_xpostag_2 = 0, 
                                           use_feats_2 = 0, provide_lemma_2 = 1, provide_xpostag_2 = 0, 
                                           provide_feats_2 = 0, prune_features_2 = 1),
                  annotation_parser = list(iterations = 30, embedding_upostag = 20, embedding_feats = 20, 
                                           embedding_xpostag = 0, embedding_form = 300, embedding_form_file = "data/wordvectors.vec", 
                                           embedding_lemma = 0, embedding_deprel = 20, learning_rate = 0.01, 
                                           learning_rate_final = 0.001, l2 = 0.5, hidden_layer = 200, 
                                           batch_size = 10, transition_system = "projective", transition_oracle = "dynamic", 
                                           structured_interval = 8))
print(Sys.time())

## Evaluate the accuracy
m <- udpipe_load_model(settings$modeloutput)
goodness_of_fit <- udpipe_accuracy(m, "data/test.conllu")
cat(goodness_of_fit$accuracy, sep = "\n") 

## Reset working directory
setwd(settings$wd)