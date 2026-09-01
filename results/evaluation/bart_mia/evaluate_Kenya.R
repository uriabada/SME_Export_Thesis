
options(
    java.parameters = c(
        "-Xmx20g",
        "--add-modules=jdk.incubator.vector",
        "-XX:+UseZGC"
    )
)

library(bartMachine)

model <- readRDS(
    "/Users/eddiebest/Documents/SME_Export_Thesis/results/models/BART_MIA_Kenya.rds"
)

X_test <- read.csv(
    "/Users/eddiebest/Documents/SME_Export_Thesis/results/evaluation/bart_mia/Kenya_X_test.csv",
    check.names = FALSE
)

cat(
    "BART-MIA TEST PREDICTION — Kenya\n"
)

cat(
    "Test observations:",
    nrow(X_test),
    "\n"
)

cat(
    "Test predictors:",
    ncol(X_test),
    "\n"
)

probability <- predict(
    model,
    new_data = X_test,
    type = "prob"
)

probability <- as.numeric(
    probability
)

cat(
    "Prediction length:",
    length(probability),
    "\n"
)

cat(
    "Expected length:",
    nrow(X_test),
    "\n"
)

if (
    length(probability) != nrow(X_test)
) {
    stop(
        paste0(
            "Prediction length mismatch. Expected ",
            nrow(X_test),
            " but received ",
            length(probability)
        )
    )
}

if (
    any(is.na(probability))
) {
    stop(
        "BART-MIA returned NA probabilities."
    )
}

if (
    any(
        probability < 0 |
        probability > 1
    )
) {
    stop(
        "BART-MIA returned probabilities outside [0, 1]."
    )
}

write.csv(
    data.frame(
        probability = probability
    ),
    "/Users/eddiebest/Documents/SME_Export_Thesis/results/evaluation/bart_mia/Kenya_probabilities.csv",
    row.names = FALSE
)

cat(
    "BART-MIA prediction completed: Kenya\n"
)
