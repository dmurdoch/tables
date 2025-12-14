# Convert `tabular` object to `tinytable` format.

Converts the output of the
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md) and
related functions to a format consistent with the output of the
[`tt`](https://vincentarelbundock.github.io/tinytable/man/tt.html)
function, so that it can be customized using the tinytable package.

## Usage

``` r
toTinytable(table, ...)
```

## Arguments

- table:

  An object of class `tabular`.

- ...:

  Additional arguments to pass to
  [`tt`](https://vincentarelbundock.github.io/tinytable/man/tt.html).

## Value

An object of class `tinytable`, suitable for passing to functions in the
tinytable package. These tables can be exported to several formats,
including LaTeX, HTML, Markdown, Word, Typst, PDF, and PNG.

## See also

[`tinytable-package`](https://vincentarelbundock.github.io/tinytable/man/tinytable-package.html)

## Examples

``` r
if (requireNamespace("tinytable")) {

  tab <-  tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
          (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
  tab <- toTinytable(tab, theme = "striped")
  tab <- tinytable::style_tt(tab, i = 1:2, background = "teal", color = "white")
  tab

}
#> +------------+-----+-------+-------+-------+-------+
#> |                  | Sepal.Length  | Sepal.Width   |
#> +------------+-----+-------+-------+-------+-------+
#> | Species    | n   | mean  | sd    | mean  | sd    |
#> +============+=====+=======+=======+=======+=======+
#> | setosa     | 50  | 5.01  | 0.35  | 3.43  | 0.38  |
#> +------------+-----+-------+-------+-------+-------+
#> | versicolor | 50  | 5.94  | 0.52  | 2.77  | 0.31  |
#> +------------+-----+-------+-------+-------+-------+
#> | virginica  | 50  | 6.59  | 0.64  | 2.97  | 0.32  |
#> +------------+-----+-------+-------+-------+-------+
#> | All        | 150 | 5.84  | 0.83  | 3.06  | 0.44  |
#> +------------+-----+-------+-------+-------+-------+ 
```
