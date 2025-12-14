# Create table in full table environment

The [`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
function creates a table which usually renders as a `tabular`
environment when displayed in LaTeX, not as a "float" with caption,
label, etc. This function wraps the
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
result in the result of a call to the
`knitr::`[`kable`](https://rdrr.io/pkg/knitr/man/kable.html) function.

## Usage

``` r
latexTable(table, format = "latex", longtable = FALSE, ...)
```

## Arguments

- table:

  Either a formula to be passed to
  [`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
  or the result of a call to that function.

- format:

  Currently only `"latex"` format output is supported.

- longtable, ...:

  Additional arguments to be passed to the
  `knitr::`[`kable`](https://rdrr.io/pkg/knitr/man/kable.html) function.
  See details below.

## Details

Rather than redoing all the work of generating LaTeX code to wrap the
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
result, this function works by generating a dummy
[`kable`](https://rdrr.io/pkg/knitr/man/kable.html) table, and replaces
the `tabular` part with the
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
result.

Many of the arguments to
[`kable`](https://rdrr.io/pkg/knitr/man/kable.html) deal with the
content of the table, not the wrapper. These will be ignored with a
warning. Currently the arguments that will not be ignored, with their
defaults, are:

- `caption = NULL`:

  The caption to use on the table.

- `label = NULL`:

  Part of the LaTeX label to use on the table. The full label will have
  `"tab:"` prepended by
  [`kable`](https://rdrr.io/pkg/knitr/man/kable.html).

- `escape = TRUE`:

  Whether to escape special characters in the caption.

- `booktabs = FALSE, longtable = FALSE`:

  Logical values to indicate that style of table. These must also be
  specified to
  [`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md);
  see the main
  [vignette](https://dmurdoch.github.io/tables/doc/index.md) for
  details.

- `position = ""`:

  The instruction to LaTeX about how to position the float in the
  document.

- `centering = TRUE`:

  Whether to center the table in the float.

- `caption.short = ""`:

  Abbreviated caption to use in TOC.

- `table.envir = if (!is.null(caption)) "table"`:

  Name of outer environment.

These arguments are all defined in the knitr package, and may change in
the future.

## Value

An object of class `"knitr_kable"` suitable to include in a
[`Sweave`](https://rdrr.io/r/utils/Sweave.html) or knitr `.Rnw`
document.

## Examples

``` r
cat(latexTable(tabular((Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris ),
    caption = "Iris sepal data", label = "sepals"))
#> \begin{table}
#> 
#> \caption{\label{tab:sepals}Iris sepal data}
#> \centering
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
#> 
#> \end{table}
```
