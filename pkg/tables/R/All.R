All <- function(df, factorsAsStrings = TRUE) {
    names <- names(df)
    for (i in seq_along(names)) {
        value <- df[[i]]
        if (factorsAsStrings && is.factor(value))
            value <- as.character(value)
        f1 <- call("*", call("Heading", as.name(names[i])),
                   value)
        if (i == 1)
            f <- f1
        else
            f <- call("+", f, f1)
    }
    f
}
