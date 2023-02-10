knit_print.tabular <- function(x, format = getKnitrFormat(), ...) {
  opts <- table_options()
  if (opts$knit_print) {
    if (format == "latex") {
      return(knitr::asis_output(paste(c(toLatex(x), "\n\n"), collapse="\n")))
    } else if (format == "html") {
      save <- table_options(doHTMLheader = FALSE,
                            doHTMLbody = FALSE)
      id <- if (opts$doCSS) basename(tempfile("table"))
      lines <- toHTML(x, id = id)  
      table_options(save)
      return(knitr::asis_output(lines))
    }
  }
  knitr::normal_print(x)
}
