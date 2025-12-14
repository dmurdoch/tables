# Compute complex table

Computes a table of summary statistics, cross-classified by various
variables.

## Usage

``` r
tabular(table, ...)
# Default S3 method
tabular(table, ...)
# S3 method for class 'formula'
tabular(table, data = NULL, n, suppressLabels = 0, ...)
# S3 method for class 'tabular'
print(x, justification="n", ...)
# S3 method for class 'tabular'
format(x, digits=4, justification="n", latex=FALSE, html=FALSE, 
                         leftpad = TRUE, rightpad = TRUE, minus = TRUE, 
       mathmode = TRUE, ...)
# S3 method for class 'tabular'
x[i, j, ..., drop = FALSE]
# S3 method for class 'tabular'
cbind(..., deparse.level = 1)
# S3 method for class 'tabular'
rbind(..., deparse.level = 1)
```

## Arguments

- table:

  A table expression. See the Details below.

- data:

  An optional dataframe, list or environment in which to look for
  variables in the table.

- n:

  An optional value giving the length of the data. See the Details
  below.

- suppressLabels:

  How many initial labels to suppress?

- x:

  The object to print, format, or subset.

- digits, ...:

  In the print and format methods, how many significant digits or other
  parameters to show by default? See Formatting below.

- justification:

  The default justification to use in the table.

