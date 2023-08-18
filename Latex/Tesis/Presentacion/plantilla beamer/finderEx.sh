#!/bin/bash

directory='/Users/diego/SparkleShare/diego/Projects/Beamers/MarsellaOct2018/img/rules'
find $directory -maxdepth 2 -type f -name '*.tex' -exec pdflatex 'n="${1%/*}"; n="${n##*/}"; echo "$n",$1' _ {} \;
