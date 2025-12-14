# `Format` pseudo-function

`Format` controls the formatting of the cells it applies to. `.Format`
is mainly for internal use.

## Usage

``` r
Format(...)
.Format(n)
```

## Arguments

- ...:

  Arguments to pass to a formatting function, or a call to a formatting
  function.

- n:

  A format number.

## Details

The `Format` pseudo-function changes the formatting of table cells, and
it specifies that all values it applies to will be formatted together.

In the first form, the “call” to `Format` looks like a call to `format`,
but without specifying the argument `x`. When
[`tabular()`](https://dmurdoch.github.io/tables/reference/tabular.md)
formats the output it will construct `x` from the entries in the table
governed by the `Format()` specification, and pass it to the standard
[`format`](https://rdrr.io/r/base/format.html) function along with the
other arguments.

In the second form, the “call” to `Format` contains a call to a function
to do the formatting. Again, an argument `x` will be added to the call,
containing the values to be formatted.

In the first form, or if the explicit function is named `format`, any
cells in the table with character values will not be formatted. This is
done so that a column can have mixed numeric and character values, and
the numerics are not converted to character before formatting.

The pseudo-function `.Format` is mainly intended for internal use. It
takes a single integer argument, saying that data governed by this call
uses the same formatting as the format specification indicated by the
integer. In this way entries can be commonly formatted even when they
are not contiguous. The integers are assigned sequentially as the format
specification is parsed; users will likely need trial and error to find
the right value in a complicated table with multiple formats.

## Pseudo-functions

This is a “pseudo-function”: it takes the form of a function call, but
is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## Examples

``` r
# Using the first form
tabular( (Sepal.Length+Sepal.Width) ~ 
         Format(digits=2)*(mean + sd), data=iris )
#>                        
#>               mean sd  
#>  Sepal.Length 5.84 0.83
#>  Sepal.Width  3.06 0.44
         
# The same table, using the second form
tabular( (Sepal.Length+Sepal.Width) ~ 
         Format(format(digits=2))*(mean + sd), data=iris )
#>                        
#>               mean sd  
#>  Sepal.Length 5.84 0.83
#>  Sepal.Width  3.06 0.44
```
