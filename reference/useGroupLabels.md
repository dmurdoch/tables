# Format table with groups of lines

When a factor level applies to multiple lines in a table, normally an
extra column of row labels is added to show the levels. This function
merges that column into another column in the labels.

## Usage

``` r
useGroupLabels(tab, col = 1, 
               indent = "  ", 
               newcolumn = 1,
               singleRow = TRUE,
               extraLines = 0)
```

## Arguments

- tab:

  A tabular object.

- col:

  Which column defines the groups?

- indent:

  A prefix to add to existing entries in the new column.

- newcolumn:

  Which column gets the group headings?

- singleRow:

  If a group has a single row and there is no entry in `newcolumn` in
  that row, put the group label in the same row rather than in a
  separate row.

- extraLines:

  Add this many blank lines to separate the groups in addition to the
  line containing the group label.

## Value

A tabular object, modified to include header rows as specified.

## Details

If `newcolumn` is less than 1 or greater than the number of row label
columns (after removing column `col`), extra columns will be added.

## Examples

``` r
set.seed(123)
n <- 10
df <- data.frame(a = factor(sample(1:3, n, replace=TRUE)),
                 b = factor(sample(1:3, n, replace=TRUE)),
                 x = rnorm(n))
levels(df$a) <- c("Long name 1", "Long name 2", "Long name 3")
levels(df$b) <- c("a", "abc", "abcdef")
library(tables)
tab <- tabular(a*Heading()*b ~ mean*x, data = df)
tab <- tab[!is.na(tab[,1])]
useGroupLabels(tab)
#>                     
#>              mean   
#>              x      
#>  Long name 1        
#>    a         -0.2159
#>  Long name 2        
#>    a          0.8255
#>    abc       -1.0489
#>    abcdef    -0.4200
#>  Long name 3        
#>    a         -0.2476
#>    abc        1.5387
#>    abcdef     1.2948
```
