#!/usr/bin/env python3
"""Count anime conventions by year and country from AnimeCons.com.

The live site is protected by Cloudflare and may return HTTP 403 to scripts.
The safest workflow is to save the events page in a browser and parse the
saved HTML::

    python data.py --html events.html

If the page can be fetched directly, omit ``--html``::

    python data.py

The selectors below match the site's public event cards as of the original
project; adjust ``EVENT_SELECTOR`` and the country pattern if the markup
changes.  This script was an exploratory data-collection helper and is kept for
documentation rather than as a production scraper.
"""

from __future__ import annotations

import argparse
import re
from collections import Counter
from pathlib import Path

import requests
from bs4 import BeautifulSoup

EVENTS_URL = "https://animecons.com/events/"
EVENT_SELECTOR = "div.event"
YEAR_PATTERN = re.compile(r"\b(19|20)\d{2}\b")
# Country names/states are not consistently marked up; extend as needed.
COUNTRY_PATTERN = re.compile(
    r"\b(?:United States|Canada|United Kingdom|Australia|Germany|France|Japan|"
    r"Mexico|Brazil|Italy|Spain|Sweden|Finland|Norway|Denmark|Netherlands|"
    r"Belgium|Switzerland|Austria|Poland|Portugal|Ireland|New Zealand)\b",
    re.IGNORECASE,
)
USER_AGENT = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36"
)


def fetch_html(url: str = EVENTS_URL) -> str:
    """Fetch the events page, with a helpful error if Cloudflare blocks us."""
    response = requests.get(url, headers={"User-Agent": USER_AGENT}, timeout=30)
    if response.status_code != 200:
        raise RuntimeError(
            f"{url} returned HTTP {response.status_code}. "
            "Save the page in a browser and rerun with --html events.html."
        )
    return response.text


def parse_events(html: str) -> Counter[tuple[str, str]]:
    """Return counts keyed by (year, country)."""
    soup = BeautifulSoup(html, "html.parser")
    counts: Counter[tuple[str, str]] = Counter()
    for event in soup.select(EVENT_SELECTOR):
        text = " ".join(event.get_text(" ", strip=True).split())
        year_match = YEAR_PATTERN.search(text)
        country_match = COUNTRY_PATTERN.search(text)
        year = year_match.group(0) if year_match else "Unknown"
        country = country_match.group(0) if country_match else "Unknown"
        counts[(year, country)] += 1
    return counts


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--html", type=Path, help="saved events HTML file")
    parser.add_argument("--url", default=EVENTS_URL, help="events page URL")
    args = parser.parse_args()

    html = args.html.read_text(encoding="utf-8", errors="replace") if args.html else fetch_html(args.url)
    counts = parse_events(html)
    if not counts:
        print("No events found. Check EVENT_SELECTOR against the page markup.")
        return
    for (year, country), count in sorted(counts.items()):
        print(f"{year}\t{country}\t{count}")


if __name__ == "__main__":
    main()
