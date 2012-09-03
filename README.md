RGoogleForms
============

Generate Google Forms from RMarkdown


The objective of this package is to make it easy to create Google Forms using an R Markdown file.


1. Create a Google Form with at least as many questions as you plan to include.
2. Copy its Formkey and add as YAML front matter.
3. Write questions in R Markdown
4. Use `---` followed by the question type appended with `&` to separate questions.
5. Run `create_quiz` on your quiz file.


### Notes ###

1. It is important to create a Google Form with at least as many questions as you plan to include in the form. Moreover, it is important that you create the questions sequentially so that the entries correctly numbered

## TO DOs. ##


1. Add validation to forms (maybe http://github.com/elclanrs/jq-idealforms)
2. Add custom response page (would be cool if it is dynamically generated!)