
# tables 0.9.33

- The fix for issue #30 was incomplete for some reason.
- `table_options()` now returns the value of options if called 
with a character argument.
- An option `escape` has been added to `table_options()`.  If `TRUE`,
any special characters in HTML or LaTeX output are escaped so they
appear as-is.

# tables 0.9.31

- In a few places `len` was used instead of `length.out` in calls to
`rep()`, leading to warnings.  Similarly, `rep` was used instead of 
`replace` in `sample()` (issue #28).
- `tabular` assumed it was on the search list, and didn't work when
called as `tables::tabular` (issue #30).
- Added `Authors@R` field to `DESCRIPTION`.

# tables 0.9.28

- A factor level of `""` caused an error when displayed.  It will
now be changed to `" "` for display (issue #19).
- The `VignetteBuilder` field in `DESCRIPTION` has been changed to
`rmarkdown` so that Pandoc can be found even when it is not on the `PATH`.
- Another minor update due to changes to the `formatters` package.

# tables 0.9.25

- `PlusMinus()` and `Paste()` didn't handle formatting properly 
when multiple columns were involved (issue #13).
- `toLatex()` with a non-empty `file` argument didn't write 
to file properly.  (Reported by Reinhard Kerschner and F. Hortner.)
- In some cases `All()` would give an error (issue #17).
- `toTinytable()` function has been added to work with the
`tinytable` package.
- Minor update due to changes to the `formatters` package.

# tables 0.9.17

- Change host to Github.
- Add `useGroupLabels()` function.
- Add `HTMLfootnotes()` function.
- Add method for `formatters::matrix_form`.

# tables 0.9.10

- rbind() failed in a complicated example, because the classes
or names of the column labels differed.
- Error messages for rbind() and cbind() have been made more
helpful.
      
# tables 0.9.8

- All() didn't work with tibbles.  (Reported by Vincent Arel-Bundock.)
      
# tables 0.9.7

- toHTML() was ignoring the file argument.

# tables 0.9.4

- Minor update to fix test note.

# tables 0.9.3

- Added latexTable() function, to provide captions, labels, etc.
- Added knitrTable vignette.
      
# tables 0.9
      
- Reduced dependence on Hmisc.
      
# tables 0.8.8

- Updates to fix CRAN errors.

# tables 0.8.7

- Added ... argument to toKable() so that options can be
passed to control the conversion.  (Thanks to Mary Putt
for pointing out the need for this.)
- Fixed bug in as.tabular.data.frame() that failed if any
columns were factors.  (Reported by Daniel Farewell.)
- Fixed incompatibility with new version of fancyvrb.  
(Thanks to Prof. Brian Ripley for working out the
solution.)
- Fixed incompatibility with rmarkdown/knitr new version.

# tables 0.8.4

- Added check for bad args to DropEmpty(), and fixed
example which had them.
- Added "nearData" argument to Heading() etc,
to fix Hline() bug reported by Johannes Ranke.
- Fixed bug in justification of row labels.
- Fixed bug when statistic had the wrong length,
reported by Stefan Marr.
- Added toKable() function, for use with the kableExtra
package.
- Added knit_print.tabular() method, so that tabular
objects will print with correct formatting in knitr 
documents.
      
# tables 0.8

- Allow editing of the row and column labels.
- Added DropEmpty() pseudo-function.
- Added AllObs() and RowNum() formula functions.
- Added character.only argument to Heading() and Paste().

# tables 0.7.91

- Updated options for html.tabular to use better CSS and HTML5 in
the tables.
- Added an HTML vignette.
- Fixed bug:  functions prefixed by "pkg::" in formulas led to warning
messages. (Reported by Lars Bishop.)
      
# tables 0.7.88

- Edited messages to allow internationalization.  No translations 
added so far.
      
# tables 0.7.87
      
- Added "append" argument to latex.tabular() and html.tabular(),
and made explicit that connections are allowed for the "file"
argument. (Suggestion of Marc Halperin.)

# tables 0.7.86

- Fixed scoping bug:  locally defined format functions were not
always found.  (Reported by Doug Ezra Morrison.)

# tables 0.7.79

- Added Equal() and Unequal() pseudo-functions for more flexible Percent() calculations.
- Fixed bug in handling factors which had not excluded NA values.
- Added "formula" attribute to tabular.formula results.
- Added as.tabular() function.
- Added Arguments() function to allow multi-argument analysis
functions.
      
# tables 0.7.68
      
- Bug fix in setting up column headings (reported by Lars Bishop).
      
# tables 0.7.67

- The cbind() and rbind() methods now allow NULL in the list
of arguments.  (Suggestion of Jeff Newmiller.)
- Added a note in the vignette about how to use RowFactor with
nopagebreak in a longtable environment. (Based on some sleuthing by Jeffrey Miller.)
- Added HTMLcaption to the table options to insert an HTML caption. (Suggestion of Joseph Larmarange.)
      
# tables 0.7.64
      
- Added support for HTML output.
- Added support for extraction of subsets of the matrix.
- Added Paste() function.
- If a summary doesn't produce a scalar value, formatting
messed up the display.  Now a warning will be issued and that
cell will be displayed as <NA> or similar.
- Added cbind() and rbind() methods for tabular objects.
- The internal texify() function did not work properly.
      
# tables 0.7.48

- Default formatting now skips character cells.
- Justification of labels in text mode wasn't being done properly.
      
# tables 0.7

- RowFactor now allows spacing=1.
- Specifications for justification in table_options() are now recycled.
- Missing values were not handled correctly when computing counts, and when working with factors.  (Reported by Manuel Reif.)
- Added Percent() pseudo-function. 
- Cleaned up handling of row and column labels, especially in cases where rows with different column headings are summed.
- Added optional parameter to Heading() to use it only if another hasn't already been set.
      
# tables 0.6

- Fixed bug in column headings in print.tabular (reported by Tal Galili)
- Added Factor().
- Fixed bug with zero columns of row labels.
- Added levelnames argument to RowFactor and Factor to allow label customization.
- Added Multicolumn function.
- Added as.matrix(), write.csv.tabular() and write.table.tabular() (suggestions of Greg Snow).
- Added LaTeX escapes to text in the body or labels constructed by All() or the factor labels.  (Suggestion of Dieter Menne.)
- Added a caption to the longtable example.  (Suggestion of Dieter Menne.)
- Added the version number to the vignette title page.
- Fixed RowFactor to add space before first row, not after last row. (Bug report from Dieter Menne.)
- Made tabular() into a generic function.  (Suggestion of Hadley Wickham.)
- Added description of missing values to the vignette.
- Fixed handling of data with an Hmisc "labelled" class
attached.  (Reported by Thomas MacFarland.)
	
# tables 0.5

- Planned CRAN release of all of the above

# tables 0.4

- Added All(), Literal() and RowFactor()
- Added table_options() and booktabs() for booktabs support
- Gave different defaults for row label justification and data justification
- Suppress page breaks in RowFactor().
- Allow options to be set temporarily in latex() call.
- Added options to suppress parts of the output.

# tables 0.3

- Renamed from "tabular" to "tables", put on R-forge

# tables 0.2  

- First reasonably complete release

# tables 0.1

- First alpha version with Hmisc support

# tables 0.0

- Various abortive attempts


