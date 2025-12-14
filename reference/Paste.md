# Generate terms to paste values together in table.

This function generates a component of a table formula to output
multiple columns with punctuation between. It is designed only for LaTeX
output.

## Usage

``` r
Paste(..., head, digits=2, justify="c", prefix="", sep="", postfix="",
      character.only = FALSE)
```

## Arguments

- ...:

  Expressions to be displayed in the columns of the table. If they are
  named, they will get those names as headings, otherwise they will not
  be labelled.

- head:

  If not missing, this will be used as a column heading for the combined
  columns.

- digits:

  Will be passed to the [`format`](https://rdrr.io/r/base/format.html)
  function. If `digits` is length one, all expressions use a common
  format; otherwise they are formatted separately.

- justify:

  One or more justifications to use on the individual columns.

- sep:

  One or more separators to use between columns.

- prefix, postfix:

  Additional text to insert before and after the group of columns.

- character.only:

  If `TRUE`, the `head` argument will be interpreted as an expression
  evaluating to a character value.

## Value

An expression which will produce the requested output in LaTeX.

## Examples
