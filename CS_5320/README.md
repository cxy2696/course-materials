# CS 5320 · Database Systems (Fall 2024)

I took Database Systems in fall 2024. The lectures covered storage, indexes,
query processing, and optimization; the SQL lab is the part I can run and show.

## What I kept

| Path | What it is |
| --- | --- |
| `5_Data_Storage.pdf` | Pages, records, buffer management |
| `6_Tree_Indexes.pdf`, `7_Hash_Indexes.pdf` | B+ trees and hash indexes |
| `8_Processing_Overview.pdf`, `9_Operator_Implementations.pdf` | Query execution operators |
| `10_Query_Optimization.pdf` | Cost-based optimization |
| `SQLfolder/bars.pgsql` | The PostgreSQL lab: schema, data load, ten queries |
| `csv/chocolate_bars.csv` | 2,530 chocolate-bar reviews |
| `csv/{courses,students,enrollment}.csv` | Small join example |

## Running the SQL lab

The script uses psql's client-side `\copy`, so it doesn't need server-side file
permissions. Run it from `CS_5320`:

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

I checked the `SELECT` statements with DuckDB during the cleanup. The `\copy`
line is psql-only.

## Notes

- The lecture slides are by Immanuel Trummer (Cornell).
- The original script loaded from `/Users/xinyi/Downloads/...`; the relative
  path makes the lab portable.
