# Custom printing of `tabular` objects.

Automatically print `tabular` objects with formatting when in a knitr
document.

## Usage

``` r
# S3 method for class 'tabular'
knit_print(x, format = getKnitrFormat(), ...)
```

## Arguments

- x:

  A `tabular` object.

- format:

  Which output format? `"latex"` and `"html"` are supported.

- ...:

  Other parameters, currently ignored.

## Details

This function is not normally called by a user. It is designed to be
called by knitr while processing a `.Rmd` or `.Rnw` document.

If `table_options()$knit_print` is `TRUE` and the output format is
supported, this method will prepare output suitable for formatted
printing in a knitr document using
[`asis_output`](https://rdrr.io/pkg/knitr/man/asis_output.html).
Otherwise, the usual unformatted print display will be done by
[`normal_print`](https://rdrr.io/pkg/knitr/man/knit_print.html).

## Value

An object marked for printing in a knitr document.

## Examples

``` r
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
knitr::knit_print(tab)
#> [1] "\\begin{tabular}{lccccc}\n\\hline\n &  & \\multicolumn{2}{c}{Sepal.Length} & \\multicolumn{2}{c}{Sepal.Width} \\\\ \nSpecies  & n & mean & sd & mean & \\multicolumn{1}{c}{sd} \\\\ \n\\hline\nsetosa  & $\\phantom{0}50$ & $5.01$ & $0.35$ & $3.43$ & $0.38$ \\\\\nversicolor  & $\\phantom{0}50$ & $5.94$ & $0.52$ & $2.77$ & $0.31$ \\\\\nvirginica  & $\\phantom{0}50$ & $6.59$ & $0.64$ & $2.97$ & $0.32$ \\\\\nAll  & $150$ & $5.84$ & $0.83$ & $3.06$ & $0.44$ \\\\\n\\hline \n\\end{tabular}\n\n\nFALSE\n\n\n"
#> attr(,"class")
#> [1] "knit_asis"
#> attr(,"knit_cacheable")
#> [1] NA
```
