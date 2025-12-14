# Set or query options for the table formatting.

These functions set or query options for table formatting in LaTeX or
HTML output.

## Usage

``` r
table_options(...)
booktabs(...)
htmloptions(head=TRUE, table=TRUE, pad=FALSE, 
            ...)
```

## Arguments

- head:

  logical; enables all of the HTML header options

- table:

  logical; enables output of all parts of the table itself

- pad:

  logical; enables all of the HTML padding options

- ...:

  Any of the options listed in the Details below.

## Details

The `table_options()` function sets or retrieves a number of options
that control formatting. Currently the options that affect both LaTeX
and HTML output are:

- `justification = "c"`:

  Default justification for the data columns in the table.

- `rowlabeljustification = "l"`:

  Default justification for row labels.

- `doBegin, doHeader, doBody, doFooter, doEnd`:

  These logical values (all defaults are `TRUE`) control the inclusion
  of specific parts of the output table.

- `knit_print = TRUE`:

  Do auto formatting when printing in a knitr document.

- `escape`:

  Should special characters be escaped? If so, they will appear as-is in
  the output. If not, they will be interpreted according to the rules of
  the output format.

These options are only used for LaTeX output:

- `tabular = "tabular"`:

  The LaTeX environment to use for the table. Other choices such as
  `"longtable"` might make sense.

- `toprule, midrule, bottomrule`:

  The LaTeX macros to use for the lines in the table. By default they
  are all `"\hline"`.

- `titlerule = NULL`:

  The LaTeX macro to use to underline multicolumn titles. If `NULL`, no
  underlining is done.

- `latexleftpad, latexrightpad, latexminus, mathmode`:

  These control formatting of numbers in the table. If `TRUE` (the
  default), blanks in R's formatting are converted to hard spaces in the
  LaTeX output, and negative signs are rendered properly. Generally this
  makes output look better, but the `.tex` input may be harder to read.

These options are only used for HTML output:

- `doHTMLheader, doCSS, doHTMLbody`:

  These control output of the material at the top of an HTML page.

- `HTMLhead, CSS, HTMLbody`:

  These are the default strings to output when the corresponding element
  is selected. If present, the string `"CHARSET"` will be replaced with
  the result of
  [`localeToCharset()`](https://rdrr.io/r/utils/localeToCharset.html) in
  the `HTMLhead`. The string `"#ID"` will be replaced with `"#"`
  followed by the `id` argument to
  [`html.tabular`](https://dmurdoch.github.io/tables/reference/html.tabular.md)
  (or removed if that is blank).

- `HTMLcaption`:

  This is an optional HTML caption for the table. If `NULL`, no caption
  is emitted.

- `HTMLleftpad, HTMLrightpad, HTMLminus`:

  These control formatting of numbers in the table. If `TRUE`, blanks in
  R's formatting are converted to hard spaces in the HTML output, and
  negative signs are rendered properly. Generally this makes output look
  better, but cut and paste from the table may include these special
  characters and not be recognized by other software. The default is
  `FALSE`.

- `HTMLattributes`:

  This is a string to add to the `"<table>"` declaration at the top of
  the table. By default, the attributes are
  `'frame="hsides" rules="groups"'`. These set horizontal rules on the
  top and bottom of the table and between the header, body, and footer
  (if present).

- `HTMLfooter`:

  This is `NULL` for no footer, or HTML code to insert in the table.
  Note that in HTML the footer should be specified before the body of
  the table;
  [`html.tabular`](https://dmurdoch.github.io/tables/reference/html.tabular.md)
  will do this if both are written in the same call.

These may be set persistently by calling `table_options()`, or just for
the duration of the call by passing them in a list via
`latex(options=list( ... ))`. Additional `...` arguments to `latex` are
passed to [`format`](https://rdrr.io/r/base/format.html).

Options may be retrieved by calling `table_options()` with no arguments,
or a single unnamed character vector of names of options to retrieve.

The `booktabs()` function sets the `table_options()` values to different
defaults, suitable for use with the booktabs LaTeX package.

The `htmloptions()` function constructs a list suitable for the
`options` argument to
[`html.tabular`](https://dmurdoch.github.io/tables/reference/html.tabular.md),
with grouping of options that rarely differ from each other.

Note that any LaTeX code can be used in the rule options; for example,
see the `longtable` example in the vignette. Material to go above the
headers goes into `toprule`, material between the headers and the body
goes into `midrule`, and material at the bottom of the table goes into
`bottomrule`.

## Value

`table_options()` and `booktabs()` return the previous settings.

`htmloptions()` returns a list of settings without changing the
defaults.

## See also

[`latex.tabular`](https://dmurdoch.github.io/tables/reference/latex.tabular.md),
[`html.tabular`](https://dmurdoch.github.io/tables/reference/html.tabular.md)

## Examples

``` r
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
toLatex(tab)
#> \begin{tabular}{lccccc}
#> \hline
#>  &  & \multicolumn{2}{c}{Sepal.Length} & \multicolumn{2}{c}{Sepal.Width} \\ 
#> Species  & n & mean & sd & mean & \multicolumn{1}{c}{sd} \\ 
#> \hline
#> setosa  & $\phantom{0}50$ & $5.01$ & $0.35$ & $3.43$ & $0.38$ \\
#> versicolor  & $\phantom{0}50$ & $5.94$ & $0.52$ & $2.77$ & $0.31$ \\
#> virginica  & $\phantom{0}50$ & $6.59$ & $0.64$ & $2.97$ & $0.32$ \\
#> All  & $150$ & $5.84$ & $0.83$ & $3.06$ & $0.44$ \\
#> \hline 
#> \end{tabular}
save <- booktabs()
toLatex(tab)
#> \begin{tabular}{lccccc}
#> \toprule
#>  &  & \multicolumn{2}{c}{Sepal.Length} & \multicolumn{2}{c}{Sepal.Width} \\ \cmidrule(lr){3-4}\cmidrule(lr){5-6}
#> Species  & n & mean & sd & mean & \multicolumn{1}{c}{sd} \\ 
#> \midrule
#> setosa  & $\phantom{0}50$ & $5.01$ & $0.35$ & $3.43$ & $0.38$ \\
#> versicolor  & $\phantom{0}50$ & $5.94$ & $0.52$ & $2.77$ & $0.31$ \\
#> virginica  & $\phantom{0}50$ & $6.59$ & $0.64$ & $2.97$ & $0.32$ \\
#> All  & $150$ & $5.84$ & $0.83$ & $3.06$ & $0.44$ \\
#> \bottomrule 
#> \end{tabular}
table_options(save)

# \donttest{
f <- tempfile(fileext = ".html")
if (interactive())
  toHTML(tab, f, 
    options=htmloptions(HTMLcaption="Table of Iris Data",
                      pad = TRUE))
# }
```
