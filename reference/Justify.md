# `Justify` pseudo-function

The `Justify` pseudo-function sets the justification of the following
items in the table.

## Usage

``` r
Justify(labels, data=labels)
```

## Arguments

- labels:

  Justification to use for labels

- data:

  Justification to use for data.

## Details

The justification can be an R name if that is syntactically valid, or a
quoted string.

## Pseudo-functions

This is a “pseudo-function”: it takes the form of a function call, but
is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## Examples

``` r
tabular( Justify(c,l)*Heading(Var)*(Sepal.Length+Sepal.Width) ~ 
         Justify(c)*(mean + sd), data=iris )
#>                           
#>      Var      mean    sd  
#>  Sepal.Length 5.843 0.8281
#>  Sepal.Width  3.057 0.4359
```
