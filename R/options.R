HTMLheaderdefault <- '<!DOCTYPE html>
<html>
<head>
<meta charset="CHARSET">
'

CSSdefault <- '<style>
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
'

table_options <- local({
    opts <- list(justification="c",
    		 rowlabeljustification="l",
    		 tabular="tabular",
    		 toprule="\\hline",
    		 midrule="\\hline",
    		 bottomrule="\\hline",
    		 titlerule=NULL,
    		 doBegin=TRUE,
    		 doHeader=TRUE,
    		 doBody=TRUE,
    		 doFooter=TRUE,
    		 doEnd=TRUE,
    		 knit_print=TRUE,
    		 latexleftpad=TRUE,
    		 latexrightpad=TRUE,
    		 latexminus=TRUE,
    		 
    		 doHTMLheader=FALSE,
    		 doCSS=FALSE,
    		 doHTMLbody=FALSE,
    		 
    		 CSS=CSSdefault,
    		 HTMLhead=HTMLheaderdefault,
    		 HTMLbody="<body>\n",
    		 HTMLattributes='class="Rtable"',
		 HTMLcaption=NULL,
    		 HTMLfooter=NULL,
    		 HTMLleftpad=FALSE,
    		 HTMLrightpad=FALSE,
    		 HTMLminus=FALSE
    		 )
    function(...) {
        args <- list(...)
        if (!length(args))
            return(opts)
        else {
            if (is.list(args[[1L]])) args <- args[[1L]]
            result <- opts[names(args)]
            opts[names(args)] <<- args
            invisible(result)
        }
    }
})

booktabs <- function(...) { 
    save <- table_options(
                  toprule="\\toprule",
    		  midrule="\\midrule",
    		  bottomrule="\\bottomrule",
    		  titlerule="\\cmidrule(lr)")
    table_options(...) # This may override some of the changes above
    save
}

htmloptions <- function(head=TRUE, table=TRUE, pad=FALSE, ...) {
    save <- table_options()
    on.exit(table_options(save))
    table_options(
    		 doHTMLheader=head,
    		 doCSS=head,
    		 doHTMLbody=head,                 
    		 doBegin=table,
    		 doHeader=table,
    		 doFooter=table,
    		 doBody=table,
    		 doEnd=table,
		 HTMLleftpad=pad,
		 HTMLrightpad=pad,
		 HTMLminus=pad)
    table_options(...) # This may override some of the changes above
    table_options()
}
