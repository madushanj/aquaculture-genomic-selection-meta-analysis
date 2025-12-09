################################################################################
# Script: 02-meta-analysis.R
# Purpose: Main meta-analysis of genomic selection prediction accuracies
# Author: Meta-Analysis Workflow
# Date: 2025-12-09
################################################################################

# Clear workspace
rm(list = ls())

# Set random seed for reproducibility
set.seed(42)

################################################################################
# 1. LOAD REQUIRED PACKAGES
################################################################################

cat("Loading required packages...\n")

# List of required packages
required_packages <- c("metafor", "dplyr", "readr")

# Install missing packages
missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]
if(length(missing_packages) > 0) {
  cat("Installing missing packages:", paste(missing_packages, collapse = ", "), "\n")
  install.packages(missing_packages, repos = "https://cloud.r-project.org/")
}

# Load packages
suppressPackageStartupMessages({
  library(metafor)
  library(dplyr)
  library(readr)
})

cat("Packages loaded successfully.\n\n")

################################################################################
# 2. LOAD PROCESSED DATA
################################################################################

cat("Loading processed data...\n")

# Check if processed data exists
if (!file.exists("data/processed/prepared_data.rds")) {
  stop("Processed data not found. Please run 01-data-preparation.R first.")
}

# Load data
data <- readRDS("data/processed/prepared_data.rds")
cat("Data loaded successfully. Number of studies:", nrow(data), "\n\n")

################################################################################
# 3. FIXED-EFFECT META-ANALYSIS
################################################################################

cat("Running fixed-effect meta-analysis...\n")

# Fit fixed-effect model using Fisher's z transformed correlations
fe_model <- rma(yi = fisher_z, 
                vi = var_fisher_z,
                data = data,
                method = "FE",
                slab = paste(author, year, sep = ", "))

cat("\n=== FIXED-EFFECT MODEL RESULTS ===\n")
print(fe_model)

# Back-transform Fisher's z to correlation
fe_r <- tanh(coef(fe_model))
fe_ci_lower <- tanh(fe_model$ci.lb)
fe_ci_upper <- tanh(fe_model$ci.ub)

cat("\nFixed-effect summary (back-transformed to r):\n")
cat("Pooled r:", round(fe_r, 3), "\n")
cat("95% CI: [", round(fe_ci_lower, 3), ",", round(fe_ci_upper, 3), "]\n\n")

################################################################################
# 4. RANDOM-EFFECTS META-ANALYSIS
################################################################################

cat("Running random-effects meta-analysis...\n")

# Fit random-effects model using REML
re_model <- rma(yi = fisher_z,
                vi = var_fisher_z,
                data = data,
                method = "REML",
                slab = paste(author, year, sep = ", "))

cat("\n=== RANDOM-EFFECTS MODEL RESULTS ===\n")
print(re_model)

# Back-transform Fisher's z to correlation
re_r <- tanh(coef(re_model))
re_ci_lower <- tanh(re_model$ci.lb)
re_ci_upper <- tanh(re_model$ci.ub)

cat("\nRandom-effects summary (back-transformed to r):\n")
cat("Pooled r:", round(re_r, 3), "\n")
cat("95% CI: [", round(re_ci_lower, 3), ",", round(re_ci_upper, 3), "]\n\n")

################################################################################
# 5. HETEROGENEITY STATISTICS
################################################################################

cat("=== HETEROGENEITY STATISTICS ===\n")

# Calculate I² (percentage of variation due to heterogeneity)
I2 <- re_model$I2
cat("I² (heterogeneity):", round(I2, 2), "%\n")

# Interpretation of I²
if (I2 < 25) {
  cat("Interpretation: Low heterogeneity\n")
} else if (I2 < 50) {
  cat("Interpretation: Moderate heterogeneity\n")
} else if (I2 < 75) {
  cat("Interpretation: Substantial heterogeneity\n")
} else {
  cat("Interpretation: Considerable heterogeneity\n")
}

# Q statistic (test for heterogeneity)
cat("\nCochran's Q:", round(re_model$QE, 2), "\n")
cat("df:", re_model$k - 1, "\n")
cat("p-value:", format.pval(re_model$QEp, eps = 0.001), "\n")

# Tau² (between-study variance)
cat("\nTau² (between-study variance):", round(re_model$tau2, 4), "\n")
cat("Tau (between-study SD):", round(sqrt(re_model$tau2), 4), "\n\n")

################################################################################
# 6. FOREST PLOT
################################################################################

cat("Creating forest plot...\n")

# Create results directory if it doesn't exist
if (!dir.exists("results/figures")) {
  dir.create("results/figures", recursive = TRUE)
}

# Save forest plot
pdf("results/figures/forest_plot_main.pdf", width = 12, height = 8)
forest(re_model,
       xlab = "Fisher's z",
       mlab = "Random-Effects Model",
       cex = 0.8,
       header = "Study",
       top = 2)

# Add back-transformed correlation scale
axis(side = 1, at = seq(-2, 2, 0.5), 
     labels = round(tanh(seq(-2, 2, 0.5)), 2),
     line = 2.5)
mtext("Correlation (r)", side = 1, line = 4.5)

dev.off()
cat("Forest plot saved: results/figures/forest_plot_main.pdf\n\n")

################################################################################
# 7. LEAVE-ONE-OUT SENSITIVITY ANALYSIS
################################################################################

cat("Performing leave-one-out sensitivity analysis...\n")

