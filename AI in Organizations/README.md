# INFO 1170/5170 · AI in Organizations (Fall 2025)

Course materials for *AI in Organizations*, a Cornell course on how AI systems
shape work, decision-making, and organizations. The archive contains the
syllabus, two hands-on assignments, the mid-semester check-in, and the final
project.

## What is inside

| Path | Description |
| --- | --- |
| `lesson.pdf` | Course syllabus: schedule, teaching team, readings, grading |
| `hw3/` | Mini-prototype and mini-audit of a creative chatbot |
| `hw4/` | “Can we trust AI in law and healthcare?”: base model vs. RAG |
| `mid-term-check-in/` | Proposal, annotated feedback, slide deck |
| `FinalReport/` | Final project report (PDF) |
| `FinalShowcase/` | Final showcase slides (PDF export) |

### Homework 3 — creative chatbot

Students design a small assistant, test it, and reflect on the invisible
decisions (prompts, affordances, creative constraints, data flows). The folder
contains the starter notebook, the submitted notebook, and a Colab PDF export.
It uses a low-code/chatbot stack and an LLM API; check the notebook for the
exact provider.

### Homework 4 — trust and RAG

Students compare a base language model with a retrieval-augmented generation
(RAG) assistant over a small legal/health corpus. `docs/` holds five public
legal-information documents (`law_1.txt`–`law_5.txt`, Cornell LII sources), and
`file.ipynb` rebuilds the document set. The submitted notebook is
`Copy_of_Homework_4.ipynb`; the assignment prompt is
`Homework 4_ Getting Started.pdf`.

The assignment was originally run in Google Colab and mounts Google Drive.
To run it locally, replace the `google.colab` cell with a local `docs/` path and
set the API key in the environment.

## Run it

```bash
pip install -r requirements-ai.txt
export OPENAI_API_KEY=...        # or the provider named in the notebook
jupyter lab
```

The notebooks are self-contained but were written for Colab. If a cell imports
`google.colab`, either run it in Colab or skip that cell and point the
document-loading code at the local `docs/` folder.

## Notes

* The `docs/` texts are public legal information, included for the RAG
  exercise. They are not legal advice.
* LLM outputs in the notebooks are from the original runs and may contain
  model-specific text; re-running with a different model will change them.
* Do not commit API keys or `.env` files. See
  [`../docs/security.md`](../docs/security.md).
* The syllabus and lecture material are third-party course content; see
  [`../docs/third-party-materials.md`](../docs/third-party-materials.md).
