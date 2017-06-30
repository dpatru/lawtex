#!/bin/bash
#!/bin/bash

pdflatex -halt-on-error -draftmode -interaction batchmode testbrief-duplicateCase.tex > /dev/null && echo test PASSED  || echo test FAILED
