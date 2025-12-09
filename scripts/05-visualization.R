################################################################################
# Script: 05-visualization.R
# Purpose: Create publication-ready visualizations and PRISMA flow diagram
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
required_packages <- c("metafor", "dplyr", "readr", "ggplot2", 
                       "gridExtra", "DiagrammeR")

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
  library(ggplot2)
  library(gridExtra)
  library(DiagrammeR)
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
# 3. PUBLICATION-READY FOREST PLOT
################################################################################

cat("Creating publication-ready forest plot...\n")

# Create results directory if it doesn't exist
if (!dir.exists("results/figures")) {
  dir.create("results/figures", recursive = TRUE)
}

# Enhanced forest plot with better formatting
png("results/figures/forest_plot_publication.png", 
    width = 3000, height = 2400, res = 300)

forest(re_model,
       xlim = c(-3, 3),
       xlab = "Prediction Accuracy (Fisher's z)",
       slab = paste(data$author, data$year, sep = " "),
       ilab = cbind(data$sample_size_validation, 
                    round(data$prediction_accuracy_r, 2)),
       ilab.xpos = c(-2, -1.5),
       cex = 0.75,
       header = c("Study", "Sample Size", "r"),
       mlab = "",
       refline = 0,
       col = "blue",
       border = "blue",
       lwd = 1.5)

# Add pooled estimate label
text(-3, -1, pos = 4, cex = 0.75, bquote(paste(
  "Random-Effects Model (REML): ",
  hat(r), " = ", .(sprintf("%.3f", tanh(coef(re_model)))),
  " [95% CI: ", .(sprintf("%.3f", tanh(re_model$ci.lb))),
  ", ", .(sprintf("%.3f", tanh(re_model$ci.ub))), "]"
)))

# Add heterogeneity statistics
text(-3, -2, pos = 4, cex = 0.75, bquote(paste(
  "Heterogeneity: ", I^2, " = ", .(sprintf("%.1f", re_model$I2)), "%, ",
  tau^2, " = ", .(sprintf("%.4f", re_model$tau2)), ", ",
  "Q(", .(re_model$k - 1), ") = ", .(sprintf("%.2f", re_model$QE)),
  ", p = ", .(format.pval(re_model$QEp, eps = 0.001))
)))

dev.off()
cat("Publication forest plot saved: results/figures/forest_plot_publication.png\n\n")

# Also save as PDF
pdf("results/figures/forest_plot_publication.pdf", width = 12, height = 10)
forest(re_model,
       xlim = c(-3, 3),
       xlab = "Prediction Accuracy (Fisher's z)",
       slab = paste(data$author, data$year, sep = " "),
       ilab = cbind(data$sample_size_validation, 
                    round(data$prediction_accuracy_r, 2)),
       ilab.xpos = c(-2, -1.5),
       cex = 0.75,
       header = c("Study", "Sample Size", "r"),
       mlab = "",
       refline = 0,
       col = "blue",
       border = "blue",
       lwd = 1.5)

text(-3, -1, pos = 4, cex = 0.75, bquote(paste(
  "Random-Effects Model (REML): ",
  hat(r), " = ", .(sprintf("%.3f", tanh(coef(re_model)))),
  " [95% CI: ", .(sprintf("%.3f", tanh(re_model$ci.lb))),
  ", ", .(sprintf("%.3f", tanh(re_model$ci.ub))), "]"
)))

text(-3, -2, pos = 4, cex = 0.75, bquote(paste(
  "Heterogeneity: ", I^2, " = ", .(sprintf("%.1f", re_model$I2)), "%, ",
  tau^2, " = ", .(sprintf("%.4f", re_model$tau2)), ", ",
  "Q(", .(re_model$k - 1), ") = ", .(sprintf("%.2f", re_model$QE)),
  ", p = ", .(format.pval(re_model$QEp, eps = 0.001))
)))

dev.off()
cat("Publication forest plot PDF saved: results/figures/forest_plot_publication.pdf\n\n")

################################################################################
# 4. CUMULATIVE FOREST PLOT
################################################################################

cat("Creating cumulative forest plot...\n")

# Cumulative meta-analysis (by year)
data_sorted <- data %>% arrange(year)
cum_model <- cumul(re_model, order = order(data$year))

# Plot cumulative forest plot
pdf("results/figures/forest_plot_cumulative.pdf", width = 12, height = 10)
forest(cum_model,
       xlab = "Cumulative Fisher's z",
       main = "Cumulative Meta-Analysis (Ordered by Year)",
       cex = 0.75)
dev.off()

cat("Cumulative forest plot saved: results/figures/forest_plot_cumulative.pdf\n\n")

