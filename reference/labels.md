# Retrieve or modify the row or column labels.

These functions allow the row or column labels of a tabular object to be
retrieved or modified.

## Usage

``` r
rowLabels(x)
rowLabels(x) <- value
colLabels(x)
colLabels(x) <- value
# S3 method for class 'tabularRowLabels'
x[i, j, ..., drop = FALSE]
# S3 method for class 'tabularColLabels'
x[i, j, ..., drop = FALSE]
```

## Arguments

- x:

  A `"tabular"`, `"tabularRowLabels"` or `"tabularColLabels"` object.

- value:

  A replacement

- i, j, ..., drop:

  Arguments used for subsetting the labels. See Details below.

## Details

Subsetting the row labels does not allow the number of rows to be
changed; likewise, subsetting the column labels does not allow the
number of columns to be changed. To change both, subset the original
`"tabular"` object.

## Value

`rowLabels` and the corresponding subsetting method return an object of
class `"tabularRowLabels"`.

`colLabels` and the corresponding subsetting method return an object of
class `"tabularColLabels"`.

The assignment functions return `"tabular"` objects.

## See also

[`[.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)

## Examples

``` r
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
colLabels(tab)
#>      [,1] [,2]         [,3] [,4]        [,5]
#> [1,]      Sepal.Length <NA> Sepal.Width <NA>
#> [2,] n    mean         sd   mean        sd  
#> Attributes:  dim, justification, colnamejust, justify, suppress, nearData, class 
colLabels(tab) <- colLabels(tab)[1,]
tab
#>                                                   
#>  Species        Sepal.Length      Sepal.Width     
#>  setosa      50 5.01         0.35 3.43        0.38
#>  versicolor  50 5.94         0.52 2.77        0.31
#>  virginica   50 6.59         0.64 2.97        0.32
#>  All        150 5.84         0.83 3.06        0.44
```
