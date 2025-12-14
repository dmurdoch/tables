# `Arguments` pseudo-function

The `Arguments` pseudo-function enables the use of analysis functions
that take multiple arguments.

## Usage

``` r
Arguments(...)
```

## Arguments

- ...:

  Arguments to pass to the analysis function.

## Details

The arguments to `Arguments` are evaluated in full, then those which are
length `n` are subsetted for each cell in the table.

If no analysis variable has been specified, but `Arguments()` has been,
then the analysis function will be called with arguments matching those
given in `...`. If an analysis variable was specified, it will be
inserted as an unnamed first argument to the analysis function.

The `Arguments()` entry will not create a heading.

Only one `Arguments()` specification may be active in any term in the
tabular formula.

## Pseudo-functions

This is a “pseudo-function”: it takes the form of a function call, but
is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## See also

[`Percent`](https://dmurdoch.github.io/tables/reference/Percent.md) for
a different way to specify a multiple argument analysis function.

## Examples

``` r
# This is the example from the weighted.mean help page
wt <- c(5,  5,  4,  1)/15
x <- c(3.7,3.3,3.5,2.8)
gp <- c(1,1,2,2)
tabular( (Factor(gp) + 1) 
    ~ weighted.mean*x*Arguments(w = wt) )
#>                   
#>      weighted.mean
#>  gp  x            
#>  1   3.500        
#>  2   3.360        
#>  All 3.453        
```
