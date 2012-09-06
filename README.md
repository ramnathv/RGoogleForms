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


#### Add Confirmation Page Redirect! ####

Here is some sample code showing how to do it

1. Create a custom confirmation page and add to `onload` in iframe.
2. Link the form's submit target to the new iframe.

```
<script type="text/javascript">var submitted=false;</script>
<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;" onload="if(submitted){window.location='http://www.morningcopy.com.au/tutorial/redux/thankyou.html';}">
</iframe>

<!--END OF CONFIRMATION PAGE REDIRECT-->


<!--GOOGLE FORM-->

<form action="http://spreadsheets.google.com/formResponse?key=pqbhTz7PIHum_4qKEdbUWVg&amp;embedded=true" method="post" target="hidden_iframe" onsubmit="submitted=true;">
```