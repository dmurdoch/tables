# Insert a literal entry into a table margin.

This allows insertion of arbitrary LaTeX text into a table.

## Usage

``` r
Literal(x, nearData = TRUE)
```

## Arguments

- x:

  A character string to insert.

- nearData:

  See the Details section of
  [`Heading`](https://dmurdoch.github.io/tables/reference/Heading.md).

## Details

In LaTeX the `literal` string should usually end with a `%` comment
character to avoid having a blank line inserted.

## Value

Produces an expression to insert a label containing the literal text.

## See also

[`Hline`](https://dmurdoch.github.io/tables/reference/Hline.md), which
uses this to insert lines.

## Examples

``` r
tabular( (Literal("Some text") + Species)  ~ 
       All(iris)*mean, data=iris )
#>                                                                      
#>                     Sepal.Length Sepal.Width Petal.Length Petal.Width
#>                     mean         mean        mean         mean       
#>          Some text                                                   
#>  Species setosa     5.006        3.428       1.462        0.246      
#>          versicolor 5.936        2.770       4.260        1.326      
#>          virginica  6.588        2.974       5.552        2.026      
```
