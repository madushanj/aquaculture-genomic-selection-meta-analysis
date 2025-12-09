# Scripts Directory

This directory contains R scripts for conducting a comprehensive meta-analysis of genomic selection studies in aquaculture following PRISMA guidelines.

## Execution Order

The scripts should be run in numerical order:

1. `01-data-preparation.R` - Data loading, validation, and preprocessing
2. `02-meta-analysis.R` - Main meta-analysis (fixed and random effects)
3. `03-publication-bias.R` - Publication bias assessment
4. `04-subgroup-analysis.R` - Subgroup and moderator analyses
5. `05-visualization.R` - Publication-ready figures and tables

## Script Dependencies

### System Requirements
- R version >= 4.0.0
- Minimum 4GB RAM recommended
- Graphics device for plotting (PDF, PNG)

### Required R Packages

All scripts will automatically install missing packages, but you can install them manually:

```r
install.packages(c(
  "metafor",      # Meta-analysis methods
  "meta",         # Additional meta-analysis tools
  "dplyr",        # Data manipulation
  "tidyr",        # Data tidying
  "ggplot2",      # Advanced visualization
  "readr",        # Fast CSV reading
  "readxl",       # Excel file support
  "forestplot",   # Forest plots
  "gridExtra",    # Multiple plot arrangement
  "knitr",        # Report generation
  "rmarkdown",    # Markdown documents
  "kableExtra",   # Enhanced tables
  "DiagrammeR"    # PRISMA flow diagrams
))
```

## Script Descriptions

### 01-data-preparation.R

**Purpose**: Prepare raw data for meta-analysis

**Input**: 
- `data/raw/data-extraction-form.csv` (or template if not available)

**Output**:
- `data/processed/prepared_data.rds` - R data object
- `data/processed/prepared_data.csv` - CSV format

**Key Functions**:
- Data validation and quality checks
- Fisher's z transformation for correlations
- Effect size calculation
- Categorical variable creation for subgroup analysis
- Missing data handling

**Runtime**: < 1 minute for typical datasets (n < 100 studies)

### 02-meta-analysis.R

**Purpose**: Conduct main meta-analysis

**Input**:
- `data/processed/prepared_data.rds`

**Output**:
- `results/tables/meta_analysis_models.rds` - Model objects
- `results/tables/meta_analysis_summary.csv` - Summary table
- `results/figures/forest_plot_main.pdf` - Main forest plot
- `results/figures/influence_diagnostics.pdf` - Diagnostic plots

**Key Analyses**:
- Fixed-effect meta-analysis
- Random-effects meta-analysis (REML)
- Heterogeneity assessment (I², Q, tau²)
- Leave-one-out sensitivity analysis
- Influence diagnostics
- Meta-regression with moderators

**Runtime**: 1-5 minutes depending on dataset size

### 03-publication-bias.R

**Purpose**: Assess publication bias and small-study effects

**Input**:
- `data/processed/prepared_data.rds`
- `results/tables/meta_analysis_models.rds`

**Output**:
- `results/figures/funnel_plot_*.pdf` - Various funnel plots
- `results/figures/radial_plot.pdf` - Galbraith plot
- `results/tables/publication_bias_tests.csv` - Test results

**Key Analyses**:
- Standard and contour-enhanced funnel plots
- Egger's regression test
- Begg's rank correlation test
- Trim-and-fill analysis
- Fail-safe N calculation

**Runtime**: < 2 minutes

### 04-subgroup-analysis.R

**Purpose**: Explore heterogeneity through subgroup analyses

**Input**:
- `data/processed/prepared_data.rds`

**Output**:
- `results/tables/subgroup_analysis_models.rds` - Subgroup models
- `results/tables/subgroup_*.csv` - Subgroup summaries
- `results/figures/forest_plot_*.pdf` - Subgroup forest plots

**Key Analyses**:
- Subgroup analysis by species group
- Subgroup analysis by trait category
- Subgroup analysis by GS method
- Subgroup analysis by genotyping platform
- Tests for subgroup differences (Q-between)

**Runtime**: 2-5 minutes depending on number of subgroups

### 05-visualization.R

**Purpose**: Create publication-ready figures and tables

**Input**:
- `data/processed/prepared_data.rds`
- `results/tables/meta_analysis_models.rds`

**Output**:
- Multiple publication-ready figures (PNG and PDF)
- PRISMA flow diagram
- Summary tables

**Key Outputs**:
- Enhanced forest plots
- Cumulative forest plots
- Meta-regression scatter plots
- PRISMA flow diagram
- Study characteristics tables
- Summary statistics tables

**Runtime**: 2-5 minutes (PRISMA diagram may take longer)

## Usage Instructions

### Basic Workflow

