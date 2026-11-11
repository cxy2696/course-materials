# Convenience commands for maintaining the archive.
#
#   make check        full hygiene + syntax check (needs R and Julia for those checks)
#   make check-fast   skip the R/Julia parsers (useful on a fresh machine)
#   make setup        install the Python analysis stack
#
# The real check lives in tools/check_repo.py; run it directly for options.

PYTHON ?= python3

.PHONY: check check-fast setup

check:
	$(PYTHON) tools/check_repo.py

check-fast:
	$(PYTHON) tools/check_repo.py --skip-code

setup:
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt
