
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/dmurdoch/tables/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dmurdoch/tables/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

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
Group <- factor(sample(letters[1:5], 125, rep=TRUE))
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

<table class="Rtable">
 <thead>
 <tr class="center">
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th colspan="2">X</th>
</tr>
 <tr class="center">
  <th>Group</th>
  <th>N</th>
  <th>Mean</th>
  <th>Std Dev</th>
</tr>
 </thead>
 <tbody>
 <tr class="center">
  <th class="left">a</th>
  <td>31</td>
  <td> -6.84</td>
  <td> 82.50</td>
</tr>
 <tr class="center">
  <th class="left">b</th>
  <td>28</td>
  <td> 13.06</td>
  <td> 97.04</td>
</tr>
 <tr class="center">
  <th class="left">c</th>
  <td>17</td>
  <td> -2.24</td>
  <td> 99.71</td>
</tr>
 <tr class="center">
  <th class="left">d</th>
  <td>15</td>
  <td>  4.45</td>
  <td> 98.60</td>
</tr>
 <tr class="center">
  <th class="left">e</th>
  <td>34</td>
  <td>  0.87</td>
  <td> 84.96</td>
</tr>
 </tbody>
 </table>

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
