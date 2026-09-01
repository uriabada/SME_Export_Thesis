

# BART-MIA — Kenya

# Must be set BEFORE loading bartMachine.

options(
    java.parameters = c(
        "-Xmx20g",
        "--add-modules=jdk.incubator.vector",
        "-XX:+UseZGC"
    )
)


# LOAD REQUIRED PACKAGES


library(bartMachine)
library(pROC)

set.seed(42)


# LOAD TRAINING DATA


X <- read.csv(
    "../results/training/bart_mia_input/Kenya_X_train.csv"
)

y_df <- read.csv(
    "../results/training/bart_mia_input/Kenya_y_train.csv"
)

fold_df <- read.csv(
    "../results/training/cv_folds/Kenya_folds.csv"
)


# TARGET


y <- factor(
    y_df$exporter,
    levels = c(0, 1),
    labels = c("0", "1")
)


# CROSS-VALIDATION FOLDS


folds_vec <- fold_df$fold


# BASIC VALIDATION

cat("\n")
cat(" \n")
cat("BART-MIA — Kenya\n")
cat(" \n")

cat(
    "Training observations:",
    nrow(X),
    "\n"
)

cat(
    "Predictors:",
    ncol(X),
    "\n"
)

cat(
    "Missing predictor values:",
    sum(is.na(X)),
    "\n"
)

cat(
    "Class 0:",
    sum(y == "0"),
    "\n"
)

cat(
    "Class 1:",
    sum(y == "1"),
    "\n"
)

# VERIFY FOLD STRUCTURE


cat("\nFold distribution:\n")

print(
    table(folds_vec)
)

if (length(folds_vec) != nrow(X)) {

    stop(
        paste0(
            "Fold length mismatch: ",
            "folds = ",
            length(folds_vec),
            ", observations = ",
            nrow(X)
        )
    )
}


# BART-MIA CROSS-VALIDATION


cat("\n")
cat(" \n")
cat("STARTING BART-MIA CROSS-VALIDATION\n")
cat(" \n")

cv_result <- k_fold_cv(
    X = X,
    y = y,
    folds_vec = folds_vec,
    verbose = TRUE,
    num_trees = 50,
    num_burn_in = 250,
    num_iterations_after_burn_in = 1000,
    use_missing_data = TRUE,
    use_missing_data_dummies_as_covars = FALSE,
    seed = 42
)


# CROSS-VALIDATED PREDICTIONS


cat("\n")
cat(" \n")
cat("CV PREDICTION DIAGNOSTICS\n")
cat(" \n")

cat(
    "Length of y:",
    length(y),
    "\n"
)

# IMPORTANT:
# bartMachine 1.4.2 returns `phat`, not `p_hat`.

cv_prob <- cv_result$phat

cat(
    "Length of phat:",
    length(cv_prob),
    "\n"
)


# CONVERT PREDICTIONS TO NUMERIC


cv_prob <- as.numeric(
    cv_prob
)

y_numeric <- as.numeric(y) - 1

cat(
    "Length of y_numeric:",
    length(y_numeric),
    "\n"
)

cat(
    "Length of cv_prob:",
    length(cv_prob),
    "\n"
)

cat(
    "Missing probabilities:",
    sum(is.na(cv_prob)),
    "\n"
)


# CHECK PREDICTION LENGTH


if (
    length(y_numeric) != length(cv_prob)
) {

    stop(
        paste0(
            "BART-MIA prediction length mismatch: ",
            "y = ",
            length(y_numeric),
            ", cv_prob = ",
            length(cv_prob)
        )
    )
}

# CHECK PROBABILITY RANGE


cat(
    "Minimum predicted probability:",
    min(cv_prob, na.rm = TRUE),
    "\n"
)

cat(
    "Maximum predicted probability:",
    max(cv_prob, na.rm = TRUE),
    "\n"
)


# VALID OBSERVATIONS FOR ROC-AUC


valid <- (
    is.finite(y_numeric) &
    is.finite(cv_prob)
)

cat(
    "Valid ROC-AUC observations:",
    sum(valid),
    "\n"
)

if (
    sum(valid) < 2
) {

    stop(
        "Insufficient valid observations for ROC-AUC."
    )
}


# ROC-AUC


cat("\n")
cat("Calculating ROC-AUC...\n")

roc_result <- pROC::roc(
    response = y_numeric[valid],
    predictor = cv_prob[valid],
    quiet = TRUE,
    direction = "<"
)

cv_auc <- as.numeric(
    pROC::auc(
        roc_result
    )
)

cat(
    "\nBART-MIA CV ROC-AUC:",
    round(cv_auc, 6),
    "\n"
)


# FINAL BART-MIA MODEL


cat("\n")
cat(" \n")
cat("TRAINING FINAL BART-MIA MODEL\n")
cat(" \n")

bart_model <- bartMachine(
    X = X,
    y = y,
    num_trees = 50,
    num_burn_in = 250,
    num_iterations_after_burn_in = 1000,
    use_missing_data = TRUE,
    use_missing_data_dummies_as_covars = FALSE,
    serialize = TRUE,
    seed = 42,
    verbose = TRUE
)


# SAVE FINAL MODEL


saveRDS(
    bart_model,
    "../results/models/BART_MIA_Kenya.rds"
)

cat(
    "\nModel saved to:\n../results/models/BART_MIA_Kenya.rds\n"
)


# SAVE RESULTS


results <- data.frame(
    Country = "Kenya",
    Model = "BART-MIA",
    Best_CV_ROC_AUC = cv_auc
)

write.csv(
    results,
    "../results/training/BART_MIA_Kenya_results.csv",
    row.names = FALSE
)

cat(
    "\nResults saved to:\n../results/training/BART_MIA_Kenya_results.csv\n"
)


# COMPLETION


cat("\n")
cat(" \n")
cat("BART-MIA Kenya TRAINING: COMPLETED\n")
cat(" \n")
