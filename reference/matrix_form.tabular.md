# Transform tabular object to matrices printable by formatters package

The formatters package provides methods for displaying and breaking up
tables into smaller pieces.

## Usage

``` r
matrix_form.tabular(df)
```

## Arguments

- df:

  A tabular object.

## Details

The formatters package provides a `matrix_form` generic function for S4
objects. `"tabular"` objects are S3 objects, so it won't dispatch to
this function, which must be fully specified when called.

## Author

Duncan Murdoch with help from Gabe Becker.

## Examples

``` r
if (requireNamespace("formatters")) {
  Sex <- factor(sample(c("Male", "Female"), 100, replace = TRUE))
  Status <- factor(sample(c("low", "medium", "high"), 100, replace = TRUE))
  z <- rnorm(100) + 5
  fmt <- function(x) {
  s <- format(x, digits=2)
  even <- ((1:length(s)) %% 2) == 0
  s[even] <- sprintf("(%s)", s[even])
  s
}
  tab <- tabular( Justify(c)*Heading()*z*Sex*Heading(Statistic)*Format(fmt())*(mean+sd) 
                  ~ Status )
  mform <- matrix_form.tabular(tab)
  page <- 1
  cat("Page ", page, " Full table\n\n")
  cat(formatters::toString(mform))
  
  # This shows automatic pagination, breaking up the
  # table by rows
  byrow <- formatters::pag_indices_inner(formatters::mf_rinfo(mform),
                              rlpp = 2,
                              min_siblings = 1)
  for (i in seq_along(byrow)) {
    mform2 <- matrix_form.tabular(tab[byrow[[i]], ])
    page <- page + 1
    cat("\nPage ", page, " Rows", byrow[[i]], "\n\n")
    cat(formatters::toString(mform2))
  }
  
  # This gives the breaks by columns, counting the
  # row label columns.  
  # The formatters::vert_pag_indices function had an incompatible
  # change in v0.5.8
  if ("fontspec" %in% names(formals(formatters::vert_pag_indices)))
    bycol <- formatters::vert_pag_indices(mform, cpp = 30,  rep_cols = 2,
                                        fontspec = NULL)
  else
    bycol <- formatters::vert_pag_indices(mform, cpp = 30,  rep_cols = 2)
  # Display the table with both kinds of breaks
  for (i in seq_along(byrow)) {
    rows <- byrow[[i]]
    for (j in seq_along(bycol)) {
      cols <- bycol[[j]]
      cols <- cols[cols > 2] - 2  # cols includes the row labels
      mform3 <- matrix_form.tabular(tab[rows, cols, drop = FALSE])
      page <- page + 1
      cat("\nPage ", page, "Rows", rows, "column", cols, "\n\n")
      cat(formatters::toString(mform3))
    }
  }
}
#> Loading required namespace: formatters
#> Page  1  Full table
#> 
#>                          Status         
#>                  high     low     medium
#> ————————————————————————————————————————
#> Female   mean    5.00     4.95     4.84 
#>           sd    (0.81)   (0.98)   (0.73)
#>  Male    mean    5.01     5.02     5.08 
#>           sd    (1.23)   (0.85)   (1.19)
#> 
#> Page  2  Rows 1 2 
#> 
#>                          Status         
#>                  high     low     medium
#> ————————————————————————————————————————
#> Female   mean    5.00     4.95     4.84 
#>           sd    (0.81)   (0.98)   (0.73)
#> 
#> Page  3  Rows 3 4 
#> 
#>                        Status         
#>                high     low     medium
#> ——————————————————————————————————————
#> Male   mean    5.01     5.02     5.08 
#>         sd    (1.23)   (0.85)   (1.19)
#> 
#> Page  4 Rows 1 2 column 1 
#> 
#>                 Status
#>                  high 
#> ——————————————————————
#> Female   mean    5.00 
#>           sd    (0.81)
#> 
#> Page  5 Rows 1 2 column 2 
#> 
#>                 Status
#>                  low  
#> ——————————————————————
#> Female   mean    4.95 
#>           sd    (0.98)
#> 
#> Page  6 Rows 1 2 column 3 
#> 
#>                 Status
#>                 medium
#> ——————————————————————
#> Female   mean    4.84 
#>           sd    (0.73)
#> 
#> Page  7 Rows 3 4 column 1 
#> 
#>               Status
#>                high 
#> ————————————————————
#> Male   mean     5.0 
#>         sd    (1.2) 
#> 
#> Page  8 Rows 3 4 column 2 
#> 
#>               Status
#>                low  
#> ————————————————————
#> Male   mean    5.02 
#>         sd    (0.85)
#> 
#> Page  9 Rows 3 4 column 3 
#> 
#>               Status
#>               medium
#> ————————————————————
#> Male   mean     5.1 
#>         sd    (1.2) 
```
