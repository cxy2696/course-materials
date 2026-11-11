# Machine Learning coursework

I took a Cornell machine-learning course and kept five assignments. The
notebooks still have the original problem statements and grading markers; I
cleaned up the helper modules so they can be imported and tested.

| Folder | Topic | Main files | Needs |
| --- | --- | --- | --- |
| `knn/` | k-nearest neighbours, face recognition | `knn.ipynb`, `knn_utils.py`, `faces.mat` | numpy, scipy, matplotlib |
| `perceptron/` | perceptron and decision boundaries | `perceptron.ipynb`, `perceptron_utils.py` | numpy, matplotlib |
| `kernels/` | linear and kernel SVM, cross-validation | `HW3_Kernels.ipynb`, `l2distance.py`, `visclassifier.py` | torch, scipy |
| `naive_bayes/` | English/German word classification | `python_P5_NB.ipynb`, `*_train.txt`, `*_test.txt` | numpy, matplotlib |
| `sgd_neural_network/` | momentum SGD, MLP, CNN, MNIST | `python_HW4_SGD_NN.ipynb`, `train_subset_indices.npy` | torch, torchvision |

## Running them

```bash
python -m pip install -r requirements.txt
python -m pip install -r "Machine Learning/requirements-ml.txt"   # kernels and SGD
jupyter lab
```

Start Jupyter from the repo root and open the notebook you need.

## Things I ran into

- `knn_utils.py` loads `faces.mat` from the same folder and has click-based
  visualizers.
- The perceptron spam competition expects the course's `p02/` email data. I
  don't have it.
- `l2distance` takes NumPy arrays or PyTorch tensors; `visclassifier` plots a
  decision boundary.
- Naive Bayes only uses the text files in `naive_bayes/`.
- The SGD/CNN notebook downloads MNIST into `sgd_neural_network/MNIST/`, which
  git ignores.

## Tests

```bash
python -m pytest -q "Machine Learning/tests"
```

The tests cover the L2 distance matrix (NumPy and optional PyTorch) and the k-NN
normalization helper. CI doesn't execute the notebooks.

The templates and problem statements belong to the course. The solutions are
mine, kept for review rather than resubmission.
