# BUS 435 · International Financial Management (Fall 2023)

I took International Financial Management in fall 2023. Most of the folder is
chapter notes and case preparation; the AIFS case is the one with a model I
wrote.

## What I kept

| Path | What it is |
| --- | --- |
| `ClassNotes/` | Chapter 3–9 notes, lecture slides, case discussions, exam-style practice |
| `CoursePack/` | Cases (AIFS, Porsche, TT Textiles, Eurozone) and my hedging model |
| `CoursePack/aifs_hedge_strategy.py` | The AIFS model |
| `CoursePack/(AIFS).xls` | The original case spreadsheet |
| `Can the Eurozone Survive-Anny.docx` | My Eurozone case write-up |

We covered exchange-rate determination, currency derivatives, parity
conditions, forecasting, government intervention, and transaction/translation/
operating exposure. The cases were the useful part: I had to decide whether
to hedge, how much, and with what.

## The AIFS model

```bash
cd "BUS435/CoursePack"
python aifs_hedge_strategy.py
```

The script compares no hedge, a 100% forward hedge, and a 100% option hedge
under stable, strong-dollar, and weak-dollar scenarios. It prints the USD cost
and the saving/loss against the planning rate. The assumptions (1.22 base,
1.2344 forward/strike, 5% premium, EUR 10m notional) are constants in `main()`.

I rewrote the original script with data classes, docstrings, and a `main()`. The
numbers are the same; I checked them against the old version.

Only `pandas` is needed.

## Notes

- The case PDFs are course packs, not my work. I kept them for study.
- `(AIFS).xls` is an old Excel file; LibreOffice or Excel opens it.
- The model is a teaching simplification: one notional, three scenarios. It is
  not a treasury system.
