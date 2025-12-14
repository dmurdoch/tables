# Include all columns of a dataframe.

This constructs a formula object for all the columns of a dataframe.

## Usage

``` r
All(df, numeric=TRUE, character=FALSE, logical=FALSE, factor=FALSE, 
        complex=FALSE, raw=FALSE, other=FALSE,
        texify=getOption("tables.texify", FALSE))
```

## Arguments

- df:

  The dataframe in which to find the columns.

- numeric, character, logical, factor, complex, raw:

  Whether to include columns of specified types. See the Details below.

- other:

  Whether to include columns that match none of the previous types.

- texify:

  Whether to escape LaTeX special characters in column names.

## Details

This function constructs a formula from the columns of a dataframe. By
default, only numeric columns are included. The arguments `numeric`,
`character`, `logical`, `factor`, `complex` and `raw` control the
inclusion of columns of the corresponding types. The argument `other`
controls inclusion of any other columns.

If these arguments are `TRUE`, such columns will be included in the
formula.

If a function (or the name of a function given as a character string) is
passed, such columns will be transformed by the function before
inclusion. For example, `All(df, factor=as.character)` will convert all
factor columns into their character representation for inclusion.

In other cases, the columns will be skipped.

## Value

Language to insert into the table formula to achieve the desired table.

## Examples

``` r
# Show mean and sd of all numeric columns in the iris data
tabular( Species  ~ 
       All(iris)*(mean + sd), data=iris )
#>                                                                       
#>             Sepal.Length        Sepal.Width        Petal.Length       
#>  Species    mean         sd     mean        sd     mean         sd    
#>  setosa     5.006        0.3525 3.428       0.3791 1.462        0.1737
#>  versicolor 5.936        0.5162 2.770       0.3138 4.260        0.4699
#>  virginica  6.588        0.6359 2.974       0.3225 5.552        0.5519
#>                    
#>  Petal.Width       
#>  mean        sd    
#>  0.246       0.1054
#>  1.326       0.1978
#>  2.026       0.2747
```
