# Convenience commands for maintaining the archive.
#
#   make check        full hygiene + syntax check + MATH-Modeling checker
#   make check-fast   skip the R/Julia parsers (useful on a fresh machine)
#   make check-code   run Java, C++, and merged Python tests
#   make r-check      render the INFO 4100 R Markdown template
#   make setup        install the Python analysis stack
#
# The real check lives in tools/check_repo.py; run it directly for options.

PYTHON ?= $(shell if [ -x .venv/bin/python ]; then echo .venv/bin/python; else echo python3; fi)

.PHONY: check check-fast check-code test-code java-test cpp-test r-check math-modeling-check setup

check:
	$(PYTHON) tools/check_repo.py
	$(PYTHON) "MATH-Modeling/scripts/check_repo.py"

check-fast:
	$(PYTHON) tools/check_repo.py --skip-code
	$(PYTHON) "MATH-Modeling/scripts/check_repo.py"

test-code:
	$(PYTHON) -m pytest -q InfoNetworks/tests "Machine Learning/tests"

java-test:
	./CSCI\ 161/test.sh

cpp-test:
	$(MAKE) -C C++/hello-world
	./C++/hello-world/build/hello-world

r-check:
	cd "INFO 4100" && Rscript -e 'd <- tempfile(); dir.create(d); rmarkdown::render("info4100-setup.Rmd", output_dir=d, quiet=TRUE); cat("R Markdown OK\n")'

check-code: java-test cpp-test test-code

math-modeling-check:
	$(PYTHON) "MATH-Modeling/scripts/check_repo.py"

setup:
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt
