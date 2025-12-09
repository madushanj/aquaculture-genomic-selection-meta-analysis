################################################################################
# Script: 04-subgroup-analysis.R
# Purpose: Subgroup analyses and moderator tests
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
# 3. SUBGROUP ANALYSIS BY SPECIES GROUP
################################################################################

cat("=== SUBGROUP ANALYSIS: SPECIES GROUP ===\n\n")

# Check if species_group variable exists
if ("species_group" %in% names(data)) {
  # Count studies per group
  species_counts <- data %>% count(species_group)
  cat("Studies per species group:\n")
  print(species_counts)
  cat("\n")
  
  # Filter groups with at least 2 studies
  valid_groups <- species_counts %>% 
    filter(n >= 2) %>% 
    pull(species_group)
  
  if (length(valid_groups) >= 2) {
    data_species <- data %>% filter(species_group %in% valid_groups)
    
    # Subgroup meta-analysis
    species_model <- rma(yi = fisher_z,
                        vi = var_fisher_z,
                        mods = ~ species_group - 1,
                        data = data_species,
                        method = "REML")
    
    print(species_model)
    
    # Test for subgroup differences
    cat("\nTest for subgroup differences:\n")
    cat("QM (model):", round(species_model$QM, 2), "\n")
    cat("df:", species_model$m, "\n")
    cat("p-value:", format.pval(species_model$QMp, eps = 0.001), "\n\n")
    
    # Back-transform estimates
    species_summary <- data.frame(
      Species_Group = gsub("species_group", "", names(coef(species_model))),
      Estimate_z = coef(species_model),
      SE = species_model$se,
      Estimate_r = tanh(coef(species_model)),
      CI_lower_r = tanh(coef(species_model) - 1.96 * species_model$se),
      CI_upper_r = tanh(coef(species_model) + 1.96 * species_model$se),
      n_studies = as.numeric(table(data_species$species_group))
    )
    
    cat("Summary by species group (back-transformed to r):\n")
    print(species_summary)
    cat("\n")
    
    # Save species subgroup model
    species_results <- list(model = species_model, summary = species_summary)
  } else {
    cat("Insufficient groups with >= 2 studies for subgroup analysis.\n\n")
    species_results <- NULL
  }
} else {
  cat("Species group variable not found. Skipping this analysis.\n\n")
  species_results <- NULL
}

################################################################################
# 4. SUBGROUP ANALYSIS BY TRAIT CATEGORY
################################################################################

cat("=== SUBGROUP ANALYSIS: TRAIT CATEGORY ===\n\n")

# Check if trait_category_std variable exists
if ("trait_category_std" %in% names(data)) {
  # Count studies per category
  trait_counts <- data %>% count(trait_category_std)
  cat("Studies per trait category:\n")
  print(trait_counts)
  cat("\n")
  
  # Filter categories with at least 2 studies
  valid_traits <- trait_counts %>% 
    filter(n >= 2) %>% 
    pull(trait_category_std)
  
  if (length(valid_traits) >= 2) {
    data_trait <- data %>% filter(trait_category_std %in% valid_traits)
    
    # Subgroup meta-analysis
    trait_model <- rma(yi = fisher_z,
                      vi = var_fisher_z,
                      mods = ~ trait_category_std - 1,
                      data = data_trait,
                      method = "REML")
    
    print(trait_model)
    
    # Test for subgroup differences
    cat("\nTest for subgroup differences:\n")
    cat("QM (model):", round(trait_model$QM, 2), "\n")
    cat("df:", trait_model$m, "\n")
    cat("p-value:", format.pval(trait_model$QMp, eps = 0.001), "\n\n")
    
    # Back-transform estimates
    trait_summary <- data.frame(
      Trait_Category = gsub("trait_category_std", "", names(coef(trait_model))),
      Estimate_z = coef(trait_model),
      SE = trait_model$se,
      Estimate_r = tanh(coef(trait_model)),
      CI_lower_r = tanh(coef(trait_model) - 1.96 * trait_model$se),
      CI_upper_r = tanh(coef(trait_model) + 1.96 * trait_model$se),
      n_studies = as.numeric(table(data_trait$trait_category_std))
    )
    
    cat("Summary by trait category (back-transformed to r):\n")
    print(trait_summary)
    cat("\n")
    
    # Save trait subgroup model
    trait_results <- list(model = trait_model, summary = trait_summary)
  } else {
    cat("Insufficient categories with >= 2 studies for subgroup analysis.\n\n")
    trait_results <- NULL
  }
} else {
  cat("Trait category variable not found. Skipping this analysis.\n\n")
  trait_results <- NULL
}

