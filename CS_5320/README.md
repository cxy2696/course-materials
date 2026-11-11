# CS 5320 · Database Systems (Fall 2024)

Lecture material and a hands-on SQL lab on database storage, indexing, query
processing, and optimization.

## What is inside

| Path | Description |
| --- | --- |
| `5_Data_Storage.pdf` | Pages, records, buffer management |
| `6_Tree_Indexes.pdf`, `7_Hash_Indexes.pdf` | B+ trees and hash indexes |
| `8_Processing_Overview.pdf`, `9_Operator_Implementations.pdf` | Query execution operators |
| `10_Query_Optimization.pdf` | Cost-based optimization |
| `SQLfolder/bars.pgsql` | PostgreSQL lab: schema, data load, ten queries |
| `csv/chocolate_bars.csv` | 2,530 chocolate-bar reviews |
| `csv/{courses,students,enrollment}.csv` | Small relational example for joins |

## Run the SQL lab

The script uses PostgreSQL's client-side `\copy`, so it does not need
server-side file permissions. Run it from the `CS_5320` folder:

```bash
cd CS_5320
createdb bars
psql -d bars -f SQLfolder/bars.pgsql
```

It creates a typed `bars` table, loads `csv/chocolate_bars.csv`, and prints the
answers to ten labelled queries:

1. average rating;
2. manufacturer with the most reviews;
3. reviews mentioning “earthy”;
4. manufacturers with more than 25 high-cocoa bars;
5. bars never reviewed in 2018;
6. review pairs whose later rating improved;
7. manufacturers using domestic beans;
8. different bars sharing the same review text;
9. average rating above vs. below the mean cocoa percentage;
10. bars reviewed in every year represented in the data.

The queries were syntax-checked with DuckDB during the 2026 cleanup (same
`SELECT` logic; the `\copy` line is psql-specific).

## Notes

* The lecture slides are by Immanuel Trummer (Cornell); they are third-party
  course material. See
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
* The original version of `bars.pgsql` loaded from
  `/Users/xinyi/Downloads/...`; the relative path makes the lab portable.
