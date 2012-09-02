create_quiz <- function(file, output){
  quiz = file %|% to_exercises %|% knit_exercises %|% parse_exercises
  layouts = get_layouts(system.file('layouts', package = 'RGoogleForms'))
  if (missing(output)) {
    output = gsub('.Rmd', '.html', file)
  }
  cat(render_quiz(quiz, layouts), file = output)
}