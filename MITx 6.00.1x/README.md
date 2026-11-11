# MITx 6.00.1x

I worked through MITx 6.00.1x in 2023 and kept the lecture code, handouts, and
Problem Set 4. The original `asset-v1_...LectureN` folders are now
`lecture01`–`lecture12`.

```text
MITx 6.00.1x/
├── lectures/lecture01..12/   # PDFs and classroom code
├── problem_sets/ps4/         # word game, words.txt, ps4a_checks.py
├── practice/                 # early exercises
└── reference/python-cheatsheet.pdf
```

## Running things

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

`words.txt` has to stay next to the scripts. I renamed the original
`test_ps4a.py` to `ps4a_checks.py` so pytest doesn't collect it.

## What's in the practice folder

| File | Topic |
| --- | --- |
| `longest_alphabetical_substring.py` | longest increasing letter run |
| `loops_and_breaks.py` | while/for, break, counting |
| `sequences.py` | tuples, lists, slicing, mutability |
| `exceptions.py` | try/except/else/finally |
| `caesar_cipher.py` | Caesar cipher class |
| `exam_practice.py` | `closest_power`, `getSublists`, and similar |
| `inheritance_spells.py` | inheritance and polymorphism |

Most lecture files are course-provided examples and run directly; a few use
`input()`. I only renamed or fixed what Python 3 needed.
