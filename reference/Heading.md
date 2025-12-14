# `Heading` pseudo-function

The `Heading` pseudo-function normally overrides the automatic heading
on the following items in a table. Setting `override=FALSE` is used in
automatically generated expressions.

## Usage

``` r
Heading(name = NULL, override = TRUE, character.only = FALSE, nearData = TRUE)
```

## Arguments

- name:

  A legal R variable name, or a character constant.

- override:

  Whether this heading should override one that is already present.

- character.only:

  If `TRUE`, the `name` argument will be interpreted as an expression
  evaluating to a character value.

- nearData:

  See Details below.

## Details

This replaces the automatic heading or row label on the following item
with the `name` or string as specified. If no argument is given, the
heading or label is suppressed.

An alternative form of `Heading(name)` is `(name=...)`, where `...` is
an expression to be displayed in the table.

If `override = FALSE`, the label is only supplied if there is no other
label. This is used in the code for
[`Factor`](https://dmurdoch.github.io/tables/reference/RowFactor.md).

The `nearData` argument is rarely used. It affects the situation where
`"+"` is used to join tables with different numbers of labels. If
`nearData = TRUE` (the default), the shorter list of labels are pushed
close to the data, i.e. to the right side for row labels, the bottom for
column labels. If `FALSE`, they are pushed to the opposite side.

## Pseudo-functions

This is a “pseudo-function”: it takes the form of a function call, but
is never actually called: it is handled specially by
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

## Examples

``` r
tabular( (Sepal.Length+Sepal.Width) ~ 
         (Heading(Mean)*mean + (S.D.=sd)), data=iris )
#>                           
#>               Mean  S.D.  
#>  Sepal.Length 5.843 0.8281
#>  Sepal.Width  3.057 0.4359

heading <- "Variable Heading"
tabular( (Sepal.Length+Sepal.Width) ~ 
         (Heading(heading, character.only = TRUE)*mean + (S.D.=sd)), 
         data=iris )
#>                                      
#>               Variable Heading S.D.  
#>  Sepal.Length 5.843            0.8281
#>  Sepal.Width  3.057            0.4359
```
