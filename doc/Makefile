
all: compile

compile: 
	latexmk -g -pdf 00_report.tex

clean:
	latexmk -c

clean_all: clean
	latexmk -C

open: 
	xdg-open *.pdf &> /dev/null &
