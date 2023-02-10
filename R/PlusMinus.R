PlusMinus <- function(x, y, head, xhead, yhead, digits=2, character.only = FALSE, 
		      ...) {
    head <- getHeading(head, substitute(head), character.only)
    xhead <- getHeading(xhead, substitute(xhead), character.only)
    yhead <- getHeading(yhead, substitute(yhead), character.only)

    fmt <- function(x){
		 s <- format(x, digits=digits, ...)
		 is_stderr <- (1:length(s)) > length(s) %/% 2
		 s[is_stderr] <- sprintf("$%s$", s[is_stderr])
		 s[!is_stderr] <- latexNumeric(s[!is_stderr])
		 s
	       }
    substitute( head*1*Format(fmt())*(xhead*Justify("r@{}")*x 
                                    + yhead*Justify("@{ $\\pm$ }l")*y),
               list(x=substitute(x), y=substitute(y), 
               head=head, xhead=xhead, yhead=yhead, fmt=fmt))
}
