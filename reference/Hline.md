# Add a horizontal line to a LaTeX table.

This function inserts a LaTeX directive to draw a full or partial line
in a table.

## Usage

``` r
Hline(columns, nearData = FALSE)
```

## Arguments

- columns:

  Which columns should receive the line?

- nearData:

  See the Details section of
  [`Heading`](https://dmurdoch.github.io/tables/reference/Heading.md).

## Details

`Hline()` is not very flexible: it must be the leftmost header in a row
specification for the table, i.e. `mean * Hline()` is not allowed.
Anything to the right of the `Hline()` factor will be ignored.

## Value

Produces an expression to insert a label which will be interpreted by
LaTeX as a request for a horizontal line.

## Examples

``` r
toLatex( tabular( Species + Hline() + 1 ~ mean*Sepal.Width, data=iris) )
#> \begin{tabular}{lc}
#> \hline
#>  & \multicolumn{1}{c}{mean} \\ 
#> Species  & \multicolumn{1}{c}{Sepal.Width} \\ 
#> \hline
#> setosa  & $3.428$ \\
#> versicolor  & $2.770$ \\
#> virginica  & $2.974$ \\
#> \hline %  &  \\
#> All  & $3.057$ \\
#> \hline 
#> \end{tabular}
```
