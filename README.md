
<!-- README.md is generated from README.Rmd. Please edit that file -->

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
#>  Group N  Mean   Std Dev
#>  a     27 -19.30  96.83 
#>  b     32  -2.01 103.11 
#>  c     20 -12.50  71.84 
#>  d     24  -0.25 116.49 
#>  e     22  -5.48  75.51

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
  <td>-19.30</td>
  <td> 96.83</td>
</tr>
 <tr class="center">
  <th class="left">b</th>
  <td>32</td>
  <td> -2.01</td>
  <td>103.11</td>
</tr>
 <tr class="center">
  <th class="left">c</th>
  <td>20</td>
  <td>-12.50</td>
  <td> 71.84</td>
</tr>
 <tr class="center">
  <th class="left">d</th>
  <td>24</td>
  <td> -0.25</td>
  <td>116.49</td>
</tr>
 <tr class="center">
  <th class="left">e</th>
  <td>22</td>
  <td> -5.48</td>
  <td> 75.51</td>
</tr>
 </tbody>
 </table>

``` r

# To generate LaTeX code:
cat(toLatex(tab)$text)
#> \begin{tabular}{lccc}
#> \hline
#>  &  & \multicolumn{2}{c}{X} \\ 
#> Group  & N & Mean & \multicolumn{1}{c}{Std Dev} \\ 
#> \hline
#> a  & $27$ & $\phantom{0}-19.30$ & $\phantom{0}\phantom{-}96.83$ \\
#> b  & $32$ & $\phantom{00}-2.01$ & $\phantom{-}103.11$ \\
#> c  & $20$ & $\phantom{0}-12.50$ & $\phantom{0}\phantom{-}71.84$ \\
#> d  & $24$ & $\phantom{00}-0.25$ & $\phantom{-}116.49$ \\
#> e  & $22$ & $\phantom{00}-5.48$ & $\phantom{0}\phantom{-}75.51$ \\
#> \hline 
#> \end{tabular}
```
