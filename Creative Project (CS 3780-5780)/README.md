# Creative project · CS 3780/5780

`emotion-classification.ipynb` is the course template for classifying text into
emotion classes. It includes data loading, preprocessing, models, error analysis,
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

The bundled sample is for local format checks only. To run the notebook without
Kaggle, replace the Kaggle read with:

```python
train_data = pd.read_csv("data/sample_emotion_dataset.csv")
test_data = train_data.sample(frac=0.2, random_state=42)
```

The sample has no `id` column, so adjust the test-set code accordingly.

```bash
python -m pip install -r requirements.txt
python -m pip install scikit-learn
jupyter lab "Creative Project (CS 3780-5780)/emotion-classification.ipynb"
```

The notebook still contains course placeholders for names, NetIDs, and the
GenAI disclosure. Complete them before submitting.
