################################################################################
# Script: 03-publication-bias.R
# Purpose: Assess and visualize publication bias
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
# 2. LOAD DATA AND MODELS
################################################################################

cat("Loading processed data and models...\n")

# Check if files exist
if (!file.exists("data/processed/prepared_data.rds")) {
  stop("Processed data not found. Please run 01-data-preparation.R first.")
}

if (!file.exists("results/tables/meta_analysis_models.rds")) {
  stop("Meta-analysis models not found. Please run 02-meta-analysis.R first.")
}

# Load data and models
data <- readRDS("data/processed/prepared_data.rds")
models <- readRDS("results/tables/meta_analysis_models.rds")
re_model <- models$re_model

cat("Data and models loaded successfully.\n\n")

################################################################################
# 3. STANDARD FUNNEL PLOT
################################################################################

cat("Creating standard funnel plot...\n")

# Create results directory if it doesn't exist
if (!dir.exists("results/figures")) {
  dir.create("results/figures", recursive = TRUE)
}

# Standard funnel plot
pdf("results/figures/funnel_plot_standard.pdf", width = 10, height = 8)
funnel(re_model,
       xlab = "Fisher's z",
       ylab = "Standard Error",
       main = "Funnel Plot - Standard",
       back = "white",
       shade = "white")
dev.off()

cat("Standard funnel plot saved: results/figures/funnel_plot_standard.pdf\n\n")

################################################################################
# 4. CONTOUR-ENHANCED FUNNEL PLOT
################################################################################

cat("Creating contour-enhanced funnel plot...\n")

# Contour-enhanced funnel plot
pdf("results/figures/funnel_plot_contour.pdf", width = 10, height = 8)
funnel(re_model,
       xlab = "Fisher's z",
       ylab = "Standard Error",
       main = "Funnel Plot - Contour Enhanced",
       level = c(90, 95, 99),
       shade = c("white", "gray75", "gray60"),
       refline = 0,
       legend = TRUE)
dev.off()

cat("Contour-enhanced funnel plot saved: results/figures/funnel_plot_contour.pdf\n\n")

################################################################################
# 5. EGGER'S REGRESSION TEST
################################################################################

cat("Performing Egger's regression test for funnel plot asymmetry...\n")

# Egger's test
egger_test <- regtest(re_model, model = "lm")

cat("\n=== EGGER'S REGRESSION TEST ===\n")
print(egger_test)

# Interpretation
cat("\nInterpretation:\n")
if (egger_test$pval < 0.05) {
  cat("Significant asymmetry detected (p < 0.05).\n")
  cat("This suggests potential publication bias or small-study effects.\n")
} else {
  cat("No significant asymmetry detected (p >= 0.05).\n")
  cat("No strong evidence of publication bias.\n")
}
cat("\n")

################################################################################
# 6. BEGG'S RANK CORRELATION TEST
################################################################################

cat("Performing Begg's rank correlation test...\n")

# Begg's test
begg_test <- ranktest(re_model)

cat("\n=== BEGG'S RANK CORRELATION TEST ===\n")
print(begg_test)

# Interpretation
cat("\nInterpretation:\n")
if (begg_test$pval < 0.05) {
  cat("Significant correlation detected (p < 0.05).\n")
  cat("This suggests potential publication bias.\n")
} else {
  cat("No significant correlation detected (p >= 0.05).\n")
  cat("No strong evidence of publication bias.\n")
}
cat("\n")

################################################################################
# 7. TRIM-AND-FILL ANALYSIS
################################################################################

cat("Performing trim-and-fill analysis...\n")

# Trim-and-fill using both estimators
taf_L <- trimfill(re_model, estimator = "L0")
taf_R <- trimfill(re_model, estimator = "R0")

cat("\n=== TRIM-AND-FILL ANALYSIS (L0 ESTIMATOR) ===\n")
print(taf_L)

cat("\n=== TRIM-AND-FILL ANALYSIS (R0 ESTIMATOR) ===\n")
print(taf_R)

# Number of imputed studies
k0_L <- taf_L$k0
k0_R <- taf_R$k0

cat("\nNumber of missing studies (L0):", k0_L, "\n")
cat("Number of missing studies (R0):", k0_R, "\n")

# Back-transform adjusted estimates
if (k0_L > 0) {
  taf_L_r <- tanh(coef(taf_L))
  cat("Adjusted pooled r (L0):", round(taf_L_r, 3), "\n")
}

if (k0_R > 0) {
  taf_R_r <- tanh(coef(taf_R))
  cat("Adjusted pooled r (R0):", round(taf_R_r, 3), "\n")
}

# Funnel plot with trim-and-fill
pdf("results/figures/funnel_plot_trimfill.pdf", width = 10, height = 8)
funnel(taf_L,
       xlab = "Fisher's z",
       ylab = "Standard Error",
       main = "Funnel Plot - Trim and Fill (L0)",
       pch = c(21, 24),
       bg = c("gray", "white"),
       legend = TRUE)
dev.off()

cat("\nTrim-and-fill funnel plot saved: results/figures/funnel_plot_trimfill.pdf\n\n")

################################################################################
# 8. FAIL-SAFE N (ROSENTHAL)
################################################################################

cat("Calculating fail-safe N (Rosenthal method)...\n")

