
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
#>  Group N  Mean  Std Dev
#>  a     27  14.2  95.1  
#>  b     22   0.2  78.5  
#>  c     31  34.1 100.4  
#>  d     22  12.1 114.5  
#>  e     23  19.8  92.8

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
  <td>27</td>
  <td> 14.2</td>
  <td> 95.1</td>
</tr>
 <tr class="center">
  <th class="left">b</th>
  <td>22</td>
  <td>  0.2</td>
  <td> 78.5</td>
</tr>
 <tr class="center">
  <th class="left">c</th>
  <td>31</td>
  <td> 34.1</td>
  <td>100.4</td>
</tr>
 <tr class="center">
  <th class="left">d</th>
  <td>22</td>
  <td> 12.1</td>
  <td>114.5</td>
</tr>
 <tr class="center">
  <th class="left">e</th>
  <td>23</td>
  <td> 19.8</td>
  <td> 92.8</td>
</tr>
 </tbody>
 </table>


# To generate LaTeX code:
cat(toLatex(tab)$text)
#> \begin{tabular}{lccc}
#> \hline
#>  &  & \multicolumn{2}{c}{X} \\ 
#> Group  & N & Mean & \multicolumn{1}{c}{Std Dev} \\ 
#> \hline
#> a  & $27$ & $\phantom{0}14.2$ & $\phantom{0}95.1$ \\
#> b  & $22$ & $\phantom{00}0.2$ & $\phantom{0}78.5$ \\
#> c  & $31$ & $\phantom{0}34.1$ & $100.4$ \\
#> d  & $22$ & $\phantom{0}12.1$ & $114.5$ \\
#> e  & $23$ & $\phantom{0}19.8$ & $\phantom{0}92.8$ \\
#> \hline 
#> \end{tabular}
