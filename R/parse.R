#' Parse exercise into metadata and body
#'
parse_exercise <- function(exercise){
  require(stringr); require(markdown)
  exercise = str_split_fixed(exercise, '\n', 2)
  exercise = setNames(as.list(exercise), c('meta', 'body'))
  meta = parse_meta(exercise$meta)
  body = parse_body(exercise$body)
  if(meta$tpl != 'text'){
  	body = modifyList(body, split_items(body$content))
  }
  merge_list(meta, body)
}

split_items <- function(content){
	itemlist = sub('^(.*)(<[u|o]l>.*</[u|o]l>).*$', '\\2', content)
	items = str_match_all(itemlist, "<li>(.+?)</li>")[[1]][,2]
	items = zip_vectors(value = items, item = LETTERS[seq_along(items)], 
											itemnum = seq_along(items))
	content = sub('^(.*)(<[u|o]l>.*</[u|o]l>).*$', '\\1', content)
	list(content = content, items = items)
}

#' Parse exercise metadata into its elements
#'
#' Arbitrary metadata can be added to the exercise header using the key:value format 
#' where key refers to the name of the metadata element and value is the value it 
#' takes. Commonly specified metadata like slide classes, id and templates can be 
#' specified using a shortcut by appending a punctuation mark. 
# TODO: Refactor this function so that it is more elegant.
parse_meta <- function(meta){
  x <- strsplit(meta, ' ')[[1]]
  x <- sub('^#', 'id:', x)
  x <- sub('&', 'tpl:', x, fixed = T)
  x <- sub('^\\.', 'class:', x)
  y <- str_split_fixed(x[grep(":", x)], ":", 2)
  y1 = y[,1]; y2 = y[,2]
  meta  = as.list(y2[y1 != 'class'])
  names(meta) = y1[y1 != 'class']
  meta$class = paste(y2[y1 == 'class'], collapse = ' ')
  filter_blank(meta)
}

#' Parse exercise body into its elements
#'
#' @body exercise contents excluding the metadata header
#' @keywords internal
parse_body <- function(body){
  html = ifelse(body != '', md2html(body), '')
  pat = '^(<h([0-9])>([^\n]*)</h[0-9]>)?\n*(.*)$'
  body = setNames(as.list(str_match(html, pat)),
   c('html', 'header', 'level', 'title', 'content'))
  modifyList(body, content2blocks(body$content))
}


#' Split exercise content into blocks 
#'
#' Every exercise has a default content block named "content". Further content 
#' blocks can be specified using a line starting with three stars followed by   
#' the name of the block. 
#' @param content exercise content returned by the parser
#' @return list of named content blocks
#' @keywords internal
content2blocks <- function(content){
  blocks <- strsplit(content, "<p>\\*{3}\\s*")[[1]]
  bpat   <- "^([a-zA-Z0-9]+)\\s*</p>\n*(.*)$"
  bnames <- ifelse(grepl(bpat, blocks), gsub(bpat, "\\1", blocks), 'content')
  bcont  <- gsub(bpat, "\\2", blocks)
  bcont  <- setNames(as.list(bcont), bnames)
#   if ('items' %in% names(bcont)){
#     temp = str_match_all(bcont$items, "<li>(.+?)</li>")[[1]][,2]
#     bcont$items = zip_vectors(value = temp, item = LETTERS[seq_along(temp)], 
#       itemnum = seq_along(temp))
  	# x <- as.list(seq_along(temp))
  	#    names(x) <- temp
  	#    bcont$items <- iteratelist(x, name = 'value', value = 'item')
#   }
  if ('help' %in% names(bcont)){
    bcont$help = gsub("<p>(.+?)</p>", "\\1", bcont$help)
  }
  bcont
}
