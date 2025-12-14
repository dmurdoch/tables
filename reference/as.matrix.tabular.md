# Convert tabular object to matrix

Convert a tabular object to a matrix of the strings that would print, or
a matrix of values.

## Usage

``` r
# S3 method for class 'tabular'
as.matrix(x, format = TRUE, 
    rowLabels = TRUE, colLabels = TRUE, justification = "n", ...)
```

## Arguments

- x:

  A `"tabular"` object.

- format:

  How to format; see Details below.

- rowLabels, colLabels:

  Whether to include the row or column labels; only used if
  `format = TRUE`.

- justification:

  How to justify values; only used if `format = TRUE`.

- ...:

  Other parameters to pass to
  [`format.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## Details

If `format=TRUE`, then a matrix of formatted strings is produced. If
not, then the `format` argument is assumed to be a function (or name of
a function passed as a character vector) to convert the list-mode matrix
to another mode, e.g. `as.numeric`.

## Value

A matrix.

## Examples

``` r
table <-
    tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )

print(table)
#>                                                   
#>                 Sepal.Length      Sepal.Width     
#>  Species    n   mean         sd   mean        sd  
#>  setosa      50 5.01         0.35 3.43        0.38
#>  versicolor  50 5.94         0.52 2.77        0.31
#>  virginica   50 6.59         0.64 2.97        0.32
#>  All        150 5.84         0.83 3.06        0.44
as.matrix(table)
#>      [,1]         [,2]  [,3]           [,4]   [,5]          [,6]  
#> [1,] ""           ""    "Sepal.Length" ""     "Sepal.Width" ""    
#> [2,] "Species"    "n"   "mean"         "sd"   "mean"        "sd"  
#> [3,] "setosa"     " 50" "5.01"         "0.35" "3.43"        "0.38"
#> [4,] "versicolor" " 50" "5.94"         "0.52" "2.77"        "0.31"
#> [5,] "virginica"  " 50" "6.59"         "0.64" "2.97"        "0.32"
#> [6,] "All"        "150" "5.84"         "0.83" "3.06"        "0.44"
as.matrix(table, format=as.numeric)
#>      [,1]     [,2]      [,3]     [,4]      [,5]
#> [1,]   50 5.006000 0.3524897 3.428000 0.3790644
#> [2,]   50 5.936000 0.5161711 2.770000 0.3137983
#> [3,]   50 6.588000 0.6358796 2.974000 0.3224966
#> [4,]  150 5.843333 0.8280661 3.057333 0.4358663
```
