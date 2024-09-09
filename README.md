# Numerical Experiments for the thesis *Multi-Objective Approaches for the Thesis Seminar Timetabling Problem*

This repository contains the code and numerical experiments for the Masters thesis titled *Multi-Objective Approaches for the Thesis Seminar Timetabling Problem*. The experiments are implemented using Jupyter Notebook and MiniZinc, and the results presented in the thesis are reproduced here.

## Repository Structure

- `MOILP for the TSTP/`: Contains the Jupyter Notebooks used for running the experiments for the Multi-Objective Integer Linear Programming (MOILP) models for the TSTP.
- `MOSA for the TSTP/`: Contains the Jupyter Notebooks used for running the experiments for the Multi-Objective Simulated Annealing (MOSA) for the TSTP.
- `MiniZinc for the TSTP/`: Contains the MOILP model files using the weighted-sum technique and the data files of the artificial instances for the TSTP impelemented in MiniZinc.
- `Results/`: Pre-generated results for users to quickly view without re-running the full experiments.

## Requirements

To replicate the experiments or run the notebooks, you will need the following software:

- **Python 3.11**
- **Jupyter Notebook**
- **Gurobi Optimizer version 11.0.0**
- **The MiniZinc IDE (version 2.8.3 or higher)**

Python libraries required can be installed using the provided `requirements.txt` file:

```bash
pip install -r requirements.txt
```

## Contact
For any questions or issues, please feel free to open an issue in the repository or contact the author at zhcao2@student.unimelb.edu.au