################################################################################
# 5. ENHANCED FUNNEL PLOT WITH GGPLOT2
################################################################################

cat("Creating enhanced funnel plot with ggplot2...\n")

# Prepare data for ggplot
funnel_data <- data.frame(
  effect = data$fisher_z,
  se = data$se_fisher_z,
  study = paste(data$author, data$year)
)

# Calculate funnel bounds
max_se <- max(funnel_data$se)
se_seq <- seq(0, max_se, length.out = 100)
pooled_effect <- coef(re_model)

# 95% CI bounds
ci_lower <- pooled_effect - 1.96 * se_seq
ci_upper <- pooled_effect + 1.96 * se_seq

# Create ggplot funnel plot
p_funnel <- ggplot(funnel_data, aes(x = effect, y = se)) +
  geom_point(size = 3, alpha = 0.6, color = "steelblue") +
  geom_vline(xintercept = pooled_effect, linetype = "dashed", color = "red", size = 1) +
  geom_line(data = data.frame(x = ci_lower, y = se_seq), 
            aes(x = x, y = y), linetype = "dotted", color = "gray50") +
  geom_line(data = data.frame(x = ci_upper, y = se_seq), 
            aes(x = x, y = y), linetype = "dotted", color = "gray50") +
  scale_y_reverse() +
  labs(x = "Fisher's z", 
       y = "Standard Error",
       title = "Funnel Plot for Publication Bias Assessment") +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  )

ggsave("results/figures/funnel_plot_ggplot.png", p_funnel, 
       width = 10, height = 8, dpi = 300)
ggsave("results/figures/funnel_plot_ggplot.pdf", p_funnel, 
       width = 10, height = 8)

cat("Enhanced funnel plot saved: results/figures/funnel_plot_ggplot.png/pdf\n\n")

################################################################################
# 6. META-REGRESSION SCATTER PLOTS
################################################################################

cat("Creating meta-regression scatter plots...\n")

# Meta-regression with sample size
if ("sample_size_validation" %in% names(data)) {
  p_sample <- ggplot(data, aes(x = sample_size_validation, y = prediction_accuracy_r)) +
    geom_point(aes(size = weight), alpha = 0.6, color = "steelblue") +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    labs(x = "Sample Size (Validation Set)",
         y = "Prediction Accuracy (r)",
         title = "Relationship Between Sample Size and Prediction Accuracy") +
    theme_classic() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 12, face = "bold"),
      legend.position = "none"
    )
  
  ggsave("results/figures/metaregression_sample_size.png", p_sample, 
         width = 10, height = 8, dpi = 300)
  ggsave("results/figures/metaregression_sample_size.pdf", p_sample, 
         width = 10, height = 8)
  cat("Sample size meta-regression plot saved.\n")
}

# Meta-regression with number of SNPs
if ("number_of_snps" %in% names(data)) {
  p_snps <- ggplot(data, aes(x = number_of_snps, y = prediction_accuracy_r)) +
    geom_point(aes(size = weight), alpha = 0.6, color = "darkgreen") +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    scale_x_log10() +
    labs(x = "Number of SNPs (log scale)",
         y = "Prediction Accuracy (r)",
         title = "Relationship Between SNP Density and Prediction Accuracy") +
    theme_classic() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 12, face = "bold"),
      legend.position = "none"
    )
  
  ggsave("results/figures/metaregression_snps.png", p_snps, 
         width = 10, height = 8, dpi = 300)
  ggsave("results/figures/metaregression_snps.pdf", p_snps, 
         width = 10, height = 8)
  cat("SNP density meta-regression plot saved.\n")
}

cat("\n")

################################################################################
# 7. PRISMA FLOW DIAGRAM
################################################################################

cat("Creating PRISMA flow diagram...\n")

