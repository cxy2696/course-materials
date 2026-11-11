# Data

I keep every dataset here, and the notebooks read them with relative paths. That way the notebooks run without a network connection, and the saved outputs can be reproduced.

| File | Size | Lines | Used by | Source |
| --- | ---: | ---: | --- | --- |
| [Exercise3_datafit1.csv](Exercise3_datafit1.csv) | 34 B | 4 | least-squares example (`Least Squares Optimization.ipynb`, stored as an optional snippet) | companion data page of *Inquiry-Based Numerical Methods* |
| [Exercise3_waterflow.csv](Exercise3_waterflow.csv) | 84 B | 7 | trapezoid-rule exercise (`HW03`) | same |
| [Exercise4_52.csv](Exercise4_52.csv) | 97 B | 11 | quadratic fit and least squares (`Eigenvectors and Eigenvalues.ipynb`) | same |
| [Exercise5_boys.csv](Exercise5_boys.csv) | 127 B | 14 | ODE parameter fitting, boarding-school data (`Fitting ODE.ipynb`) | same |
| [Water_Quality_Data.csv](Water_Quality_Data.csv) | 180 KB | 2 372 | smoothing, numerical derivatives and integration (`HW03`) | course dataset; the original download page is the data.gov *Water Quality Data* set linked in HW03 |

## SHA-256

```text
d2f76455e0af1b554786774084c982831a8daed763b1dba6f09f78c1529beb7e  Exercise3_datafit1.csv
516de8de590aba43d1770fe4ea606718ea997f651affa3ccf52812ab20127d76  Exercise3_waterflow.csv
409ec793c43e66ef111d1a9cbd87f7a02218c4dd84113a72f0b330ec1ce16377  Exercise4_52.csv
054d60379245111ea81ead01ec7c5595f464f01151f67a167d5df0a14163fc34  Exercise5_boys.csv
7fc419077dd63262056288e69a9cbdc7b550adecc8cf05fc626bcb51ed9f0e2e  Water_Quality_Data.csv
```

## Notes

- I copied the four `Exercise*.csv` files from the textbook's companion repository and changed the notebooks to read them locally. The contents are unchanged.
- `Water_Quality_Data.csv` is the original export. The `?C` and `?F` in its column names are encoding losses for `°C` and `°F`; I left them as they are so the code that reads those columns keeps working.
- If a dataset changes, update the hash here and mention it in [`docs/changelog.md`](../docs/changelog.md).