# Leave-one-out analysis
loo_results <- leave1out(re_model)

cat("\n=== LEAVE-ONE-OUT ANALYSIS ===\n")
print(loo_results)

# Check for influential studies
loo_summary <- data.frame(
  study = data$study_id,
  estimate = tanh(loo_results$estimate),
  ci_lower = tanh(loo_results$ci.lb),
  ci_upper = tanh(loo_results$ci.ub),
  Q = loo_results$Q,
  I2 = loo_results$I2
)

# Identify studies where removal changes estimate by >10%
baseline_r <- re_r
influential <- loo_summary %>%
  mutate(
    change_pct = abs((estimate - baseline_r) / baseline_r * 100)
  ) %>%
  filter(change_pct > 10)

if (nrow(influential) > 0) {
  cat("\nInfluential studies (>10% change):\n")
  print(influential)
} else {
  cat("\nNo highly influential studies detected.\n")
}

cat("\n")

################################################################################
# 8. INFLUENCE DIAGNOSTICS
################################################################################

cat("Running influence diagnostics...\n")

# Calculate influence diagnostics
inf <- influence(re_model)

# Plot influence diagnostics
pdf("results/figures/influence_diagnostics.pdf", width = 12, height = 10)
plot(inf)
dev.off()
cat("Influence diagnostics saved: results/figures/influence_diagnostics.pdf\n\n")

# Identify outliers and influential cases
cat("Outlier and influential case detection:\n")
cat("Studies with |standardized residual| > 2:\n")
outliers <- which(abs(inf$inf$rstudent) > 2)
if (length(outliers) > 0) {
  print(data[outliers, c("study_id", "author", "year", "prediction_accuracy_r")])
} else {
  cat("None detected.\n")
}

cat("\nStudies with Cook's distance > 4/k:\n")
influential_cook <- which(inf$inf$cook.d > 4/re_model$k)
if (length(influential_cook) > 0) {
  print(data[influential_cook, c("study_id", "author", "year", "prediction_accuracy_r")])
} else {
  cat("None detected.\n")
}

cat("\n")

################################################################################
# 9. META-REGRESSION WITH MODERATORS
################################################################################

cat("Running meta-regression with moderators...\n")

# Check if moderators are available
moderator_vars <- c("sample_size_validation", "number_of_snps", "year")
available_moderators <- moderator_vars[moderator_vars %in% names(data)]

if (length(available_moderators) > 0) {
  cat("Available moderators:", paste(available_moderators, collapse = ", "), "\n\n")
  
  # Meta-regression with sample size
  if ("sample_size_validation" %in% available_moderators) {
    cat("=== META-REGRESSION: SAMPLE SIZE ===\n")
    mr_sample <- rma(yi = fisher_z,
                     vi = var_fisher_z,
                     mods = ~ sample_size_validation,
                     data = data,
                     method = "REML")
    print(mr_sample)
    cat("\n")
  }
  
  # Meta-regression with number of SNPs
  if ("number_of_snps" %in% available_moderators) {
    cat("=== META-REGRESSION: NUMBER OF SNPs ===\n")
    mr_snps <- rma(yi = fisher_z,
                   vi = var_fisher_z,
                   mods = ~ number_of_snps,
                   data = data,
                   method = "REML")
    print(mr_snps)
    cat("\n")
  }
  
  # Meta-regression with publication year
  if ("year" %in% available_moderators) {
    cat("=== META-REGRESSION: PUBLICATION YEAR ===\n")
    mr_year <- rma(yi = fisher_z,
                   vi = var_fisher_z,
                   mods = ~ year,
                   data = data,
                   method = "REML")
    print(mr_year)
    cat("\n")
  }
} else {
  cat("No suitable moderators available for meta-regression.\n\n")
}

################################################################################
# 10. SAVE MODEL OBJECTS AND RESULTS
################################################################################

cat("Saving model objects and results...\n")

# Create output directory
if (!dir.exists("results/tables")) {
  dir.create("results/tables", recursive = TRUE)
}

# Save model objects
saveRDS(list(
  fe_model = fe_model,
  re_model = re_model,
  loo_results = loo_results,
  influence = inf
), "results/tables/meta_analysis_models.rds")

# Create summary table
summary_table <- data.frame(
  Model = c("Fixed-Effect", "Random-Effects"),
  Estimate_z = c(coef(fe_model), coef(re_model)),
  SE = c(fe_model$se, re_model$se),
  CI_lower_z = c(fe_model$ci.lb, re_model$ci.lb),
  CI_upper_z = c(fe_model$ci.ub, re_model$ci.ub),
  Estimate_r = c(fe_r, re_r),
  CI_lower_r = c(fe_ci_lower, re_ci_lower),
  CI_upper_r = c(fe_ci_upper, re_ci_upper),
  p_value = c(fe_model$pval, re_model$pval),
  I2 = c(NA, I2),
  tau2 = c(NA, re_model$tau2),
  Q = c(NA, re_model$QE),
  Q_pval = c(NA, re_model$QEp)
)

# Export summary table
write_csv(summary_table, "results/tables/meta_analysis_summary.csv")
cat("Summary table saved: results/tables/meta_analysis_summary.csv\n\n")

################################################################################
# 11. SESSION INFO
################################################################################

cat("=== SESSION INFORMATION ===\n")
sessionInfo()

cat("\n=== META-ANALYSIS COMPLETE ===\n")
cat("Results saved in results/ directory.\n")
cat("Next step: Run 03-publication-bias.R\n")
