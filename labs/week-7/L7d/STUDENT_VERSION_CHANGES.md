# Student Version: L7b Lab (35-Minute Format)

## Overview
The student version has been streamlined for a 35-minute hands-on session. Students implement the three most critical operations while pre-implemented code handles routine tasks.

## What Students Code (Hands-On Exercises)

### Task 1: Single Index Model Estimation
Students implement two critical lines of code:

* **Design Matrix Construction** - Build `X̂ = [ones(max_length) Rₘ]` to create the regression design matrix with intercept and market returns (3 min)
* **OLS Parameter Estimation** - Implement `θ̂ = inv(transpose(X̂)*X̂)*transpose(X̂)*y` to estimate alpha and beta parameters (7 min)

### Task 2: Uncertainty Quantification
All code is pre-implemented. Students run cells and interpret results:

* **Residual Variance** - See how variance is estimated from model residuals
* **Standard Errors** - Observe SE computation from covariance matrix
* **Confidence Intervals** - Review 95% CI table showing parameter ranges

Students focus on understanding output rather than coding mechanics (2 min total).

### Task 3: SVD-Based Parameter Estimation
Students implement two lines that reconstruct parameters using SVD:

* **Parameter Modes** - Compute `parameter_modes[i] = ((transpose(u)*y)/σ)*v` for each singular value (5 min)
* **Mode Summation** - Accumulate `p += parameter_modes[i]` to build final estimate (3 min)
* **Verification** - Compare `θ̂ ≈ θ̂_svd` to confirm both methods agree (2 min)

## Lab Session Timeline

```
Setup         →  Task 1       →  Task 2      →  Task 3       →  Wrap-up
(3 min)          (10 min)        (2 min)        (10 min)        (10 min)
                 
Run setup        Design matrix   Run & review   SVD parameter   Compare methods
Load data        + OLS formula   CI output      reconstruction  Discuss results
```

Total: 35 minutes

## What's Different from Solution Version

**Pre-implemented (students observe):**
- Data loading and cleaning
- Firm return extraction  
- Residual variance calculation
- Standard error computation
- Confidence interval bounds
- SVD component extraction

**Student implements (hands-on):**
- Design matrix construction: `X̂ = [ones(max_length) Rₘ]`
- OLS normal equations: `θ̂ = inv(transpose(X̂)*X̂)*transpose(X̂)*y`
- SVD parameter mode: `((transpose(u)*y)/σ)*v`
- Mode accumulation: `p += parameter_modes[i]`

Result: Students write 4 meaningful lines that capture the essence of SIM estimation.

## Teaching Notes

> **Setup (3 min):** Brief overview of learning objectives, then students run boilerplate cells to load data and compute growth rates.

> **Task 1 (10 min):** Walk through design matrix construction as a class (2-3 min), then students implement OLS formula independently. Circulate to help with syntax.

> **Task 2 (2 min):** Students execute pre-written cells and examine confidence interval table. Discuss interpretation: "Does alpha cross zero? What does that mean?"

> **Task 3 (10 min):** Students implement SVD reconstruction. Key insight: both methods produce identical parameters but SVD is numerically stable.

> **Wrap-up (10 min):** Discuss when to use each method, verify results match, review key takeaways. Solution notebook available for reference.

___
