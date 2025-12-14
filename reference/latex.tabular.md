# Display a tabular object using LaTeX.

This is similar to
[`print.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
but it inserts the code to display the table in a LaTeX tabular
environment. The `toLatex.tabular` method works with the `toLatex`
generic from utils.

## Usage

``` r
toLatex(object, ...)
# S3 method for class 'tabular'
toLatex(object, file = "", options = NULL, 
                          append = FALSE, ...)
latex.tabular(object, ...)
```

## Arguments

- object:

  The tabular object.

- file:

  A filename or connection to which to write the LaTeX code, or `""` to
  write to the standard output.

- options:

  A list of options to set for the duration of the call.

- append:

  If `TRUE`, opens `file` for appending (if it is a filename rather than
  a connection).

- ...:

  Settings for default formatting. See Details below.

## Details

The `toLatex()` method produces LaTeX output suitable for inclusion in a
[`Sweave`](https://rdrr.io/r/utils/Sweave.html) document.

The `latex.tabular` function is set up to work as a method for the
`latex` generic in Hmisc, but is not registered as a method, so that
tables can work when Hmisc is not installed.

## Note

For historical reasons, the `toLatex()` function with a non-empty `file`
argument doesn't write to the file until the returned value is printed.

## Value

The `toLatex()` method returns `x` invisibly, and prints the LaTeX
script to the console.

[`table_options()`](https://dmurdoch.github.io/tables/reference/table_options.md)
and
[`booktabs()`](https://dmurdoch.github.io/tables/reference/table_options.md)
return the previous settings.

## See also

[`print.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
[`table_options`](https://dmurdoch.github.io/tables/reference/table_options.md),
`toLatex`, [`latex`](https://rdrr.io/pkg/Hmisc/man/latex.html)

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
```
