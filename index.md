# tables

The goal of tables is to compute and display complex tables of summary
statistics.

Output may be in LaTeX, HTML, plain text, or an R matrix for further
processing.

## Installation

You can install the release version of `orientlib` using

``` r
install.packages("tables")
```

You can install the development version of tables from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dmurdoch/tables")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tables)

set.seed(123)

# In an R Markdown document, you don't want each table
# to output the HTML document header, so turn 
# off that option:

table_options(htmloptions(head=FALSE))

X <- rnorm(125, sd=100)
Group <- factor(sample(letters[1:5], 125, replace = TRUE))
tab <- tabular( Group ~ 
                  (N=1) +
                  Format(digits=2)*X*
                    ((Mean=mean) +
                     Heading("Std Dev")*sd) 
              )

# To print in plain text:
tab
#>                         
#>           X             
#>  Group N  Mean   Std Dev
#>  a     31  -6.84  82.50 
#>  b     28  13.06  97.04 
#>  c     17  -2.24  99.71 
#>  d     15   4.45  98.60 
#>  e     34   0.87  84.96

# To format in HTML:
toHTML(tab)
```

|       |     | X     |         |
|-------|-----|-------|---------|
| Group | N   | Mean  | Std Dev |
| a     | 31  | -6.84 | 82.50   |
| b     | 28  | 13.06 | 97.04   |
| c     | 17  | -2.24 | 99.71   |
| d     | 15  | 4.45  | 98.60   |
| e     | 34  | 0.87  | 84.96   |

``` r
# To generate LaTeX code:
strsplit(toLatex(tab)$text, "\n")
#> [[1]]
#>  [1] "\\begin{tabular}{lccc}"                                               
#>  [2] "\\hline"                                                              
#>  [3] " &  & \\multicolumn{2}{c}{X} \\\\ "                                   
#>  [4] "Group  & N & Mean & \\multicolumn{1}{c}{Std Dev} \\\\ "               
#>  [5] "\\hline"                                                              
#>  [6] "a  & $31$ & $\\phantom{0}-6.84$ & $\\phantom{-}82.50$ \\\\"           
#>  [7] "b  & $28$ & $\\phantom{-}13.06$ & $\\phantom{-}97.04$ \\\\"           
#>  [8] "c  & $17$ & $\\phantom{0}-2.24$ & $\\phantom{-}99.71$ \\\\"           
#>  [9] "d  & $15$ & $\\phantom{0}\\phantom{-}4.45$ & $\\phantom{-}98.60$ \\\\"
#> [10] "e  & $34$ & $\\phantom{0}\\phantom{-}0.87$ & $\\phantom{-}84.96$ \\\\"
#> [11] "\\hline "                                                             
#> [12] "\\end{tabular}"
```
