# Mathematical modeling

I studied a modeling course alongside the numerical-analysis material and kept its printed notes and the short notebooks I wrote to reproduce the examples. The notes cover the modeling process, fitting, dynamical systems, simulation, graphs, decision analysis, game theory, queueing and Markov chains.

## Lecture notes

| File | Topic | Content |
| --- | --- | --- |
| [Modeling Process.pdf](<lecture-notes/Modeling Process.pdf>) | The modeling process (chapter 2) | proportionality, geometric similarity, the modeling cycle |
| [Model Fitting.pdf](<lecture-notes/Model Fitting.pdf>) | Model fitting (chapter 3) | empirical modeling versus model fitting |
| [Experimental Modeling.pdf](<lecture-notes/Experimental Modeling.pdf>) | Experimental modeling (chapter 4) | building a model from measured data |
| [Simulation.pdf](<lecture-notes/Simulation.pdf>) | Simulation (chapter 5) | Monte Carlo simulation and stochastic models |
| [Modeling with Graphs.pdf](<lecture-notes/Modeling with Graphs.pdf>) | Graphs (chapter 8) | graph representations and graph models |
| [Decision Analysis.pdf](<lecture-notes/Decision Analysis.pdf>) | Decision analysis (chapter 9) | decision trees and expected value |
| [Game Theory.pdf](<lecture-notes/Game Theory.pdf>) | Game theory (chapter 10) | total-conflict games and mixed strategies |
| [Discrete Dynamical Systems.pdf](<lecture-notes/Discrete Dynamical Systems.pdf>) | Discrete dynamical systems (chapter 1) | difference equations, equilibria, stability |
| [Markov Chains.pdf](<lecture-notes/Markov Chains.pdf>) | Markov chains | transition matrices and steady state, with the brewery example |
| [Chapter 16 Markov Chains.pdf](<lecture-notes/Chapter 16 Markov Chains.pdf>) | Markov chains (chapter 16, scan) | scanned textbook chapter |
| [Queuing.pdf](<lecture-notes/Queuing.pdf>) | Queueing | queue models and Little's law |
| [Chapter 17 Queueing Theory.pdf](<lecture-notes/Chapter 17 Queueing Theory.pdf>) | Queueing theory (chapter 17, scan) | scanned textbook chapter |
| [Queuing Formulas.pdf](<lecture-notes/Queuing Formulas.pdf>) | Queueing formula sheet | steady-state formulas for M/M/1 and M/M/s (one page) |
| [Queueing Formulas Tutorial.pdf](<lecture-notes/Queueing Formulas Tutorial.pdf>) | Queueing tutorial | notation, two-moment approximations and worked examples |

## Demo notebooks

### Fitting (`code/fitting/`)

| Notebook | What it does |
| --- | --- |
| [Absolute Deviations.ipynb](<code/fitting/Absolute Deviations.ipynb>) | L1 fit of the stopping-distance data, compared with least squares |
| [AdData.ipynb](<code/fitting/AdData.ipynb>) | Linear, exponential and power fits of advertising data |
| [Chebyshev.ipynb](<code/fitting/Chebyshev.ipynb>) | Minimax (Chebyshev) fit of the same data |
| [Least Squares.ipynb](<code/fitting/Least Squares.ipynb>) | Least-squares fit with `scipy.optimize` |
| [Linear Regression.ipynb](<code/fitting/Linear Regression.ipynb>) | OLS regression with `statsmodels` |
| [Olympic Lifters.ipynb](<code/fitting/Olympic Lifters.ipynb>) | Total lifted versus body weight, first model |
| [Olympic Lifters Take 2.ipynb](<code/fitting/Olympic Lifters Take 2.ipynb>) | Improved version of the lifting model |
| [Polynomial Fit.ipynb](<code/fitting/Polynomial Fit.ipynb>) | Polynomial fit to the stopping-distance data |
| [Polynomial Fit - Choosing.ipynb](<code/fitting/Polynomial Fit - Choosing.ipynb>) | Training/validation error and the choice of degree |
| [Problem2.2.ipynb](<code/fitting/Problem2.2.ipynb>) | Modeling exercise 2.2: fitting a data set |
| [Splines.ipynb](<code/fitting/Splines.ipynb>) | Cubic spline interpolation |
| [Stopping Distance.ipynb](<code/fitting/Stopping Distance.ipynb>) | Plotting and a first model for stopping distance |
| [Stopping Distance Predict.ipynb](<code/fitting/Stopping Distance Predict.ipynb>) | Predicting a stopping distance from the fitted model |
| [Stopping Distance Transformation.ipynb](<code/fitting/Stopping Distance Transformation.ipynb>) | Linearizing the relation with a log transform |

### Dynamical systems (`code/dynamical-systems/`)

| Notebook | What it does |
| --- | --- |
| [CompoundInterest.ipynb](<code/dynamical-systems/CompoundInterest.ipynb>) | Compound interest as a recurrence |
| [Fibonacci.ipynb](<code/dynamical-systems/Fibonacci.ipynb>) | Fibonacci numbers and the golden ratio |
| [Fishing.ipynb](<code/dynamical-systems/Fishing.ipynb>) | A fish population with constant harvesting |
| [FishingLimited.ipynb](<code/dynamical-systems/FishingLimited.ipynb>) | Harvesting with a carrying capacity |
| [PredatorPrey.ipynb](<code/dynamical-systems/PredatorPrey.ipynb>) | Discrete predator–prey model |

### Simulation (`code/simulation/`)

| Notebook | What it does |
| --- | --- |
| [AcceptReject.ipynb](<code/simulation/AcceptReject.ipynb>) | Acceptance–rejection sampling from the normal density |
| [BoxMuller.ipynb](<code/simulation/BoxMuller.ipynb>) | Box–Muller normal samples |
| [Craps.ipynb](<code/simulation/Craps.ipynb>) | Monte Carlo estimate of the pass-line probability |
| [DieRolls.ipynb](<code/simulation/DieRolls.ipynb>) | Random integers and sums of dice |
| [Linear Congruential.ipynb](<code/simulation/Linear Congruential.ipynb>) | A linear congruential generator |
| [Middle Square.ipynb](<code/simulation/Middle Square.ipynb>) | The middle-square generator and its short cycle |
| [Probability Integral Transform.ipynb](<code/simulation/Probability Integral Transform.ipynb>) | Sampling an exponential distribution |
| [Roulette.ipynb](<code/simulation/Roulette.ipynb>) | Expected value and streaks for red/black and green bets |

### Markov chains (`code/markov-chains/`)

| Notebook | What it does |
| --- | --- |
| [Brewery.ipynb](<code/markov-chains/Brewery.ipynb>) | Market shares evolving by a recurrence |
| [Brewery - Markov Chains.ipynb](<code/markov-chains/Brewery - Markov Chains.ipynb>) | The same problem written as a Markov chain |
| [Brewery - Steady State.ipynb](<code/markov-chains/Brewery - Steady State.ipynb>) | Steady state from the eigenvector |
| [Steady State.ipynb](<code/markov-chains/Steady State.ipynb>) | A four-state chain with absorbing states |

## Notes

- Chapters 16 and 17 are scans without a text layer; the rest are searchable.
- The demo notebooks need only `numpy`, `matplotlib`, `scipy` and `statsmodels`, and they read no external files.
- I rewrote the simulation notebooks to draw all trials at once and fixed the seeds, so their outputs are reproducible. See [`docs/performance.md`](../docs/performance.md).