################################################################################
# 5. SUBGROUP ANALYSIS BY GS METHOD
################################################################################

cat("=== SUBGROUP ANALYSIS: GS METHOD ===\n\n")

# Check if gs_method_std variable exists
if ("gs_method_std" %in% names(data)) {
  # Count studies per method
  method_counts <- data %>% count(gs_method_std)
  cat("Studies per GS method:\n")
  print(method_counts)
  cat("\n")
  
  # Filter methods with at least 2 studies
  valid_methods <- method_counts %>% 
    filter(n >= 2) %>% 
    pull(gs_method_std)
  
  if (length(valid_methods) >= 2) {
    data_method <- data %>% filter(gs_method_std %in% valid_methods)
    
    # Subgroup meta-analysis
    method_model <- rma(yi = fisher_z,
                       vi = var_fisher_z,
                       mods = ~ gs_method_std - 1,
                       data = data_method,
                       method = "REML")
    
    print(method_model)
    
    # Test for subgroup differences
    cat("\nTest for subgroup differences:\n")
    cat("QM (model):", round(method_model$QM, 2), "\n")
    cat("df:", method_model$m, "\n")
    cat("p-value:", format.pval(method_model$QMp, eps = 0.001), "\n\n")
    
    # Back-transform estimates
    method_summary <- data.frame(
      GS_Method = gsub("gs_method_std", "", names(coef(method_model))),
      Estimate_z = coef(method_model),
      SE = method_model$se,
      Estimate_r = tanh(coef(method_model)),
      CI_lower_r = tanh(coef(method_model) - 1.96 * method_model$se),
      CI_upper_r = tanh(coef(method_model) + 1.96 * method_model$se),
      n_studies = as.numeric(table(data_method$gs_method_std))
    )
    
    cat("Summary by GS method (back-transformed to r):\n")
    print(method_summary)
    cat("\n")
    
    # Save method subgroup model
    method_results <- list(model = method_model, summary = method_summary)
  } else {
    cat("Insufficient methods with >= 2 studies for subgroup analysis.\n\n")
    method_results <- NULL
  }
} else {
  cat("GS method variable not found. Skipping this analysis.\n\n")
  method_results <- NULL
}

################################################################################
# 6. SUBGROUP ANALYSIS BY GENOTYPING PLATFORM
################################################################################

cat("=== SUBGROUP ANALYSIS: GENOTYPING PLATFORM ===\n\n")

# Check if genotyping_platform variable exists
if ("genotyping_platform" %in% names(data)) {
  # Count studies per platform
  platform_counts <- data %>% count(genotyping_platform)
  cat("Studies per genotyping platform:\n")
  print(platform_counts)
  cat("\n")
  
  # Filter platforms with at least 2 studies
  valid_platforms <- platform_counts %>% 
    filter(n >= 2) %>% 
    pull(genotyping_platform)
  
  if (length(valid_platforms) >= 2) {
    data_platform <- data %>% filter(genotyping_platform %in% valid_platforms)
    
    # Subgroup meta-analysis
    platform_model <- rma(yi = fisher_z,
                         vi = var_fisher_z,
                         mods = ~ genotyping_platform - 1,
                         data = data_platform,
                         method = "REML")
    
    print(platform_model)
    
    # Test for subgroup differences
    cat("\nTest for subgroup differences:\n")
    cat("QM (model):", round(platform_model$QM, 2), "\n")
    cat("df:", platform_model$m, "\n")
    cat("p-value:", format.pval(platform_model$QMp, eps = 0.001), "\n\n")
    
    # Back-transform estimates
    platform_summary <- data.frame(
      Platform = gsub("genotyping_platform", "", names(coef(platform_model))),
      Estimate_z = coef(platform_model),
      SE = platform_model$se,
      Estimate_r = tanh(coef(platform_model)),
      CI_lower_r = tanh(coef(platform_model) - 1.96 * platform_model$se),
      CI_upper_r = tanh(coef(platform_model) + 1.96 * platform_model$se),
      n_studies = as.numeric(table(data_platform$genotyping_platform))
    )
    
    cat("Summary by genotyping platform (back-transformed to r):\n")
    print(platform_summary)
    cat("\n")
    
    # Save platform subgroup model
    platform_results <- list(model = platform_model, summary = platform_summary)
  } else {
    cat("Insufficient platforms with >= 2 studies for subgroup analysis.\n\n")
    platform_results <- NULL
  }
} else {
  cat("Genotyping platform variable not found. Skipping this analysis.\n\n")
  platform_results <- NULL
}