1. **Prepare your data**:
   - Complete the `data-extraction-form.csv` template
   - Save it in `data/raw/` directory
   - Ensure all required columns are filled

2. **Run the scripts sequentially**:
   ```r
   # Set working directory to project root
   setwd("/path/to/aquaculture-genomic-selection-meta-analysis")
   
   # Run scripts in order
   source("scripts/01-data-preparation.R")
   source("scripts/02-meta-analysis.R")
   source("scripts/03-publication-bias.R")
   source("scripts/04-subgroup-analysis.R")
   source("scripts/05-visualization.R")
   ```

3. **Review outputs**:
   - Check console output for warnings and errors
   - Review figures in `results/figures/`
   - Review tables in `results/tables/`

### Advanced Usage

**Running specific analyses**:

```r
# Run only data preparation and main analysis
source("scripts/01-data-preparation.R")
source("scripts/02-meta-analysis.R")

# Load models for custom analysis
models <- readRDS("results/tables/meta_analysis_models.rds")
re_model <- models$re_model

# Custom forest plot
pdf("my_custom_plot.pdf", width = 12, height = 10)
forest(re_model, cex = 0.9)
dev.off()
```

**Modifying parameters**:

Each script has clearly commented sections. You can modify:
- Random seed (for reproducibility)
- Plot dimensions and formats
- Statistical thresholds
- Subgroup definitions

### Customization

**Adding new moderators**:

Edit `01-data-preparation.R` to create new categorical variables:
```r
processed_data <- processed_data %>%
  mutate(
    new_moderator = case_when(
      condition1 ~ "Group1",
      condition2 ~ "Group2",
      TRUE ~ "Other"
    )
  )
```

Then add corresponding analysis in `04-subgroup-analysis.R`.

**Changing effect measure**:

If using a different effect measure (e.g., standardized mean difference):
1. Modify effect size calculation in `01-data-preparation.R`
2. Update transformation functions in subsequent scripts
3. Adjust plot labels accordingly

## Troubleshooting

### Common Issues

**Error: "Data file not found"**
- Solution: Ensure data-extraction-form.csv is in data/raw/ directory
- Alternative: Script will use template file automatically

**Error: "Package not found"**
- Solution: Scripts auto-install packages, but ensure you have internet connection
- Manual installation: `install.packages("package_name")`

**Warning: "Insufficient studies for subgroup analysis"**
- Solution: Normal when subgroups have < 2 studies
- Script will skip that subgroup and continue

**Error: "Cannot calculate Fisher's z"**
- Solution: Check for correlations equal to ±1 or invalid values
- Review data in `data/processed/prepared_data.csv`

**Plots not displaying**
- Solution: Plots are saved to files, not displayed interactively
- Check `results/figures/` directory

### Getting Help

1. **Check console output**: Scripts provide detailed logging
2. **Review session info**: Each script prints sessionInfo() at the end
3. **Check intermediate files**: Review `data/processed/` outputs
4. **Consult documentation**: See `docs/` directory for methodology

## Quality Control

Before finalizing your analysis:

1. **Verify data entry**: Check `data/processed/prepared_data.csv` for errors
2. **Review diagnostics**: Check influence plots and outlier detection
3. **Assess heterogeneity**: Consider sources of I² > 50%
4. **Check publication bias**: Review funnel plots and test results
5. **Validate subgroups**: Ensure adequate sample sizes per group
6. **Review all figures**: Check for clarity and accuracy

## Output Files Summary

### Tables (`results/tables/`)
- `meta_analysis_summary.csv` - Main meta-analysis results
- `publication_bias_tests.csv` - Bias assessment results
- `subgroup_*.csv` - Subgroup analysis results
- `study_characteristics.csv` - Study details
- `summary_by_*.csv` - Descriptive summaries

### Figures (`results/figures/`)
- `forest_plot_*.pdf/png` - Forest plots (various types)
- `funnel_plot_*.pdf` - Funnel plots
- `influence_diagnostics.pdf` - Diagnostic plots
- `PRISMA_flow_diagram.png/pdf` - Study flow
- `metaregression_*.png/pdf` - Scatter plots

### R Objects
- `*.rds` files contain R model objects for further analysis

## Best Practices

1. **Version control**: Commit after each successful script run
2. **Documentation**: Keep notes on decisions and modifications
3. **Reproducibility**: Use consistent random seeds, document package versions
4. **Validation**: Review outputs after each script before proceeding
5. **Backup**: Keep copies of original data files

## Citation

If you use these scripts, please cite:
- The metafor package: Viechtbauer (2010). Conducting meta-analyses in R with the metafor package. Journal of Statistical Software, 36(3), 1-48.
- This repository: See CITATION.cff

## License

These scripts are released under the MIT License. See LICENSE file for details.
