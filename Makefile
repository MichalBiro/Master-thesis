# filename without extenstion e.g: if we have example.tex
FILE=example

# path to root of electronic medium, 
# preferably use absolute path (on Unix paths that start with '/', on Windows paths that start with 'C:\')
# relative paths to Makefile work as well
ELECTRONIC_MEDIUM=.

# specify where to put all build garbage
BUILD_DIR=.build

# set options for latexmk
LATEXMK_OPTIONS=-output-directory=$(BUILD_DIR) -quiet -pdf -bibtex -pdflatex="pdflatex" 

all: build
	
build:
# check if python is available, 
# run tree.py to generate directory structure of electronic medium
ifneq (, $(shell which python))
	python ./utils/tree.py -d 3 -r $(ELECTRONIC_MEDIUM) -o ./includes/attachmentA.tex -q
endif
	latexmk $(LATEXMK_OPTIONS) $(FILE).tex
	mv $(BUILD_DIR)/$(FILE).pdf .

# latexmk -output-directory=$(BUILD_DIR) -CA might be used to clean
clean:
	rm -fr $(BUILD_DIR)
	rm -f $(FILE).pdf

refresh: clean build

.PHONY: all build clean refresh
