# Process numeric LaTeX or HTML values.

This takes formatted strings as produced by
[`format`](https://rdrr.io/r/base/format.html) from numeric values, and
modifies them to LaTeX or HTML code that retains the spacing, and
renders minus signs properly. The default formatting in
[`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md) uses
this to maintain proper alignment.

## Usage

``` r
latexNumeric(chars, minus = TRUE, leftpad = TRUE, rightpad = TRUE, mathmode = TRUE)
htmlNumeric(chars, minus = TRUE, leftpad = TRUE, rightpad = TRUE)
```

## Arguments

- chars:

  A character vector of numeric values.

- minus:

  Whether to pad cases with no minus sign with spacing of the same
  width.

- leftpad,rightpad:

  Whether to pad cases that have leading or trailing blanks with spacing
  matching a digit width per space.

- mathmode:

  Whether to wrap the result in dollar signs, so LaTeX renders minus
  signs properly.

## Value

A character vector of the same length as `chars`, with modifications to
render properly in LaTeX.

## Examples

``` r
latexNumeric(format(c(1.1,-1,10,-10)))
#> [1] "$\\phantom{0}\\phantom{-}1.1$" "$\\phantom{0}-1.0$"           
#> [3] "$\\phantom{-}10.0$"            "$-10.0$"                      
htmlNumeric(format(c(1.1,-1,10,-10)))
#> [1] "&#x2007;&#x2007;1.1" "&#x2007;&minus;1.0"  "&#x2007;10.0"       
#> [4] "&minus;10.0"        
```
