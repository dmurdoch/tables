# Display a tabular object using HTML.

This is similar to
[`print.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
but it inserts the code to display the table in an HTML table.

## Usage

``` r
toHTML(object, file = "", options = NULL, 
                       id = NULL, append = FALSE, 
                       browsable = TRUE, 
                       ...)
html.tabular(object, ...)
writeCSS(CSS = htmloptions()$CSS, id = NULL)
```

## Arguments

- object:

  The tabular object.

- file:

  A filename or connection to which to write the HTML code, or `""` to
  write to the console.

- options:

  A list of options to set for the duration of the call.

- id:

  A unique identifier to set for this table and the associated CSS
  style, or `NULL`, for no id.

- append:

  If `TRUE`, opens `file` for appending (if it is a filename rather than
  a connection).

- browsable:

  Should the output be marked as browsable?

- ...:

  Settings for default formatting. See Details below.

- CSS:

  A character vector to use as CSS.

## Details

The `toHTML()` function produces HTML output suitable for inclusion in
an HTML page.

The `html.tabular` function is set up to work as a method for the `html`
generic in Hmisc, but is not registered as a method, so that tables can
work when Hmisc is not installed.

In HTML, it is mainly the CSS style sheet that determines the look of
the table. When formatting a table, `html.tabular` sets the CSS class
according to the table's `Justify` setting; justifications of
`c("l", "c", "r")` are translated to classes
`c("left", "center", "right")` respectively; other strings will be
passed through and used directly as class names. If the `id` value is
not `NULL`, then it will be used as the CSS id selector when searching
for a style. See
[`table_options`](https://dmurdoch.github.io/tables/reference/table_options.md)
for a number of options that control formatting, including the default
style sheet.

## Value

If `file = ""` (the default), the `toHTML()` function creates an HTML
object using the
[`htmltools::HTML`](https://rstudio.github.io/htmltools/reference/HTML.html)
function and returns it. If `file` is a character value or a connection,
the results are written there and the HTML object is returned invisibly.

## See also

[`print.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
[`toLatex.tabular`](https://dmurdoch.github.io/tables/reference/latex.tabular.md),
[`html`](https://rdrr.io/pkg/Hmisc/man/html.html),
[`htmloptions`](https://dmurdoch.github.io/tables/reference/table_options.md)

## Examples

``` r
# \donttest{
X <- rnorm(125, sd=100)
Group <- factor(sample(letters[1:5], 125, replace = TRUE))

tab <- tabular( Group ~ (N=1)+Format(digits=2)*X*((Mean=mean) + Heading("Std Dev")*sd) )

save <- table_options()
table_options(rowlabeljustification="c")

f <- tempfile(fileext=".html")
con <- file(f, "wt")

if (interactive())
  toHTML(tab, con, options=htmloptions(head=TRUE, table=FALSE))

writeLines("<p>This table has pad = FALSE.  The centered numbers look
sloppy.<br>", con)

if (interactive())
  toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE))

writeLines("<p>This table has pad = FALSE and justification=\"r\".
The justification makes the columns of numbers look all right (except
for the hyphens used as minus signs), but they are placed poorly
relative to the labels.<br>", con)

if (interactive())
  toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE, justification="r"))

writeLines("<p>This one has pad = TRUE. It looks best, but if you cut
and paste, the spacing characters may cause problems.<br>", con)

if (interactive())
  toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=TRUE))

table_options(save)
close(con)
if (interactive())
  browseURL(f)
# }
```
