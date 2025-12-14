# Display all observations in a table.

These functions generate the code for a
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
table to include all observations in a dataset, possibly divided up
according to other factors.

## Usage

``` r
AllObs(data = NULL, show = FALSE, label = "Obsn.", within = NULL)
RowNum(within = NULL, perrow = 5, show = FALSE, label = "Row", data = NULL)
```

## Arguments

- data:

  The full dataset, used only to find the number of observations.

- show:

  Whether to show the observation number or row number in the table.

- label:

  The label to use when `show = TRUE`.

- within:

  A factor or list of factors by which to break up the observations.

- perrow:

  How many observations per row when `RowNum` is used in the row
  specification, or per column when it is part of the column
  specification.

## Details

`AllObs` is used to display all of the observations in a dataset. It
generates a (usually undisplayed) factor with a different level for each
observation, sets a function to display the value, and calls
[`DropEmpty`](https://dmurdoch.github.io/tables/reference/DropEmpty.md)
to suppress display of empty rows, columns or cells.

If the `within` argument is specified in `AllObs`, the factor levels are
restarted within each grouping. (`within` is interpreted as the `INDEX`
argument of [`tapply`](https://rdrr.io/r/base/tapply.html), with one
exception described below.) This may be useful when displaying the
observation number, and is definitely useful if `AllObs` is used as a
column specification in the table. It will also save some computation
time if the table is very large, since fewer factor levels will be
generated and later dropped.

`RowNum` is unlikely to be useful in a table by itself, but is helpful
when displaying large datasets with `AllObs`. It allows a large number
of observations to be broken into several rows and columns.

Because `RowNum` affects both rows and columns, its use is somewhat
unusual. Normally it should be called before calling
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md), and
its result saved in a variable. That variable (e.g. `rownum`) is used in
the row specification for the table wrapped in
[`I()`](https://rdrr.io/r/base/AsIs.html), and in the column
specification of the table in the `within` argument to `AllObs`. (This
is the exception mentioned above.)

Despite its name, `RowNum` can be used as a column specifier, if you'd
prefer column-major ordering of the values displayed in the table.

## Value

Both `AllObs` and `RowNum` return language objects to be used on
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
formulas.

## See also

[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md),
[`DropEmpty`](https://dmurdoch.github.io/tables/reference/DropEmpty.md)

## Examples

``` r
tabular(Factor(cyl)*Factor(gear)*AllObs(mtcars) ~ 
               rownames(mtcars) + mpg, data=mtcars)
#>                                   
#>  cyl gear rownames(mtcars)    mpg 
#>  4   3    Toyota Corona       21.5
#>      4    Datsun 710          22.8
#>           Merc 240D           24.4
#>           Merc 230            22.8
#>           Fiat 128            32.4
#>           Honda Civic         30.4
#>           Toyota Corolla      33.9
#>           Fiat X1-9           27.3
#>           Volvo 142E          21.4
#>      5    Porsche 914-2       26.0
#>           Lotus Europa        30.4
#>  6   3    Hornet 4 Drive      21.4
#>           Valiant             18.1
#>      4    Mazda RX4           21.0
#>           Mazda RX4 Wag       21.0
#>           Merc 280            19.2
#>           Merc 280C           17.8
#>      5    Ferrari Dino        19.7
#>  8   3    Hornet Sportabout   18.7
#>           Duster 360          14.3
#>           Merc 450SE          16.4
#>           Merc 450SL          17.3
#>           Merc 450SLC         15.2
#>           Cadillac Fleetwood  10.4
#>           Lincoln Continental 10.4
#>           Chrysler Imperial   14.7
#>           Dodge Challenger    15.5
#>           AMC Javelin         15.2
#>           Camaro Z28          13.3
#>           Pontiac Firebird    19.2
#>      5    Ford Pantera L      15.8
#>           Maserati Bora       15.0
    
rownum <- with(mtcars, RowNum(list(cyl, gear)))
tabular(Factor(cyl)*Factor(gear)*I(rownum) ~
        mpg * AllObs(mtcars, within = list(cyl, gear, rownum)), 
        data=mtcars)
#>                                   
#>  cyl gear mpg                     
#>  4   3    21.5                    
#>      4    22.8 24.4 22.8 32.4 30.4
#>           33.9 27.3 21.4          
#>      5    26.0 30.4               
#>  6   3    21.4 18.1               
#>      4    21.0 21.0 19.2 17.8     
#>      5    19.7                    
#>  8   3    18.7 14.3 16.4 17.3 15.2
#>           10.4 10.4 14.7 15.5 15.2
#>           13.3 19.2               
#>      5    15.8 15.0               
```
