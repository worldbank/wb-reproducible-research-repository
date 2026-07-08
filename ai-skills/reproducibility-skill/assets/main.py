"""
Master script — <Paper title>
Reproducibility package entry point (Python)

A replicator should be able to run the entire package after changing
ONLY the PROJECT_ROOT path below.
"""

# ------------------------------------------------------------------
# 1. THE ONLY LINE A REPLICATOR NEEDS TO CHANGE
# ------------------------------------------------------------------
PROJECT_ROOT = r"C:/path/to/reproducibility-package"   # <-- CHANGE THIS

# ------------------------------------------------------------------
# 2. Environment
# ------------------------------------------------------------------
# Tested with Python 3.13. Install dependencies with:
#   pip install -r requirements.txt
# (requirements.txt pins exact versions used by the authors)

import os
import random
import runpy
import sys

import numpy as np

# ------------------------------------------------------------------
# 3. Paths (all scripts import these — no other absolute paths exist)
# ------------------------------------------------------------------
DATA_RAW = os.path.join(PROJECT_ROOT, "Data", "Raw")
DATA_CLEAN = os.path.join(PROJECT_ROOT, "Data", "Cleaned")
CODE = os.path.join(PROJECT_ROOT, "Code")
OUT_TABLES = os.path.join(PROJECT_ROOT, "Outputs", "Main", "Tables")
OUT_FIGURES = os.path.join(PROJECT_ROOT, "Outputs", "Main", "Figures")

for d in (DATA_CLEAN, OUT_TABLES, OUT_FIGURES):
    os.makedirs(d, exist_ok=True)

os.chdir(PROJECT_ROOT)
sys.path.insert(0, CODE)

# ------------------------------------------------------------------
# 4. Reproducibility settings
# ------------------------------------------------------------------
SEED = 12345
random.seed(SEED)
np.random.seed(SEED)
# If using scikit-learn/torch etc., pass random_state=SEED explicitly
# in each call as well.

# ------------------------------------------------------------------
# 5. Run pipeline in order
# ------------------------------------------------------------------
STEPS = [
    "01_cleaning/clean_data.py",       # builds Data/Cleaned  (~X min)
    "02_analysis/analysis.py",         # builds tables 1-3    (~X min)
    "02_analysis/figures.py",          # builds figures 1-2   (~X min)
]

for step in STEPS:
    print(f"--- running {step} ---")
    runpy.run_path(os.path.join(CODE, step), run_name="__main__")

print("Done. Outputs written to Outputs/.")
