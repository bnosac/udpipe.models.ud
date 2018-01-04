library(udpipe)
data(udpipe_annotation_params)
get_params <- function(object, language){
  p <- subset(object, language_treebank == language)
  p <- as.list(p)
  p$language_treebank <- NULL
  p <- p[sapply(p, FUN=function(x) !is.na(x))]
  if("embedding_form_file" %in% names(p)){
    p$embedding_form_file <- "data/wordvectors.vec"
    p$embedding_form <- 300
  }
  p
}
language <- "pl"
params_tokenizer <- get_params(udpipe_annotation_params$tokenizer, language = language)
params_tagger <- get_params(udpipe_annotation_params$tagger, language = language)
params_parser <- get_params(udpipe_annotation_params$parser, language = language)
edit(params_tokenizer)
edit(params_tagger)
edit(params_parser)

