#' Read layout files 
#' 
#' @param url_layouts url to directory containing layout files
#' @return named list with contents of layout files
#' @keywords internal
read_layouts <- function(url_layouts){
  layout_files = dir(url_layouts, pattern = '*.html', full = T)
  setNames(
    lapply(layout_files, read_file), 
    gsub('.html', '', basename(layout_files), fixed = TRUE)
  )
}

#' Expand child layout
#'
#' @param layout layout to be expanded
#' @param layouts all layouts 
#' @keywords internal
expand_layout <- function(layout, layouts){
  mpat <- "^---\nlayout: ([[:alnum:]]+)\n---\n(.*)$"
  has_parent <- grepl(mpat, layout)
  if (has_parent){
     main <- layouts[[gsub(mpat, '\\1', layout)]]
     content <- gsub(mpat, "\\2", layout)
     layout <- sub("{{{ content }}}", content, main, fixed = TRUE)
   }
  return(layout)
}

expand_layouts <- function(layouts){
  lapply(layouts, expand_layout, layouts)
}


#' Get layouts
#'
#' @param framework slide generation framework used
#' @param url_lib url to directory containing the libraries
get_layouts <- function(url_layouts){
  layouts = read_layouts(url_layouts)  
  # run expand_layouts three times to fully expand nested layouts
  for (i in 1:3) {
    layouts = expand_layouts(layouts)
  }
  layouts
}