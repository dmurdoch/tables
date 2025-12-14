# Use a variable as a factor to give rows in a table.

The functions take a variable and treat it as a factor in a table.
`RowFactor` is designed for LaTeX output, adding extra spacing to make
the table more readable. `Multicolumn` also works only in LaTeX, and
displays the label in a style with the level on a line by itself,
spanning multiple columns.

## Usage

``` r
Factor(x, name = deparse(expr), levelnames = levels(x), 
       texify = getOption("tables.texify", FALSE), 
       expr = substitute(x), override = TRUE)
RowFactor(x, name = deparse(expr), 
    levelnames = levels(x), 
          spacing = 3, space = 1, suppressfirst = TRUE,
          nopagebreak = "\\nopagebreak ",
          texify = getOption("tables.texify", FALSE), 
          expr = substitute(x),
          override = TRUE)
Multicolumn(x, name = deparse(expr), levelnames = levels(x), 
            width=2, first=1, justify="l",
            texify = getOption("tables.texify", FALSE), 
            expr = substitute(x),
            override = TRUE)
```

## Arguments

- x:

  A variable to be treated as a factor.

- name:

  The display name for the factor.

- levelnames:

  The strings to use as levels of `x`.

- texify:

  If `TRUE`, characters that would be interpreted specially by LaTeX are
  escaped (using
  [`latexTranslate`](https://rdrr.io/pkg/Hmisc/man/latex.html)) so they
  will print properly.

- expr:

  The expression to use in evaluating the factor. Generally the same as
  the expression passed as `x`, but internal uses may differ.

- override:

  Should the name for the factor override any previously specified
  [`Heading()`](https://dmurdoch.github.io/tables/reference/Heading.md)
  setting?

- spacing:

  Extra spacing will be added before every `spacing` lines.

- space:

  How much extra space to add, in `ex` units.

- suppressfirst:

  Whether to suppress the spacing in the first group.

- nopagebreak:

  LaTeX macro to insert to suppress page breaks except between groups.

- width:

  How many columns should the label span?

- first:

  Which is the first column in which this label appears?

- justify:

  How should the label be justified in the columns?

## Value

Language to insert into the table formula to achieve the desired table.

## Examples

``` r
tabular( Factor(1:10, "row") ~
       All(iris[1:10,])*Heading()*identity )
#>                                                       
#>  row Sepal.Length Sepal.Width Petal.Length Petal.Width
#>  1   5.1          3.5         1.4          0.2        
#>  2   4.9          3.0         1.4          0.2        
#>  3   4.7          3.2         1.3          0.2        
#>  4   4.6          3.1         1.5          0.2        
#>  5   5.0          3.6         1.4          0.2        
#>  6   5.4          3.9         1.7          0.4        
#>  7   4.6          3.4         1.4          0.3        
#>  8   5.0          3.4         1.5          0.2        
#>  9   4.4          2.9         1.4          0.2        
#>  10  4.9          3.1         1.5          0.1        
toLatex( tabular( RowFactor(1:10, "", 5)  ~ 
       All(iris[1:10,])*Heading()*identity )) 
#> \begin{tabular}{lcccc}
#> \hline
#>   & Sepal.Length & Sepal.Width & Petal.Length & \multicolumn{1}{c}{Petal.Width} \\ 
#> \hline
#> \nopagebreak 5  & $5.1$ & $3.5$ & $1.4$ & $0.2$ \\
#> \nopagebreak NA  & $4.9$ & $3.0$ & $1.4$ & $0.2$ \\
#> \nopagebreak NA  & $4.7$ & $3.2$ & $1.3$ & $0.2$ \\
#> \rule{0pt}{1.7\normalbaselineskip}NA  & $4.6$ & $3.1$ & $1.5$ & $0.2$ \\
#> \nopagebreak NA  & $5.0$ & $3.6$ & $1.4$ & $0.2$ \\
#> \nopagebreak NA  & $5.4$ & $3.9$ & $1.7$ & $0.4$ \\
#> \rule{0pt}{1.7\normalbaselineskip}NA  & $4.6$ & $3.4$ & $1.4$ & $0.3$ \\
#> \nopagebreak NA  & $5.0$ & $3.4$ & $1.5$ & $0.2$ \\
#> \nopagebreak NA  & $4.4$ & $2.9$ & $1.4$ & $0.2$ \\
#> \rule{0pt}{1.7\normalbaselineskip}NA  & $4.9$ & $3.1$ & $1.5$ & $0.1$ \\
#> \hline 
#> \end{tabular}
```
