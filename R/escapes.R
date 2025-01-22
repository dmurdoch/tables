texify <- function(x) {
  # Based on knitr function
  x <- gsub("\\\\", "\\\\textbackslash", x)
  x <- gsub("([#$%&_{}])", "\\\\\\1", x)
  x <- gsub("\\\\textbackslash", "\\\\textbackslash{}", x)
  x <- gsub("~", "\\\\textasciitilde{}", x)
  x <- gsub("\\^", "\\\\textasciicircum{}", x)
  x
}

htmlify <- function (x)
  # Taken from the tools package
{
  fsub <- function(pattern, replacement, x)
    gsub(pattern,
         replacement,
         x,
         fixed = TRUE,
         useBytes = TRUE)
  
  x <- fsub("&", "&amp;", x)
  x <- fsub("---", "&mdash;", x)
  x <- fsub("--", "&ndash;", x)
  x <- fsub("``", "&ldquo;", x)
  x <- fsub("''", "&rdquo;", x)
  x <- gsub("`([^']+)'",
            "&lsquo;\\1&rsquo;",
            x,
            perl = TRUE,
            useBytes = TRUE)
  x <- fsub("`", "'", x)
  x <- fsub("<", "&lt;", x)
  x <- fsub(">", "&gt;", x)
  x <- fsub("\"\\{\"", "\"{\"", x)
  x <- fsub("\"", "&quot;", x)
  x
}
