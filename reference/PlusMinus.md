# Generate `x +/- y` terms in table.

This function generates a component of a table formula to output two
columns separated by a `+/-` sign. It is designed only for LaTeX output.

## Usage

``` r
PlusMinus(x, y, head, xhead, yhead, digits = 2, 
          character.only = FALSE, ...)
```

## Arguments

- x,y:

  Expressions to be displayed in the columns on the left and right of
  the `+/-` sign, respectively.

- head:

  If not missing, this will be used as a column heading for the two
  columns.

- xhead, yhead:

  If not missing, these will be used as individual column headings.

- digits, ...:

  Parameters to pass to the
  [`format`](https://rdrr.io/r/base/format.html) function.

- character.only:

  If `TRUE`, the `head`, `xhead` and `yhead` arguments will be
  interpreted as expressions evaluating to character values.

## Value

An expression which will produce the requested output in LaTeX.

## Examples

``` r
stderr <- function(x) sd(x)/sqrt(length(x))
toLatex( tabular( (Species+1) ~ Sepal.Length*
          PlusMinus(mean, stderr, digits=1), data=iris ) )
#> \begin{tabular}{lcc}
#> \hline
#> Species  & \multicolumn{2}{c}{Sepal.Length} \\ 
#> \hline
#> setosa  & \multicolumn{1}{r@{}}{$5.01$} & \multicolumn{1}{@{ $\pm$ }l}{$0.05$} \\
#> versicolor  & \multicolumn{1}{r@{}}{$5.94$} & \multicolumn{1}{@{ $\pm$ }l}{$0.07$} \\
#> virginica  & \multicolumn{1}{r@{}}{$6.59$} & \multicolumn{1}{@{ $\pm$ }l}{$0.09$} \\
#> All  & \multicolumn{1}{r@{}}{$5.84$} & \multicolumn{1}{@{ $\pm$ }l}{$0.07$} \\
#> \hline 
#> \end{tabular}
```
