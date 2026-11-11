# INFO 4555/5556 · Business Intelligence Systems (Fall 2025)

A data-warehouse and business-intelligence course project for Cornell's
enterprise data team: model the university's data-warehouse access and usage,
build the ETL, and present dashboards.

## What is inside

| Path | Description |
| --- | --- |
| `2025 Class Project Description.pdf` | Project brief: sponsors, key dates, deliverables |
| `lecture/` | 16 lecture PDFs: dimensional modeling, retail/inventory/procurement, data profiling, ETL, WhereScape, Boomi, AWS guest lecture |
| `done/` | Submitted assignments: grocery-store model, SQL exercises 2–3, Boomi lab, Tableau dashboard, WhereScape assignment |
| `milestone/` | WhereScape “recipes” for the fact and dimension tables (`ACCESS_USAGE_FACT`, `ACCOUNT_DIM`, …) |
| `Team08_milestone2.pdf` | Team milestone report |
| `Account Status.twb`, `done/xc535_financial.twb` | Tableau workbooks (XML) |
| Various assignment PDFs | Tableau financial dashboard, WhereScape setup, audit table, milestone 3 |

## Project theme

The class project asks students to build a **data warehouse and lakehouse
reporting layer** for access and usage data, working with sponsors from the
CIO's office, the registrar, the audit office, and alumni affairs. The
deliverables are a dimensional model, ETL recipes, a data mart, and a
stakeholder presentation.

## Opening the work

* **PDFs** — read directly.
* **Tableau** — open the `.twb` files with Tableau Desktop or Tableau Public.
  They reference local extracts from the original project; reconnect or replace
  the data source if Tableau cannot find it.
* **SQL** — the SQL exercises are embedded in the Word/PDF worksheets under
  `done/`. The course did not keep the `.sql` files separately.
* **Boomi** — `done/Boomi Lab[xc535].html` is a saved HTML export of the lab.

No build step is required; this is a document-and-dashboard folder rather than
a runnable application.

## Notes

* The project briefs, lecture slides, and WhereScape screenshots are course
  material and may reference Cornell systems. They are included for study only.
* Tableau workbooks can contain connection strings or server names. Review them
  before sharing a fork publicly.
* See [`../docs/third-party-materials.md`](../docs/third-party-materials.md)
  for the copyright status of the case material.
