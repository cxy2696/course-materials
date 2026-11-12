# INFO 4555/5556 · Business Intelligence Systems (Fall 2025)

I took Business Intelligence Systems in fall 2025. The class project was a
data-warehouse and lakehouse reporting layer for Cornell's data-warehouse
access and usage data. My team worked with sponsors from the CIO's office, the
registrar, the audit office, and alumni affairs.

## What I kept

| Path | What it is |
| --- | --- |
| `2025 Class Project Description.pdf` | The project brief: sponsors, dates, deliverables |
| `lecture/` | 16 lecture PDFs: dimensional modeling, retail/inventory/procurement, data profiling, ETL, WhereScape, Boomi, an AWS guest lecture |
| `done/` | My submitted assignments: grocery-store model, SQL exercises 2–3, Boomi lab, Tableau dashboard, WhereScape assignment |
| `milestone/` | WhereScape recipes for the fact and dimension tables (`ACCESS_USAGE_FACT`, `ACCOUNT_DIM`, …) |
| `Team08_milestone2.pdf` | Team milestone 2 report |
| `Account Status.twb`, `done/xc535_financial.twb` | Tableau workbooks (XML) |
| Other PDFs | Tableau financial dashboard, WhereScape setup, audit table, milestone 3 |

The project asked us to model access and usage, build the ETL, and present the
result to a non-technical audience. The WhereScape recipes in `milestone/` are
the part I'd look at first if I want to see how the dimensional model was
built.

## Opening the work

- The PDFs are readable as-is.
- The `.twb` files need Tableau Desktop or Tableau Public. They point at local
  files from the original project, so reconnect the data source if Tableau
  can't find it. The PDFs in `done/` show the submitted dashboards.
- The SQL exercises are inside the Word/PDF worksheets; I didn't keep separate
  `.sql` files.
- `done/Boomi Lab[xc535].html` is a saved HTML export of the Boomi lab.

There's no build step here. It's a document-and-dashboard folder.

## Notes

- The project briefs, lecture slides, and WhereScape screenshots are course
  material and may reference Cornell systems.
- The Tableau workbooks can contain connection strings or server names. Check
  them before sharing a fork.
