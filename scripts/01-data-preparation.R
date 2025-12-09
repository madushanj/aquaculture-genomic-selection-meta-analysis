################################################################################
# Script: 01-data-preparation.R
# Purpose: Data preparation and preprocessing for meta-analysis
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
required_packages <- c("dplyr", "tidyr", "readr")

# Install missing packages
missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]
if(length(missing_packages) > 0) {
  cat("Installing missing packages:", paste(missing_packages, collapse = ", "), "\n")
  install.packages(missing_packages, repos = "https://cloud.r-project.org/")
}

# Load packages
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
})

cat("Packages loaded successfully.\n\n")

################################################################################
# 2. READ DATA
################################################################################

cat("Reading data extraction file...\n")

# Define file paths
data_path <- "data/raw/data-extraction-form.csv"

# Check if file exists, if not use template
if (!file.exists(data_path)) {
  cat("Warning: Data file not found in data/raw/. Using template file.\n")
  data_path <- "templates/data-extraction-form.csv"
}

# Read data with error handling
tryCatch({
  raw_data <- read_csv(data_path, show_col_types = FALSE)
  cat("Data loaded successfully. Number of studies:", nrow(raw_data), "\n\n")
}, error = function(e) {
  cat("Error reading data file:", e$message, "\n")
  stop("Data loading failed. Please check the file path and format.")
})

################################################################################
# 3. DATA VALIDATION
################################################################################

cat("Performing data validation...\n")

# Check for required columns
required_cols <- c("study_id", "author", "year", "prediction_accuracy_r", 
                   "sample_size_validation", "species_common")

missing_cols <- setdiff(required_cols, names(raw_data))
if (length(missing_cols) > 0) {
  stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
}

# Check for duplicate study IDs
duplicates <- raw_data %>%
  count(study_id) %>%
  filter(n > 1)

if (nrow(duplicates) > 0) {
  warning("Duplicate study IDs found: ", paste(duplicates$study_id, collapse = ", "))
}

# Check for missing critical values
missing_summary <- raw_data %>%
  summarise(
    missing_r = sum(is.na(prediction_accuracy_r)),
    missing_n = sum(is.na(sample_size_validation)),
    missing_species = sum(is.na(species_common))
  )

cat("Missing values summary:\n")
print(missing_summary)
cat("\n")

################################################################################
# 4. CALCULATE EFFECT SIZES AND TRANSFORMATIONS
################################################################################

cat("Calculating effect sizes and transformations...\n")

# Fisher's z transformation for correlation coefficients
# z = 0.5 * ln((1 + r) / (1 - r))
# Variance of z: 1 / (n - 3)

processed_data <- raw_data %>%
  mutate(
    # Fisher's z transformation
    fisher_z = 0.5 * log((1 + prediction_accuracy_r) / (1 - prediction_accuracy_r)),
    
    # Variance of Fisher's z
    var_fisher_z = 1 / (sample_size_validation - 3),
    
    # Standard error of Fisher's z
    se_fisher_z = sqrt(var_fisher_z),
    
    # Calculate r² if not provided
    prediction_accuracy_r2 = ifelse(is.na(prediction_accuracy_r2),
                                     prediction_accuracy_r^2,
                                     prediction_accuracy_r2),
    
    # Precision weight (inverse variance)
    weight = 1 / var_fisher_z
  )

# Handle infinite or missing values
processed_data <- processed_data %>%
  filter(
    !is.na(fisher_z) & 
    !is.infinite(fisher_z) &
    !is.na(var_fisher_z) &
    !is.infinite(var_fisher_z)
  )

cat("Effect sizes calculated. Valid studies:", nrow(processed_data), "\n\n")

################################################################################
# 5. CREATE CATEGORICAL VARIABLES FOR SUBGROUP ANALYSIS
################################################################################

cat("Creating categorical variables for subgroup analysis...\n")

