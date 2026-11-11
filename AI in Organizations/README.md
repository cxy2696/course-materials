# INFO 1170/5170 · AI in Organizations (Fall 2025)

I took *AI in Organizations* in fall 2025. The course was about how AI systems
change work and decision-making, and the assignments were mostly hands-on: build
something small, test it, then explain what you learned about the system and the
organization around it.

## What I kept

| Folder | What it is |
| --- | --- |
| `lesson.pdf` | Syllabus: schedule, teaching team, readings, grading |
| `hw3/` | A creative-chatbot prototype and a mini-audit of it |
| `hw4/` | A base-model vs. RAG comparison for law and healthcare questions |
| `mid-term-check-in/` | My proposal, the annotated feedback, and the slide deck |
| `FinalReport/` | Final project report |
| `FinalShowcase/` | Final showcase slides |

## Homework 3

I designed a small assistant from a low-code template, tested it, and wrote
about the choices that are easy to miss: prompts, affordances, creative
constraints, and data flow. The folder has the starter notebook, my submitted
notebook, and a Colab PDF export.

## Homework 4

This one compared a plain language model with a RAG assistant over a small
legal/health corpus. `docs/` has the five public legal-information files
(`law_1.txt`–`law_5.txt`, Cornell LII), and `file.ipynb` rebuilds that folder.
The submitted notebook is `Copy_of_Homework_4.ipynb`; the assignment prompt is
in `Homework 4_ Getting Started.pdf`.

I ran it in Google Colab, so the notebook mounts Drive. To run it locally,
replace that cell with a local `docs/` path and put the key in the environment.

## Running it

```bash
pip install -r requirements-ai.txt
export OPENAI_API_KEY=...        # or whichever provider the notebook uses
jupyter lab
```

If a cell imports `google.colab`, either use Colab or skip that cell and point
the document loader at the local `docs/` folder.

## Notes

- The legal texts are public information I used for the exercise, not legal
  advice.
- The model outputs are from my original runs. A different model will produce
  different text.
- Don't commit a key or a `.env` file. I learned that the hard way; see
  [`../docs/security.md`](../docs/security.md).
