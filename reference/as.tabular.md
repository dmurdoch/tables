# Convert matrix or dataframe to tabular object.

These functions construct or copy labels onto an existing matrix or
dataframe.

## Usage

``` r
as.tabular(x, like = NULL)
# Default S3 method
as.tabular(x, like = NULL)
# S3 method for class 'data.frame'
as.tabular(x, like = NULL)
```

## Arguments

- x:

  The object to convert.

- like:

  If not `NULL`, should be a tabular object with the same number of rows
  and columns as `x`. Its labels will be used on the result.

## Value

A `tabular` object.

## See also

`as.matrix.tabular`

## Examples

``` r
model <- tabular( (Species + 1) ~ (n=1) + Sepal.Length + Sepal.Width, data=iris )
model
#>                                         
#>  Species    n   Sepal.Length Sepal.Width
#>  setosa      50  50           50        
#>  versicolor  50  50           50        
#>  virginica   50  50           50        
#>  All        150 150          150        
as.tabular(matrix(1:12, 4,3), like=model)
#>                                       
#>  Species    n Sepal.Length Sepal.Width
#>  setosa     1 5             9         
#>  versicolor 2 6            10         
#>  virginica  3 7            11         
#>  All        4 8            12         
```