processed_data <- processed_data %>%
  mutate(
    # Species group classification
    species_group = case_when(
      grepl("salmon|trout|Salmo|Oncorhynchus", species_scientific, ignore.case = TRUE) ~ "Salmonids",
      grepl("tilapia|Oreochromis", species_scientific, ignore.case = TRUE) ~ "Tilapia",
      grepl("oyster|Crassostrea|mussel|clam", species_scientific, ignore.case = TRUE) ~ "Molluscs",
      grepl("shrimp|prawn|Penaeus|Litopenaeus", species_scientific, ignore.case = TRUE) ~ "Crustaceans",
      grepl("carp|Cyprinus", species_scientific, ignore.case = TRUE) ~ "Cyprinids",
      TRUE ~ "Other"
    ),
    
    # Trait category standardization
    trait_category_std = case_when(
      grepl("growth|weight|length|size", trait_category, ignore.case = TRUE) ~ "Growth",
      grepl("disease|resistance|immune|health", trait_category, ignore.case = TRUE) ~ "Disease Resistance",
      grepl("quality|meat|fillet|color|flesh", trait_category, ignore.case = TRUE) ~ "Quality",
      grepl("reproduction|fecundity|fertility", trait_category, ignore.case = TRUE) ~ "Reproduction",
      TRUE ~ trait_category
    ),
    
    # GS method standardization
    gs_method_std = case_when(
      grepl("GBLUP|BLUP", gs_method, ignore.case = TRUE) ~ "GBLUP",
      grepl("Bayes", gs_method, ignore.case = TRUE) ~ "Bayesian",
      grepl("RKHS|kernel", gs_method, ignore.case = TRUE) ~ "RKHS",
      grepl("machine learning|ML|random forest|neural", gs_method, ignore.case = TRUE) ~ "Machine Learning",
      TRUE ~ gs_method
    ),
    
    # Sample size categories
    sample_size_cat = case_when(
      sample_size_validation < 200 ~ "Small (<200)",
      sample_size_validation < 500 ~ "Medium (200-500)",
      sample_size_validation < 1000 ~ "Large (500-1000)",
      TRUE ~ "Very Large (>1000)"
    ),
    
    # Publication year period
    year_period = case_when(
      year < 2015 ~ "Before 2015",
      year < 2020 ~ "2015-2019",
      TRUE ~ "2020 and later"
    )
  )

cat("Categorical variables created.\n\n")

################################################################################
# 6. HANDLE MISSING DATA
################################################################################

cat("Handling missing data...\n")

# Report missing data patterns
missing_report <- processed_data %>%
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "missing_count") %>%
  filter(missing_count > 0) %>%
  arrange(desc(missing_count))

if (nrow(missing_report) > 0) {
  cat("Variables with missing data:\n")
  print(missing_report)
} else {
  cat("No missing data in critical variables.\n")
}

cat("\n")

################################################################################
# 7. EXPORT PROCESSED DATA
################################################################################

cat("Exporting processed data...\n")

# Create output directory if it doesn't exist
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
}

# Export as RDS (preserves R object structure)
saveRDS(processed_data, "data/processed/prepared_data.rds")
cat("Data exported as RDS: data/processed/prepared_data.rds\n")

# Export as CSV (for external use)
write_csv(processed_data, "data/processed/prepared_data.csv")
cat("Data exported as CSV: data/processed/prepared_data.csv\n\n")

################################################################################
# 8. GENERATE SUMMARY REPORT
################################################################################

cat("Generating summary report...\n")

summary_stats <- processed_data %>%
  summarise(
    n_studies = n(),
    mean_r = mean(prediction_accuracy_r, na.rm = TRUE),
    median_r = median(prediction_accuracy_r, na.rm = TRUE),
    min_r = min(prediction_accuracy_r, na.rm = TRUE),
    max_r = min(prediction_accuracy_r, na.rm = TRUE),
    mean_sample_size = mean(sample_size_validation, na.rm = TRUE),
    total_animals = sum(sample_size_validation, na.rm = TRUE)
  )

cat("\n=== DATA PREPARATION SUMMARY ===\n")
print(summary_stats)

cat("\n=== STUDIES BY SPECIES GROUP ===\n")
species_summary <- processed_data %>%
  count(species_group, sort = TRUE)
print(species_summary)

cat("\n=== STUDIES BY TRAIT CATEGORY ===\n")
trait_summary <- processed_data %>%
  count(trait_category_std, sort = TRUE)
print(trait_summary)

cat("\n=== STUDIES BY GS METHOD ===\n")
method_summary <- processed_data %>%
  count(gs_method_std, sort = TRUE)
print(method_summary)

################################################################################
# 9. SESSION INFO
################################################################################

cat("\n=== SESSION INFORMATION ===\n")
sessionInfo()

cat("\n=== DATA PREPARATION COMPLETE ===\n")
cat("Processed data ready for meta-analysis.\n")
cat("Next step: Run 02-meta-analysis.R\n")
