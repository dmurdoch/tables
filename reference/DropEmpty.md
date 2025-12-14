# `DropEmpty` pseudo-function

Pseudo-function to indicate that rows or columns containing no
observations should be dropped.

## Usage

``` r
DropEmpty(empty = "", which = c("row", "col", "cell"))
```

## Arguments

- empty:

  String to use in empty cells.

- which:

  A vector indicating what should be dropped. See the Details below.

## Details

If the `which` argument contains `"row"`, then any row in the table in
which all cells are empty will be dropped. Similarly, if it contains
`"col"`, empty columns will be dropped. If it contains `"cell"`, then
cells in rows and columns that are not dropped will be set to the
`empty` string.

## Pseudo-functions

This is a “pseudo-function”: it takes the form of a function call, but
is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## Examples

``` r
df <- data.frame(row = factor(1:10), value = rnorm(10))
subset <- df[sample(10, 5),, drop = FALSE]

# Some rows did not get selected, so this looks ugly
tabular(row ~ value*mean, data = subset)
#>             
#>      value  
#>  row mean   
#>  1       NaN
#>  2    1.1484
#>  3       NaN
#>  4   -0.2473
#>  5       NaN
#>  6   -0.2827
#>  7   -0.5537
#>  8    0.6290
#>  9       NaN
#>  10      NaN

# This only shows rows with data in them
tabular(row*DropEmpty() ~ value*mean, data = subset)
#>             
#>      value  
#>  row mean   
#>  2    1.1484
#>  4   -0.2473
#>  6   -0.2827
#>  7   -0.5537
#>  8    0.6290

# This shows empty cells as "(empty)"
tabular(row*DropEmpty("(empty)", "cell") ~ value*mean, data = subset)
#>             
#>      value  
#>  row mean   
#>  1   (empty)
#>  2    1.1484
#>  3   (empty)
#>  4   -0.2473
#>  5   (empty)
#>  6   -0.2827
#>  7   -0.5537
#>  8    0.6290
#>  9   (empty)
#>  10  (empty)
```
