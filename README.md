# University of Bristol dissertation template

This template is compatible with the Bristol regulations for both Postgraduate
Taught (e.g. MSc) and Research Degrees (e.g. PhDs). These may be found at the
following links:

  http://www.bristol.ac.uk/media-library/sites/academic-quality/documents/taught-code/annexes/dissertations.pdf
  http://www.bristol.ac.uk/academic-quality/pg/pgrcode/annex4/

The template also seems appropriate for undergraduate dissertations (for
integrated masters degrees), as the format of these is not strictly specified.

## Using `xparse`

The template is based around `xparse`, which we recommend all students learn, by
reading the [manual](https://ctan.org/pkg/xparse?lang=en).

## Using `latexmk`

The template supports `latexmk` for compilation. After installing your favourite
TeX distribution, just run

```
latexmk
```

to compile, and

```
latexmk -c
```

to clean the repository.

## Bibliography

The template has been prepared to use `biber` to generate citations from BibTeX.

Put your BibTeX source in `refs.bib`. Then, within the main text of your thesis, use
```
\textcite{qian_2021}
```
or
```
\parencite{qian_2021}
```
or get a textual or parenthetical citation respectively.

The default style is [ACM citation
style](https://www.acm.org/publications/authors/reference-formatting). The
document class option `ieee` switches the style to the [IEEE reference
style](https://ieeeauthorcenter.ieee.org/wp-content/uploads/IEEE-Reference-Guide.pdf).


## Unicode

Finally, if you would like to use Unicode characters, `latexmk` can be
instructed to use `xelatex` by changing the relevant line of the `latexmkrc`
file:

```
$pdf_mode = 1; # pdflatex is 1, xelatex is 5
```
