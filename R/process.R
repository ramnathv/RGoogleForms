#' Split document into metadata and exercises
#' 
#' Any YAML front matter is detected as metadata and is read into a list. This 
#' metadata is used to override the defaults provided by slidify.
#' @param doc path to exercise file
#' @return list with metadata and exercises
#' @keywords internal
to_exercises <- function(doc){
  txt = str_split_fixed(read_file(doc), '\n---', 2)
  meta = yaml.load(gsub("^---\n+", '', txt[1]))
  deck = c(meta, exercises = txt[2])
}

#' Knit quiz to markdown
#'
#' @keywords internal
knit_exercises <- function(quiz){
  require(knitr)
  render_markdown(strict = TRUE)
  knit_hooks$set(plot = knitr:::hook_plot_html)
  quiz$exercises = knit(text = quiz$exercises)
  return(invisible(quiz))
}

#' Parse exerciss into elements
#'
#' Exercises are separated by and empty line followed by three dashes. 
#' @keywords internal
parse_exercises <- function(quiz){
  temp = quiz$exercises
  temp = str_split(temp, '\n\n---')[[1]]
  temp = lapply(temp, parse_exercise)
  temp = lapply(seq_along(temp), function(i){
    modifyList(temp[[i]], list(entry = i - 1, qnum = i, type = temp[[i]]$tpl))
  })
  quiz$exercises = temp
  return(quiz)
}

