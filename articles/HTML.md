# HTML Tables

This short R Markdown document illustrates how to use `tables` in HTML.

## Initializing

First, you need to load `tables`. Packages that it uses print banner
messages, so you’ll usually want to set a chunk option of
`message=FALSE`.

``` r
library(tables)
```

The table is now constructed in the usual way.

``` r
X <- rnorm(125, sd=100)
Group <- factor(sample(letters[1:5], 125, replace = TRUE))
tab <- tabular( Group ~ (N=1)+Format(digits=2)*X*((Mean=mean) + Heading("Std Dev")*sd) )
```

In an R Markdown document, you don’t want each table to output the HTML
document header, so turn off those options:

``` r
table_options(htmloptions(head=FALSE))
```

## Inserting a Table

There are two ways to insert a table into a knitr/rmarkdown document.
Since tables version 0.8.4, you can just print the object, and it will
be automatically formatted according to the current
[`table_options()`](https://dmurdoch.github.io/tables/reference/table_options.md):

``` r
tab
```

|       |     | X     |         |
|-------|-----|-------|---------|
| Group | N   | Mean  | Std Dev |
| a     | 20  | -30.9 | 88.6    |
| b     | 33  | 4.2   | 130.8   |
| c     | 21  | 37.8  | 97.4    |
| d     | 28  | 15.3  | 107.5   |
| e     | 23  | -1.4  | 67.1    |

The previous behaviour required an explicit call to the
[`toHTML()`](https://dmurdoch.github.io/tables/reference/html.tabular.md)
function, and knitr option `results = 'asis'` for the chunk. To
*require* the older method, use `table_options(knit_print = FALSE)`:

``` r
table_options(knit_print = FALSE)
tab        # This chunk uses the default results = 'markup'
```

    ##                        
    ##           X            
    ##  Group N  Mean  Std Dev
    ##  a     20 -30.9  88.6  
    ##  b     33   4.2 130.8  
    ##  c     21  37.8  97.4  
    ##  d     28  15.3 107.5  
    ##  e     23  -1.4  67.1

``` r
toHTML(tab)  # This chunk uses results = 'asis'
```

|       |     | X     |         |
|-------|-----|-------|---------|
| Group | N   | Mean  | Std Dev |
| a     | 20  | -30.9 | 88.6    |
| b     | 33  | 4.2   | 130.8   |
| c     | 21  | 37.8  | 97.4    |
| d     | 28  | 15.3  | 107.5   |
| e     | 23  | -1.4  | 67.1    |

In either case, some styling information needs to be included in the
document. Ideally this should be in the header, but it can be inserted
anywhere by calling `writeCSS` with `results = 'asis'`:

``` r
writeCSS()
```

## Improving the Look

The default justification makes the columns of numbers look messy. You
can set the justification to the right, but the headers look wrong:

``` r
table_options(htmloptions(head = FALSE, justification = "r", knit_print = TRUE))
tab
```

|       |     | X     |         |
|-------|-----|-------|---------|
| Group | N   | Mean  | Std Dev |
| a     | 20  | -30.9 | 88.6    |
| b     | 33  | 4.2   | 130.8   |
| c     | 21  | 37.8  | 97.4    |
| d     | 28  | 15.3  | 107.5   |
| e     | 23  | -1.4  | 67.1    |

The best look comes with the `pad = TRUE` option. This adds nonbreaking
spaces around the numbers so that centering looks good. It also changes
the hyphens to proper minus signs:

``` r
table_options(htmloptions(head = FALSE, justification = "c", pad = TRUE))
tab
```

|       |     | X      |         |
|-------|-----|--------|---------|
| Group | N   | Mean   | Std Dev |
| a     | 20  |  −30.9 |   88.6  |
| b     | 33  |    4.2 |  130.8  |
| c     | 21  |   37.8 |   97.4  |
| d     | 28  |   15.3 |  107.5  |
| e     | 23  |   −1.4 |   67.1  |

Unfortunately, if you cut this table and paste it into a spreadsheet,
the spaces and minus signs probably won’t be understood. I don’t know
how to get everything we want :-(.

## Fine tuning

This document uses the default CSS from `table_options()$CSS`. If you
are producing an `html_document`, it should be okay. It does not look
quite right in a `slidy_presentation`, and is no good at all in an
`ioslides_presentation`. Furthermore, you might not agree with my design
choices.

In any of these cases, you should substitute your own CSS. You will need
to modify the default one, and can use it as the `CSS` argument to
[`writeCSS()`](https://dmurdoch.github.io/tables/reference/html.tabular.md),
or set it as a new default in
[`table_options()`](https://dmurdoch.github.io/tables/reference/table_options.md).

Here is the default setting:

    <style>
    #ID .Rtable thead, .Rtable .even {
      background-color: inherit;
    }
    #ID .left   { text-align:left; }
    #ID .center { text-align:center; }
    #ID .right  { text-align:right; }
    #ID .Rtable, #ID .Rtable thead {
      border-collapse: collapse;
      border-style: solid;
      border-width: medium 0;
      border-color: inherit;
    }
    #ID .Rtable th, #ID .Rtable td {
      padding-left: 0.5em;
      padding-right: 0.5em;
      border-width: 0;
    }
    </style>

Note that the `#ID` values will be replaced with the `id` string given
in
[`writeCSS()`](https://dmurdoch.github.io/tables/reference/html.tabular.md),
and
[`toHTML()`](https://dmurdoch.github.io/tables/reference/html.tabular.md)
has a corresponding argument to allow you to make changes for one
specific table. If you are using the newer form of display with
`table_options(knit_print = TRUE)`, you can get customized display for
one table by also using `table_options(doCSS = TRUE)`. For example,

``` r
table_options(CSS =
"<style>
#ID .center { 
  text-align:center;
  background-color: aliceblue;
}
</style>", doCSS = TRUE)
tab
```

|       |     | X      |         |
|-------|-----|--------|---------|
| Group | N   | Mean   | Std Dev |
| a     | 20  |  −30.9 |   88.6  |
| b     | 33  |    4.2 |  130.8  |
| c     | 21  |   37.8 |   97.4  |
| d     | 28  |   15.3 |  107.5  |
| e     | 23  |   −1.4 |   67.1  |

``` r
table_options(doCSS = FALSE)
tab
```

|       |     | X      |         |
|-------|-----|--------|---------|
| Group | N   | Mean   | Std Dev |
| a     | 20  |  −30.9 |   88.6  |
| b     | 33  |    4.2 |  130.8  |
| c     | 21  |   37.8 |   97.4  |
| d     | 28  |   15.3 |  107.5  |
| e     | 23  |   −1.4 |   67.1  |

## kableExtra support

The kableExtra package contains a large number of functions to customize
the look of tables generated by the
[`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) function.
These can also be made to work with tables from this package, using the
[`toKable()`](https://dmurdoch.github.io/tables/reference/toKable.md)
function. For example,

``` r
library(magrittr)
library(kableExtra)
toKable(tab, format="html") %>% 
  kable_styling("striped", full_width = FALSE) %>%
  add_header_above(c("Row Label" = 1, "Statistics" = 3)) %>%
  column_spec(4, color = "red") %>%
  row_spec(1, color = "blue") %>%
  group_rows("Subgroup", 3, 5)
```

[TABLE]

There are conflicts between the styling options from `kableExtra` and
the ones specified in `table_options()$CSS`; some modifications might be
needed to make everything work. For instance, the code above requests
striping, but that did not show up. Experimentation may be needed!

## tinytable support

The `tinytable` package is another package which can be used to
customize the look of tables generated by `tables`. A `tinytable` can be
customized, and then printed or saved to a variety of formats,
including: HTML, LaTeX, Word, Typst, PNG, PDF, Rmarkdown, and Quarto.
For example,

``` r
library(magrittr)
library(tinytable)
toTinytable(tab, theme = "striped") %>%
  group_tt(i = list("Subgroup" = 3)) %>%
  group_tt(j = list("Row Label" = 1, "Statistics" = 2:4)) %>%
  style_tt(i = 3, color = "red", align = "c", line = "bt", line_color = "red") %>%
  style_tt(i = 5:6, j = 3:4, background = "black", color = "orange")
```

| Row Label | Statistics |          |          |
|-----------|------------|----------|----------|
|           |            | X        |          |
| Group     | N          | Mean     | Std Dev  |
| a         | 20         | -30.9    | 88.6     |
| b         | 33         | 4.2      | 130.8    |
| Subgroup  | Subgroup   | Subgroup | Subgroup |
| c         | 21         | 37.8     | 97.4     |
| d         | 28         | 15.3     | 107.5    |
| e         | 23         | -1.4     | 67.1     |
