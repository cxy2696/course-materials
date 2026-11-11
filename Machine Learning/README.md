# Machine Learning coursework

Five assignments from a Cornell machine-learning course. The notebooks keep the
original problem statements and grading markers; helper modules were cleaned up
so they can be imported and tested.

| Folder | Topic | Main files | Dependencies |
| --- | --- | --- | --- |
| `knn/` | k-nearest neighbours, face recognition | `knn.ipynb`, `knn_utils.py`, `faces.mat` | numpy, scipy, matplotlib |
| `perceptron/` | perceptron and decision boundaries | `perceptron.ipynb`, `perceptron_utils.py` | numpy, matplotlib |
| `kernels/` | linear and kernel SVM, cross-validation | `HW3_Kernels.ipynb`, `l2distance.py`, `visclassifier.py` | torch, scipy |
| `naive_bayes/` | English/German word classification | `python_P5_NB.ipynb`, `*_train.txt`, `*_test.txt` | numpy, matplotlib |
| `sgd_neural_network/` | momentum SGD, MLP, CNN, MNIST | `python_HW4_SGD_NN.ipynb`, `train_subset_indices.npy` | torch, torchvision |

## Run

```bash
python -m pip install -r requirements.txt
python -m pip install -r "Machine Learning/requirements-ml.txt"   # kernels and SGD
jupyter lab
```

Start Jupyter from the repository root and open the notebook you need.

## Notes

- `knn_utils.py` loads `faces.mat` from the same folder and provides click-based
  visualizers.
- The perceptron spam competition expects the course's `p02/` email data; it is
  not included.
- `l2distance` accepts NumPy arrays or PyTorch tensors; `visclassifier` plots a
  decision boundary.
- Naive Bayes uses only the text files in `naive_bayes/`.
- The SGD/CNN notebook downloads MNIST to `sgd_neural_network/MNIST/` (ignored).

## Tests

From the repository root:

```bash
python -m pytest -q "Machine Learning/tests"
```

The tests cover the L2 distance matrix (NumPy and optional PyTorch) and the
k-NN normalization helper. Notebooks are not executed in CI.

The notebooks are based on course templates; the problem statements and grading
markers belong to the course. The solutions are kept for review, not for
submission in the same course.
