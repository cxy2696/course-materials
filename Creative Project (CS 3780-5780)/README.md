# Creative project · CS 3780/5780

`emotion-classification.ipynb` is the course template I used for the creative
project: classify text into emotion classes, then write about what worked and
what didn't. It includes data loading, preprocessing, models, error analysis,
and a GenAI disclosure section.

```text
Creative Project (CS 3780-5780)/
├── emotion-classification.ipynb
└── data/sample_emotion_dataset.csv   # 10,000 rows, text,label
```

The official training data is on Kaggle:

```text
/kaggle/input/cs-3780-5780-how-do-you-feel/train.csv
```

The bundled sample is only for checking the format locally. To run the notebook
without Kaggle, replace the Kaggle read with:

```python
train_data = pd.read_csv("data/sample_emotion_dataset.csv")
test_data = train_data.sample(frac=0.2, random_state=42)
```

The sample has no `id` column, so adjust the test-set code.

```bash
python -m pip install -r requirements.txt
python -m pip install scikit-learn
jupyter lab "Creative Project (CS 3780-5780)/emotion-classification.ipynb"
```

The notebook still has placeholders for names, NetIDs, and the GenAI disclosure.
I left them in because this is the template, not the submitted version.
