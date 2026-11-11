# MITx 6.00.1x

Lecture code, handouts, and Problem Set 4 from MITx 6.00.1x (2023). The original
`asset-v1_...LectureN` folders are now `lecture01`–`lecture12`.

```text
MITx 6.00.1x/
├── lectures/lecture01..12/   # PDFs and classroom code
├── problem_sets/ps4/         # word game, words.txt, ps4a_checks.py
├── practice/                 # early exercises
└── reference/python-cheatsheet.pdf
```

## Run

```bash
cd "MITx 6.00.1x/practice"
python3 sequences.py
python3 longest_alphabetical_substring.py
```

Problem Set 4:

```bash
cd "MITx 6.00.1x/problem_sets/ps4"
python3 ps4a.py
python3 ps4a_checks.py
```

`words.txt` must stay next to the scripts. The original `test_ps4a.py` is now
`ps4a_checks.py` so the repository's pytest collection does not pick it up.

## Files

| File | Topic |
| --- | --- |
| `longest_alphabetical_substring.py` | longest increasing letter run |
| `loops_and_breaks.py` | while/for, break, counting |
| `sequences.py` | tuples, lists, slicing, mutability |
| `exceptions.py` | try/except/else/finally |
| `caesar_cipher.py` | Caesar cipher class |
| `exam_practice.py` | `closest_power`, `getSublists`, and similar |
| `inheritance_spells.py` | inheritance and polymorphism |

Most lecture files are course-provided examples and run directly; some use
`input()`. They were renamed or fixed only where needed for Python 3.
