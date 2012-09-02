#' Render contents of an exercise based on template
#' 
#' @keywords internal
render_exercise <- function(exercise, layouts){
  tpl <- ifelse(is.null(exercise$tpl), 'exercise', exercise$tpl)
  exercise$exercise = whisker.render(layouts[tpl], exercise)
  return(exercise)
}

render_exercises <- function(exercises, layouts){
  lapply(exercises, render_exercise, layouts)
}

render_quiz <- function(quiz, layouts){
  quiz$exercises = render_exercises(quiz$exercises, layouts)
  whisker.render(layouts$quiz, quiz, partials = layouts) 
}