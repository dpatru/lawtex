#!/bin/bash
function dotest {
    echo testing $1
    pdflatex -halt-on-error "\def\EnforceAssertions{defined} \input{$1}" &> /dev/null && echo Test $1 passed || echo Test $1 FAILED.
}
export -f dotest
ls test*.tex | parallel --timeout 1000% dotest {}
test
