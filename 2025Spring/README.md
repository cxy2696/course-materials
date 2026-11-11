# Spring 2025

I took eight courses this term and kept the material in one folder. Most of it
is lecture notes and readings; the market-design assignments are the part with
code worth running.

## What's in each folder

| Folder | What I took | What I kept |
| --- | --- | --- |
| `5080/` | STSCI 3080, probability and statistics | Handwritten lecture notes, the DeGroot & Schervish textbook, and a materials-KG paper |
| `5905/` | INFO 5905, professional career development | My cover letter and job-analysis worksheet |
| `5940/` | INFO 4940/5940, copyright and information law | Five reflection sets with case readings, plus the midterm and final |
| `6220/` | INFO 4220/6220, networks II: market design | Lecture decks, problem sets, two assignments, and my final deliverable |
| `6820/` | 6820, knowledge graphs for materials discovery | Nine papers and my research proposal |
| `6940/` | INFO 6940, history of AI | Weekly readings, midterm, final |
| `STSCI/5090/` | STSCI 5090, statistical inference | Marten Wegkamp's notes, a practice exam, recitation sheets |
| `STSCI/5740/` | STSCI 5740, statistical learning | ISLR2 |

The `5080` folder name is a typo I never fixed. The first lecture is headed
“STSCI 3080 — Lecture 1 (Chapter 1 in DeGroot and Schervish)”, so that's the
course. I left the folder name alone because links point at it.

## Market design

`6220/Assignment/` is where I spent most of the coding time:

- `INFO6220-A1.R` — random serial dictatorship, then deferred acceptance vs.
  top trading cycles for a 60-student school-choice problem.
- `INFO6220-A2.R` — single vs. multiple tie-breaking with `matchingMarkets`.
- `INFO6220-A2-custom-DA.R` — the same question with a hand-written DA.
- `A2.ipynb` — a pure-Python version. The original notebook tried to import the
  R package `matchingMarkets`; I rewrote it and checked that it matches the R
  averages.

Run them from the assignment folder:

```bash
cd "2025Spring/6220/Assignment"
Rscript INFO6220-A1.R
Rscript INFO6220-A2.R
```

The scripts set a seed. I removed the runtime `install.packages()` calls and the
loop variable that was shadowed in A1.

## A few notes

- `5940/` was mostly case reading: Feist, Mannion, Star, Oracle, Campbell,
  Warhol. The reflection folders are a decent map of what we read.
- `6940/` has two midterm PDFs because they aren't byte-identical.
- The textbooks and readings are course material. I kept them for study.
