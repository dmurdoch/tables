# Write table to file in CSV or other format.

This writes the formatted table into a CSV or other delimeted file, for
import into a spreadsheet or other report writer.

## Usage

``` r
write.csv.tabular(x, file="", 
    justification = "n", row.names=FALSE, ...)
write.table.tabular(x, file="", 
    justification = "n", row.names=FALSE, col.names=FALSE, ...)
```

## Arguments

- x:

  An object from
  [`tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

- file:

  A filename or connection to which to write.

- justification:

  Parameter to pass to
  [`format.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md).

- row.names, col.names:

  Parameters to pass to
  [`write.csv`](https://rdrr.io/r/utils/write.table.html) or
  [`write.table`](https://rdrr.io/r/utils/write.table.html)

- ...:

  Parameters to pass to
  [`format.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md)
  or [`write.table`](https://rdrr.io/r/utils/write.table.html); see
  Details below.

## Details

`write.csv.tabular` writes a simple version of the table (similar to
what is produced by
[`print.tabular`](https://dmurdoch.github.io/tables/reference/tabular.md))
to the given connection in CSV format, using
[`write.csv`](https://rdrr.io/r/utils/write.table.html).
`write.table.tabular` does similarly using the more general
[`write.table`](https://rdrr.io/r/utils/write.table.html).

The optional arguments in `...` are sent to `write.csv/write.table` if
their names exactly match parameters to `write.table`; otherwise, they
are sent to `format.tabular`.

## Value

The return value from
[`write.csv`](https://rdrr.io/r/utils/write.table.html) or
[`write.table`](https://rdrr.io/r/utils/write.table.html).

## Examples

``` r
if (FALSE) { # \dontrun{
# This writes a table to the clipboard on Windows using tab delimiters, for
# easy import into a spreadsheet.

write.table.tabular( 
    tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris ),
    "clipboard", sep="\t")
} # }    
```