# Define PRISMA flow diagram using DiagrammeR
# Note: These numbers should be updated with actual study counts
prisma_diagram <- grViz("
  digraph prisma {
    
    # Graph attributes
    graph [layout = dot, rankdir = TB, fontname = Arial]
    
    # Node attributes
    node [shape = box, style = filled, fillcolor = lightblue, 
          fontname = Arial, fontsize = 10, width = 3]
    
    # Identification
    identification [label = 'Records identified through\\ndatabase searching\\n(n = 1,250)', fillcolor = '#E8F4F8']
    additional [label = 'Additional records identified\\nthrough other sources\\n(n = 45)', fillcolor = '#E8F4F8']
    
    # Screening
    afterdup [label = 'Records after duplicates removed\\n(n = 980)', fillcolor = '#FFF4E6']
    screened [label = 'Records screened\\n(n = 980)', fillcolor = '#FFF4E6']
    excluded_screening [label = 'Records excluded\\n(n = 825)', fillcolor = '#FFE6E6']
    
    # Eligibility
    fulltext [label = 'Full-text articles assessed\\nfor eligibility\\n(n = 155)', fillcolor = '#F0F8F0']
    excluded_fulltext [label = 'Full-text articles excluded,\\nwith reasons\\n(n = 102)\\n\\n- No GS prediction accuracy (n=45)\\n- Review/meta-analysis (n=28)\\n- Simulation only (n=18)\\n- Non-aquaculture species (n=11)', fillcolor = '#FFE6E6']
    
    # Included
    included [label = 'Studies included in\\nqualitative synthesis\\n(n = 53)', fillcolor = '#E6F3E6']
    meta [label = 'Studies included in\\nquantitative synthesis\\n(meta-analysis)\\n(n = 48)', fillcolor = '#D4E9D4']
    
    # Edges with labels
    identification -> afterdup
    additional -> afterdup
    afterdup -> screened
    screened -> excluded_screening [label = 'Excluded', style = dashed]
    screened -> fulltext
    fulltext -> excluded_fulltext [label = 'Excluded', style = dashed]
    fulltext -> included
    included -> meta
    
    # Subgraph for better layout
    {rank = same; identification; additional}
    {rank = same; screened; excluded_screening}
    {rank = same; fulltext; excluded_fulltext}
  }
")

# Save PRISMA diagram
prisma_diagram %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg::rsvg_png("results/figures/PRISMA_flow_diagram.png", width = 2400, height = 3000)

cat("PRISMA flow diagram saved: results/figures/PRISMA_flow_diagram.png\n")

# Also save as PDF
prisma_diagram %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg::rsvg_pdf("results/figures/PRISMA_flow_diagram.pdf")

cat("PRISMA flow diagram PDF saved: results/figures/PRISMA_flow_diagram.pdf\n\n")

################################################################################
# 8. SUMMARY TABLES
################################################################################

cat("Creating summary tables...\n")

# Create results directory
if (!dir.exists("results/tables")) {
  dir.create("results/tables", recursive = TRUE)
}

# Study characteristics table
study_table <- data %>%
  select(study_id, author, year, species_common, trait_category_std,
         sample_size_validation, number_of_snps, gs_method_std,
         prediction_accuracy_r, heritability) %>%
  arrange(year, author)

write_csv(study_table, "results/tables/study_characteristics.csv")
cat("Study characteristics table saved: results/tables/study_characteristics.csv\n")

# Summary statistics by species
if ("species_group" %in% names(data)) {
  species_summary <- data %>%
    group_by(species_group) %>%
    summarise(
      n_studies = n(),
      mean_r = mean(prediction_accuracy_r, na.rm = TRUE),
      sd_r = sd(prediction_accuracy_r, na.rm = TRUE),
      min_r = min(prediction_accuracy_r, na.rm = TRUE),
      max_r = max(prediction_accuracy_r, na.rm = TRUE),
      median_sample_size = median(sample_size_validation, na.rm = TRUE)
    ) %>%
    arrange(desc(n_studies))
  
  write_csv(species_summary, "results/tables/summary_by_species.csv")
  cat("Species summary table saved: results/tables/summary_by_species.csv\n")
}

# Summary statistics by trait
if ("trait_category_std" %in% names(data)) {
  trait_summary <- data %>%
    group_by(trait_category_std) %>%
    summarise(
      n_studies = n(),
      mean_r = mean(prediction_accuracy_r, na.rm = TRUE),
      sd_r = sd(prediction_accuracy_r, na.rm = TRUE),
      min_r = min(prediction_accuracy_r, na.rm = TRUE),
      max_r = max(prediction_accuracy_r, na.rm = TRUE)
    ) %>%
    arrange(desc(n_studies))
  
  write_csv(trait_summary, "results/tables/summary_by_trait.csv")
  cat("Trait summary table saved: results/tables/summary_by_trait.csv\n")
}

cat("\n")

################################################################################
# 9. CREATE MULTI-PANEL FIGURE
################################################################################

cat("Creating multi-panel figure...\n")

# This would combine multiple plots into a single publication figure
# For now, we create individual components which can be assembled in a publication

cat("Individual figure components have been created.\n")
cat("Use gridExtra::grid.arrange() to combine plots as needed.\n\n")

################################################################################
# 10. SESSION INFO
################################################################################

cat("=== SESSION INFORMATION ===\n")
sessionInfo()

cat("\n=== VISUALIZATION COMPLETE ===\n")
cat("All figures saved in results/figures/ directory.\n")
cat("All tables saved in results/tables/ directory.\n")
cat("\nAnalysis workflow complete!\n")
cat("Please review all outputs before preparing your manuscript.\n")
