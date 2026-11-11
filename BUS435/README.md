# BUS 435 · International Financial Management (Fall 2023)

Course notes and case work on exchange-rate exposure, hedging, and international
financial markets. The coding highlight is a small AIFS currency-hedging model.

## What is inside

| Path | Description |
| --- | --- |
| `ClassNotes/` | Chapter 3–9 notes, lecture slides, case discussions, exam-style practice |
| `CoursePack/` | Case studies (AIFS, Porsche, TT Textiles, Eurozone) and the hedging model |
| `CoursePack/aifs_hedge_strategy.py` | Python model for the AIFS case |
| `CoursePack/(AIFS).xls` | Original case spreadsheet |
| `Can the Eurozone Survive-Anny.docx` | Written case analysis |

### Topics covered

* the international financial environment and exchange-rate determination;
* currency derivatives, parity conditions, and forecasting;
* government influence on exchange rates;
* transaction, translation, and operating exposure;
* hedging with forwards, futures, and options.

## Running the hedging model

```bash
cd "BUS435/CoursePack"
python aifs_hedge_strategy.py
```

The script compares three strategies — no hedge, a 100% forward hedge, and a
100% option hedge — under stable, strong-dollar, and weak-dollar scenarios. It
prints the USD cost and the saving/loss versus the planning rate. Assumptions
(base rate 1.22, forward/strike 1.2344, 5% premium, EUR 10m notional) are
constants in `main()`, so you can edit them to explore alternatives.

Only `pandas` is required. The numbers match the original case script; the
rewrite adds data classes, docstrings, and a `main()` entry point.

## Notes

* The case PDFs are copyrighted course packs, not original work. They are kept
  for personal study; do not redistribute them. See
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
* `(AIFS).xls` is a legacy Excel file; LibreOffice or Excel can open it.
* The script models a simplified hedge (one notional, three scenarios). It is a
  teaching model, not a treasury system.
