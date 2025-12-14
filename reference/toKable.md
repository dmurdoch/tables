# Convert `tabular` object to `knitr_kable` format.

Converts the output of the
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md) and
related functions to a format consistent with the output of the
[`kable`](https://rdrr.io/pkg/knitr/man/kable.html) function, so that it
can be customized using the kableExtra package.

## Usage

``` r
toKable(table, format = getKnitrFormat(), booktabs = TRUE, ...)
getKnitrFormat(default = "latex")
```

## Arguments

- table:

  An object of class `tabular`.

- format:

  The type of `knitr_kable` object desired; currently only `"latex"` and
  `"html"` are supported.

- booktabs:

  Should the table be rendered in
  [`booktabs`](https://dmurdoch.github.io/tables/reference/table_options.md)
  style? This only affects LaTeX output.

- ...:

  Additional arguments to pass to
  [`html.tabular`](https://dmurdoch.github.io/tables/reference/html.tabular.md)
  or
  [`latex.tabular`](https://dmurdoch.github.io/tables/reference/latex.tabular.md).

- default:

  The default type of output if not running in a knitr document.

## Value

An object of class `knitr_kable`, suitable for passing to functions in
the kableExtra package.

## See also

[`kableExtra-package`](https://rdrr.io/pkg/kableExtra/man/kableExtra-package.html)

## Examples

``` r
if (requireNamespace("kableExtra") && 
    (!requireNamespace("pkgdown") || !pkgdown::in_pkgdown())) {
  tab <-  tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
          (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
  print(kableExtra::kable_styling(toKable(tab), latex_options = "striped"))
  cat("\n")
  toKable(tab, format = "html", options = list(HTMLcaption = "Fisher's iris data"))
}
#> Loading required namespace: kableExtra
```
