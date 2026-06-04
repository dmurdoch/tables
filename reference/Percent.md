# Pseudo-function to compute a statistic relative to a reference set.

The `Percent` pseudo-function is used to specify a statistic that
depends on other values in the table.

## Usage

``` r
Percent(denom = "all", fn = percent)
```

## Arguments

- denom:

  How the reference set (the denominator in case of a percentage
  calculation) should be calculated. See below.

- fn:

  The two argument function to calculate the statistic.

## Details

The function `fn` will be called with two arguments. The first argument
is the usual “value vector” of values corresponding to this cell in the
table, and the second is another vector of reference values, determined
by `denom`.

The default value of `fn` is the `percent` function, defined as
`function(x, y) 100*length(x)/length(y)`. This gives the ratio of the
number of values in the current cell relative to the reference values,
expressed as a percentage. Using `fn = function(x, y) 100*sum(x)/sum(y)`
would give the percentage of the sum of the values in the current cell
to the sum in the reference set.

With the default `denom = "all"`, all values of the analysis variable in
the dataset are used as the reference. Other possibilities are
`denom = "row"` or `denom = "col"`, for which the values of the variable
corresponding to the current row or column subset are used.

The special syntax `denom = Equal(...)` will record each expression in
`...`. The reference set will be the cases with equal values of all
expressions in `...` to those of the current cell. The similar form
`denom = Unequal(...)` sets the reference values to be those that differ
in any of the `...` expressions from the current cell. (In fact, these
can be used somewhat more generally; see the vignette for details.)

Finally, other possible `denom` values are a logical vector, in which
case the values marked `TRUE` are used, or anything else, which will be
passed to `fn` as `y` without any subsetting. (To pass a variable with
subsetting, use the
[`Arguments`](https://dmurdoch.github.io/tables/reference/Arguments.md)
pseudo-function instead.)

## Pseudo-functions

`Percent` is a “pseudo-function”: it takes the form of a function call,
but is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).
`Equal` and `Unequal` are also pseudo-functions, but are only special
when used in the `denom` argument to `Percent`.

## See also

[`Arguments`](https://dmurdoch.github.io/tables/reference/Arguments.md)
for a different way to specify a multiple argument analysis function.

## Examples

``` r
x <- factor(sample(LETTERS[1:2], 1000, replace = TRUE))
y <- factor(sample(letters[3:4], 1000, replace = TRUE))
z <- factor(sample(LETTERS[5:6], 1000, replace = TRUE))

# These both do the same thing:
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(RowPct=Percent("row"))))
#>                                           
#>          z                                
#>          E          F          All        
#>  x   y   All RowPct All RowPct All  RowPct
#>  A   c   118 50.64  115 49.36   233 100   
#>      d   139 54.30  117 45.70   256 100   
#>      All 257 52.56  232 47.44   489 100   
#>  B   c   132 50.77  128 49.23   260 100   
#>      d   127 50.60  124 49.40   251 100   
#>      All 259 50.68  252 49.32   511 100   
#>  All c   250 50.71  243 49.29   493 100   
#>      d   266 52.47  241 47.53   507 100   
#>      All 516 51.60  484 48.40  1000 100   
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(xyPct=Percent(Equal(x, y)))))
#>                                        
#>          z                             
#>          E         F         All       
#>  x   y   All xyPct All xyPct All  xyPct
#>  A   c   118 50.64 115 49.36  233 100  
#>      d   139 54.30 117 45.70  256 100  
#>      All 257 52.56 232 47.44  489 100  
#>  B   c   132 50.77 128 49.23  260 100  
#>      d   127 50.60 124 49.40  251 100  
#>      All 259 50.68 252 49.32  511 100  
#>  All c   250 50.71 243 49.29  493 100  
#>      d   266 52.47 241 47.53  507 100  
#>      All 516 51.60 484 48.40 1000 100  
```