# Calculate fail-safe N
tryCatch({
  fsn_result <- fsn(yi = data$fisher_z, 
                    vi = data$var_fisher_z,
                    type = "Rosenthal")
  
  cat("\n=== FAIL-SAFE N (ROSENTHAL) ===\n")
  print(fsn_result)
  
  # Calculate benchmark (5k + 10)
  benchmark <- 5 * nrow(data) + 10
  cat("\nBenchmark (5k + 10):", benchmark, "\n")
  
  # Interpretation
  if (fsn_result$fsnum > benchmark) {
    cat("Fail-safe N (", fsn_result$fsnum, ") exceeds benchmark.\n")
    cat("Results appear robust to publication bias.\n")
  } else {
    cat("Fail-safe N (", fsn_result$fsnum, ") is below benchmark.\n")
    cat("Results may be sensitive to publication bias.\n")
  }
}, error = function(e) {
  cat("Error calculating fail-safe N:", e$message, "\n")
  cat("This may occur with small sample sizes or extreme effect sizes.\n")
})

cat("\n")

################################################################################
# 9. ADDITIONAL PUBLICATION BIAS VISUALIZATIONS
################################################################################

cat("Creating additional visualizations...\n")

# Radial plot (Galbraith plot)
pdf("results/figures/radial_plot.pdf", width = 10, height = 8)
radial(re_model,
       xlab = "Inverse Standard Error",
       main = "Radial Plot (Galbraith Plot)")
abline(h = 0, lty = 2)
dev.off()

cat("Radial plot saved: results/figures/radial_plot.pdf\n")

# L'Abbé plot (if appropriate)
# Note: L'Abbé plots are typically for binary outcomes
# For continuous outcomes, we create a scatter plot of effect sizes vs. standard errors

pdf("results/figures/effect_se_scatter.pdf", width = 10, height = 8)
plot(data$se_fisher_z, data$fisher_z,
     xlab = "Standard Error",
     ylab = "Fisher's z",
     main = "Effect Size vs. Standard Error",
     pch = 19,
     col = "steelblue")
abline(h = coef(re_model), lty = 2, col = "red")
text(max(data$se_fisher_z) * 0.8, coef(re_model),
     paste("Pooled estimate =", round(coef(re_model), 3)),
     pos = 3, col = "red")
dev.off()

cat("Effect size scatter plot saved: results/figures/effect_se_scatter.pdf\n\n")

################################################################################
# 10. SAVE PUBLICATION BIAS RESULTS
################################################################################

cat("Saving publication bias results...\n")

# Create results directory
if (!dir.exists("results/tables")) {
  dir.create("results/tables", recursive = TRUE)
}

# Compile results
pub_bias_results <- data.frame(
  Test = c("Egger's regression", "Begg's rank correlation", 
           "Trim-and-fill (L0)", "Trim-and-fill (R0)"),
  Statistic = c(egger_test$zval, begg_test$tau,
                ifelse(k0_L > 0, coef(taf_L), NA),
                ifelse(k0_R > 0, coef(taf_R), NA)),
  P_value = c(egger_test$pval, begg_test$pval, 
              ifelse(k0_L > 0, taf_L$pval, NA),
              ifelse(k0_R > 0, taf_R$pval, NA)),
  Missing_studies = c(NA, NA, k0_L, k0_R),
  Interpretation = c(
    ifelse(egger_test$pval < 0.05, "Asymmetry detected", "No asymmetry"),
    ifelse(begg_test$pval < 0.05, "Bias detected", "No bias"),
    ifelse(k0_L > 0, paste(k0_L, "studies imputed"), "No adjustment"),
    ifelse(k0_R > 0, paste(k0_R, "studies imputed"), "No adjustment")
  )
)

# Export results
write_csv(pub_bias_results, "results/tables/publication_bias_tests.csv")
cat("Publication bias results saved: results/tables/publication_bias_tests.csv\n\n")

################################################################################
# 11. SUMMARY AND RECOMMENDATIONS
################################################################################

cat("=== PUBLICATION BIAS ASSESSMENT SUMMARY ===\n\n")

# Count significant tests
sig_count <- sum(c(egger_test$pval < 0.05, begg_test$pval < 0.05))

cat("Number of significant bias tests:", sig_count, "out of 2\n\n")

cat("Recommendations:\n")
if (sig_count == 0) {
  cat("- No strong evidence of publication bias detected.\n")
  cat("- Results appear reasonably robust.\n")
  cat("- Standard meta-analysis results can be reported with confidence.\n")
} else if (sig_count == 1) {
  cat("- Some evidence of publication bias detected.\n")
  cat("- Consider reporting both unadjusted and trim-and-fill adjusted estimates.\n")
  cat("- Investigate potential sources of bias through sensitivity analyses.\n")
} else {
  cat("- Strong evidence of publication bias detected.\n")
  cat("- Report trim-and-fill adjusted estimates alongside original results.\n")
  cat("- Conduct thorough sensitivity analyses.\n")
  cat("- Consider searching for unpublished studies or gray literature.\n")
}

cat("\n")

################################################################################
# 12. SESSION INFO
################################################################################

cat("=== SESSION INFORMATION ===\n")
sessionInfo()

cat("\n=== PUBLICATION BIAS ANALYSIS COMPLETE ===\n")
cat("Results saved in results/ directory.\n")
cat("Next step: Run 04-subgroup-analysis.R\n")
