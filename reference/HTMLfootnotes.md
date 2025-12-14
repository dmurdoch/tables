# Construct footnotes

This function constructs HTML code for footnotes to insert at the bottom
of the table.

## Usage

``` r
HTMLfootnotes(tab, ...)
```

## Arguments

- tab:

  A tabular object, used only so that the column width of the footnotes
  matches.

- ...:

  The footnotes. If named, will be preceded with the name as a
  superscript.

## Value

A character string containing HTML code for the footnotes. Use this in
[`table_options`](https://dmurdoch.github.io/tables/reference/table_options.md)`(HTMLfooter = ...)`

## Examples

``` r
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
footnote <- HTMLfootnotes(tab, 
                          "This is a footnote with no marker.", 
                          "*" = "This is a footnote with an asterisk.")
if (interactive())
  toHTML(tab, options = list(doFooter = TRUE,
                           HTMLfooter = footnote))
```
