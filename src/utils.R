wordvectors_conllu <- function(file_input, file_output){
  library(wordVectors) ## devtools::install_github("bmschmidt/wordVectors")
  x <- udpipe::udpipe_read_conllu(file_input)
  x <- split(x$token, f = x$sentence_id)
  x <- sapply(x,  FUN=function(x) paste(gsub(" ", intToUtf8(160), x), collapse = " "))
  f_input <- tempfile(fileext = ".txt")
  f_output <- tempfile(fileext = "_wordvectors.bin")
  writeLines(x, con = f_input)
  wv <- wordVectors::train_word2vec(train_file = f_input, output_file = f_output, 
                                    vectors = 50, window = 10, cbow = 0, iter = 15, min_count = 2, negative_samples = 5, 
                                    threads = 1, force = TRUE)
  write_wordvectors <- function(x, file){
    line1 <- sprintf("%s %s", nrow(wv), ncol(wv))
    lines_rest <- mapply(token = rownames(x), i = seq_len(nrow(x)), FUN=function(token, i){
      line <- sprintf("%s %s", token, paste(as.character(x[i, ]), collapse = " "))
      line
    })
    x <- c(line1, lines_rest)
    writeLines(x, con = file, sep = "\n")
  }
  write_wordvectors(wv, file_output)
}