################################################################################
# 7. CREATE COMPARATIVE FOREST PLOTS
################################################################################

cat("Creating comparative forest plots for subgroups...\n")

# Create results directory if it doesn't exist
if (!dir.exists("results/figures")) {
  dir.create("results/figures", recursive = TRUE)
}

# Species group forest plot
if (!is.null(species_results)) {
  pdf("results/figures/forest_plot_species.pdf", width = 12, height = 8)
  forest(species_results$model,
         xlab = "Fisher's z",
         mlab = "Subgroup Estimates",
         main = "Forest Plot by Species Group",
         cex = 0.8)
  dev.off()
  cat("Species forest plot saved: results/figures/forest_plot_species.pdf\n")
}

# Trait category forest plot
if (!is.null(trait_results)) {
  pdf("results/figures/forest_plot_trait.pdf", width = 12, height = 8)
  forest(trait_results$model,
         xlab = "Fisher's z",
         mlab = "Subgroup Estimates",
         main = "Forest Plot by Trait Category",
         cex = 0.8)
  dev.off()
  cat("Trait forest plot saved: results/figures/forest_plot_trait.pdf\n")
}

# GS method forest plot
if (!is.null(method_results)) {
  pdf("results/figures/forest_plot_method.pdf", width = 12, height = 8)
  forest(method_results$model,
         xlab = "Fisher's z",
         mlab = "Subgroup Estimates",
         main = "Forest Plot by GS Method",
         cex = 0.8)
  dev.off()
  cat("Method forest plot saved: results/figures/forest_plot_method.pdf\n")
}

cat("\n")

################################################################################
# 8. EXPORT SUBGROUP RESULTS
################################################################################

cat("Exporting subgroup results...\n")

# Create results directory
if (!dir.exists("results/tables")) {
  dir.create("results/tables", recursive = TRUE)
}

# Save subgroup models
saveRDS(list(
  species = species_results,
  trait = trait_results,
  method = method_results,
  platform = platform_results
), "results/tables/subgroup_analysis_models.rds")

# Export summaries as CSV
if (!is.null(species_results)) {
  write_csv(species_results$summary, "results/tables/subgroup_species.csv")
  cat("Species subgroup results saved: results/tables/subgroup_species.csv\n")
}

if (!is.null(trait_results)) {
  write_csv(trait_results$summary, "results/tables/subgroup_trait.csv")
  cat("Trait subgroup results saved: results/tables/subgroup_trait.csv\n")
}

if (!is.null(method_results)) {
  write_csv(method_results$summary, "results/tables/subgroup_method.csv")
  cat("Method subgroup results saved: results/tables/subgroup_method.csv\n")
}

if (!is.null(platform_results)) {
  write_csv(platform_results$summary, "results/tables/subgroup_platform.csv")
  cat("Platform subgroup results saved: results/tables/subgroup_platform.csv\n")
}

cat("\n")

################################################################################
# 9. SESSION INFO
################################################################################

cat("=== SESSION INFORMATION ===\n")
sessionInfo()

cat("\n=== SUBGROUP ANALYSIS COMPLETE ===\n")
cat("Results saved in results/ directory.\n")
cat("Next step: Run 05-visualization.R\n")