- latex:

  If `TRUE`, the
  [`latexNumeric`](https://dmurdoch.github.io/tables/reference/latexNumeric.md)
  function will be applied when formatting numeric columns after
  [`format`](https://rdrr.io/r/base/format.html), to maintain spacing
  and handle signs properly.

- html:

  If `TRUE`, the
  [`htmlNumeric`](https://dmurdoch.github.io/tables/reference/latexNumeric.md)
  function will be applied when formatting numeric columns after
  [`format`](https://rdrr.io/r/base/format.html), to maintain spacing
  and handle signs properly.

- leftpad, rightpad, minus, mathmode:

  Options to pass to
  [`latexNumeric`](https://dmurdoch.github.io/tables/reference/latexNumeric.md)
  or
  [`htmlNumeric`](https://dmurdoch.github.io/tables/reference/latexNumeric.md)
  to control details of formatting. See those pages for details.

- i, j, drop:

  The usual arguments for matrix indexing, but see the Details below.

- deparse.level:

  Ignored. (Present because the generic requires it.)

## Details

For the purposes of this function, a "table" is a rectangular array of
values, computed using a formula expression. The left hand side of the
formula describes the rows of the table, the right hand side describes
the columns.

Within the expression for the rows or columns, the operators `+`, `*`
and `=` have special meanings.

The `+` operator represents concatenation, so that `x + y ~ z` says to
show the rows corresponding to `x` above the rows corresponding to `y`.

The `*` operator represents nesting, so that `x*y ~ z` says to show the
rows of `y` within each row corresponding to `x`.

The `=` operator sets a new name for a term; it is an abbreviation for
the
[`Heading()`](https://dmurdoch.github.io/tables/reference/Heading.md)
pseudo-function. (“Pseudo-functions” are described in the `tables`
vignette.) Note that `=` has low operator precedence and may be confused
by the parser with setting function arguments, so parentheses are
usually needed.

Parentheses may be used to group terms in the usual arithmetic way, so
`(x + y)*(u + v)` is equivalent to `x*u + x*v + y*u + y*v`.

The names `Format`, `.Format` and `Heading` have special meaning; see
the section on Formatting below.

The interpretation of other terms in the formulas depends on how they
evaluate.

If the term evaluates to a function, it should be a summary function
that produces a scalar value when applied to a vector of values, and
that scalar will be displayed in the table. For example,
` (mean + var) ~ x ` will display the mean of `x` above the variance of
`x`. If no function is specified, `length` is assumed, so the table will
display counts. (At most one summary function may be specified in any
one term, so `mean*var` would be an error.)

If the term evaluates to a logical vector, it is assumed to specify a
subset. For example, ` ~ (x > 3) + (x > 5)` will tabulate the counts of
those two subsets.

If the term evaluates to a factor, it generates multiple rows or
columns, corresponding to the different levels of the factor. For
example if `A` has three levels, then `A ~ mean*x` will calculate the
mean of `x` within each level of `A`.

If the term evaluates to a language object, it is treated as a macro,
and expanded in place in the formula.

Other terms are assumed to be R expressions producing a vector of values
to be summarized in the table. Only one vector of values can be
specified in any given term, but different terms can summarize different
values. [`is.atomic`](https://rdrr.io/r/base/is.recursive.html) must
evaluate to `TRUE` for these values for them to be recognized.

All logical, factor or other values in the table should be the same
length, as if they were columns in a dataframe (but they can be computed
values). If `n` is missing but `data` is a dataframe, `n` is set from
that. Otherwise, if terms such as `1` appear in a table, the length is
assumed to be the same as for previous terms. As a last resort, set the
`n` argument in the call to `tabular()` explicitly.

The `"["` method extracts a subset of the table. For indexing, consider
the table to consist of a matrix containing the values. If `drop=TRUE`,
the labels and attributes are dropped. If `drop=FALSE`, the default, the
`i` and `j` indices must select a rectangular block of the table; matrix
indexing (using a two column matrix or a full matrix of logical values)
is not supported.

## Formatting

The `tabular()` function does no formatting of computed values, but it
records requests for formatting. The `format.tabular()`,
`print.tabular()` and
[`latex.tabular()`](https://dmurdoch.github.io/tables/reference/latex.tabular.md)
functions make use of these requests.

By default, columns are formatted using the
[`format`](https://rdrr.io/r/base/format.html) function, with arguments
`digits` and any other arguments passed in `...`. Each column is
formatted separately, similarly to how a matrix is printed by default.

To request special formatting, four pseudo-functions are provided. The
first is `Format`. Normally it includes arguments to pass to the
[`format()`](https://rdrr.io/r/base/format.html) function, e.g.
`Format(digits=2)`. It may instead include a call to a function, e.g.
`Format(sprintf("%.2f")`. In either case the summary values from cells
in the table that are nested below the `Format` specification will be
passed to that function in an argument named `x`, i.e. in the first
example, the values would be formatted using
`format(digits=2, x=values)`, and in the second, using
`sprintf("%.2f", x=values)`. Users can supply their own function to be
used for formatting; it should take values in a named argument `x` and
return a character vector of the same length.

This can be used to control formatting in multiple columns at once. For
example, `Format(digits=2)*(mean + sd)` will print both the mean and
standard deviation in a single call to
[`format`](https://rdrr.io/r/base/format.html), guaranteeing that the
same number of decimal places is used in both. (The `iris` example below
demonstrates this.)

If the `latex` argument to `latex.tabular` is `TRUE`, then an effort is
made to retain spacing, and to convert minus signs to the appropriate
type of dash using the
[`latexNumeric`](https://dmurdoch.github.io/tables/reference/latexNumeric.md)
function.

The second pseudo-function `.Format` is mainly intended for internal
use. It takes a single integer argument, saying that data governed by
this call uses the same formatting as another format specification. In
this way entries can be commonly formatted even when they are not
contiguous. The integers are assigned sequentially as the format
specification is parsed; users will likely need trial and error to find
the right value in a complicated table with multiple formats.

A third pseudo-function is `Justify`. It takes character values or names
as arguments; how they are treated depends on the output format. In
`format.tabular`, coarse justification is done to left, right or center,
using `l`, `r` or `c` respectively. For LaTeX formatting, any string
acceptable as a justification string to LaTeX will be passed on.

A final pseudo-function is `Heading`. Use this function in the row
definitions to set a heading on the following column of row labels.
(Internally this is how the headings on factor columns are implemented.)
If it is called with no argument, it suppresses the following heading.
The `suppressLabels=n` argument to `tabular()` is equivalent to
repeating
[`Heading()`](https://dmurdoch.github.io/tables/reference/Heading.md)
`n` times at the start of the table formula. The `=` operator is an
abbreviation for
[`Heading()`](https://dmurdoch.github.io/tables/reference/Heading.md);
see above.

## `tabular` methods

The default `tabular` method just applies
[`as.formula`](https://rdrr.io/r/stats/formula.html) to `table`, and
then calls `tabular.formula`.

The `tabular.formula` method is the main workhorse of the package. Other
authors who wish to produce tables directly from their own structures
should normally create a formula whose environment contains all
mentioned variables and call `tabular.formula` with appropriate
arguments.

## Value

An object of S3 class `"tabular"`. This is a matrix of mode list, whose
entries are computed summary values, with the following attributes:

- rowLabels:

  A matrix of labels for the rows. This will have the same number of
  rows as the main matrix, but may have multiple columns for different
  nested levels of labels. If a label covers multiple rows, it is
  entered in the first row, and `NA` is used to fill following rows.

- colLabels:

  Like `rowLabels`, but labelling the columns.

- table:

  The original table expression being displayed. A list of the original
  format specifications are attached as a `"fmtlist"` attribute.

- formats:

  A matrix of the same shape as the main result, containing `NA` for
  default formatting, or an index into the format list.

## References

This function was inspired by my 20 year old memories of the SAS
TABULATE procedure.

## Author

Duncan Murdoch

## See also

[`table`](https://rdrr.io/r/base/table.html) and
[`ftable`](https://rdrr.io/r/stats/ftable.html) are base R functions
which produce tables of counts. The `tables` vignette has many more
examples and displays the formatted output.

## Examples

``` r
tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
#>                                                   
#>                 Sepal.Length      Sepal.Width     
#>  Species    n   mean         sd   mean        sd  
#>  setosa      50 5.01         0.35 3.43        0.38
#>  versicolor  50 5.94         0.52 2.77        0.31
#>  virginica   50 6.59         0.64 2.97        0.32
#>  All        150 5.84         0.83 3.06        0.44

# This example shows some of the less common options         
Sex <- factor(sample(c("Male", "Female"), 100, replace = TRUE))
Status <- factor(sample(c("low", "medium", "high"), 100, replace = TRUE))
z <- rnorm(100)+5
fmt <- function(x) {
  s <- format(x, digits=2)
  even <- ((1:length(s)) %% 2) == 0
  s[even] <- sprintf("(%s)", s[even])
  s
}
tab <- tabular( Justify(c)*Heading()*z*Sex*Heading(Statistic)*Format(fmt())*(mean+sd) 
                ~ Status )
tab
#>                                       
#>                   Status              
#>   Sex   Statistic  high   low   medium
#>  Female   mean     4.90   5.42   5.40 
#>            sd     (0.91) (1.21) (1.03)
#>   Male    mean     4.98   4.84   5.07 
#>            sd     (1.08) (1.30) (1.25)
tab[1:2, c(2,3,1)]
#>                                       
#>                   Status              
#>   Sex   Statistic  low   medium  high 
#>  Female   mean     5.42   5.40   4.90 
#>            sd     (1.21) (1.03) (0.91)
```
