# Data Directory

This directory contains raw and processed data for the meta-analysis of genomic selection in aquaculture.

## Directory Structure

```
data/
├── raw/              # Original, unmodified data
│   ├── .gitkeep
│   └── (data extraction forms)
├── processed/        # Cleaned and transformed data
│   ├── .gitkeep
│   └── (analysis-ready datasets)
└── README.md         # This file
```

## Data Organization

### raw/

**Purpose**: Store original, unmodified data

**Contents**:
- Completed data extraction forms (CSV format)
- Study quality assessment forms
- Original data files from authors (if provided)
- Search results exports (optional)

**Important**:
- Never modify files in raw/ directory
- Keep original filenames
- Add date stamps to filenames (YYYY-MM-DD)
- Document data provenance

**File Naming Convention**:
```
data-extraction-form_YYYY-MM-DD.csv
study-quality-assessment_YYYY-MM-DD.csv
author-data_FirstAuthorYear.xlsx
search-results_DatabaseName_YYYY-MM-DD.csv
```

**Example**:
```
data-extraction-form_2025-12-09.csv
study-quality-assessment_2025-12-09.csv
additional-data_Smith2020.xlsx
search-results_PubMed_2025-12-09.csv
```

### processed/

**Purpose**: Store cleaned, validated, and analysis-ready data

**Contents**:
- Output from `scripts/01-data-preparation.R`
- Transformed effect sizes
- Categorized variables
- Merged datasets

**Files Generated**:
- `prepared_data.rds` - R data object with all processed data
- `prepared_data.csv` - CSV version for external use
- `data-validation-report.txt` - Summary of validation checks (optional)

**Characteristics**:
- Data types validated
- Missing values handled
- Effect sizes calculated
- Variables standardized
- Ready for meta-analysis

## Data Privacy and Ethics

### Data Sharing

**What can be shared**:
- ✅ Aggregated study-level data (from publications)
- ✅ Summary statistics
- ✅ Meta-analysis results
- ✅ Effect sizes calculated from published data

**What cannot be shared**:
- ❌ Individual-level phenotypic data (unless permission granted)
- ❌ Individual genotypes (unless explicitly permitted)
- ❌ Unpublished data without author permission
- ❌ Proprietary breeding company data

### Confidentiality

- Data from unpublished sources handled per data sharing agreements
- Author-provided data stored securely and separately
- No personally identifiable information stored
- Comply with institutional data management policies

## Data Collection Workflow

### 1. Initial Setup
```bash
# Ensure directories exist
mkdir -p data/raw
mkdir -p data/processed
```

### 2. Data Entry
- Use template from `templates/data-extraction-form.csv`
- Complete one row per study-trait combination
- Double-check all numerical entries
- Two independent extractors (recommended)

### 3. Quality Control
- Cross-check entries between extractors
- Resolve discrepancies
- Verify calculations
- Check for duplicates
- Contact authors for missing data

### 4. Save to raw/
```bash
# Save completed form with date stamp
cp data-extraction-form.csv data/raw/data-extraction-form_2025-12-09.csv
```

### 5. Run Data Preparation Script
```r
# From project root
source("scripts/01-data-preparation.R")
```

### 6. Verify Processed Data
```r
# Check processed data
data <- readRDS("data/processed/prepared_data.rds")
summary(data)
View(data)
```

## Data Validation

### Automated Checks (in 01-data-preparation.R)

- ✅ Required columns present
- ✅ No duplicate study IDs
- ✅ Valid numerical values
- ✅ Correlation coefficients in [-1, 1]
- ✅ Sample sizes > 0
- ✅ Consistent data types

### Manual Checks (Recommended)

- Compare processed data to original publications
- Spot-check effect size calculations
- Verify author names and years
- Check species names against taxonomic databases
- Validate DOIs

## Data Dictionary

### Key Variables

| Variable | Description | Type | Range/Values |
|----------|-------------|------|--------------|
| study_id | Unique study identifier | Character | STUDYnnn |
| author | First author last name et al. | Character | - |
| year | Publication year | Integer | 2009-2025 |
| species_common | Common species name | Character | - |
| species_scientific | Scientific name | Character | Genus species |
| prediction_accuracy_r | Correlation coefficient | Numeric | -1 to 1 |
| sample_size_validation | Validation set size | Integer | > 0 |
| number_of_snps | Number of SNP markers | Integer | ≥ 100 |
| gs_method | Genomic selection method | Character | See codebook |
| trait_category | Type of trait | Character | Growth/Disease/Quality |
| heritability | Trait heritability | Numeric | 0 to 1 |

### Derived Variables (in processed data)

| Variable | Description | Calculation |
|----------|-------------|-------------|
| fisher_z | Fisher's z transformation | 0.5 × ln((1+r)/(1-r)) |
| var_fisher_z | Variance of Fisher's z | 1 / (n - 3) |
| se_fisher_z | Standard error | sqrt(var_fisher_z) |
| species_group | Species category | Based on taxonomy |
| trait_category_std | Standardized trait category | Harmonized categories |
| gs_method_std | Standardized GS method | Harmonized methods |

## File Formats

### CSV Files
- UTF-8 encoding
- Comma-separated
- Header row required
- Quotes around text with commas
- No special characters in column names

### RDS Files
- R native format
- Preserves data types and structure
- Compressed by default
- Use `readRDS()` to load

## Backup and Version Control

### Git Tracking
- `data/raw/.gitkeep` - tracked (ensures directory exists)
- `data/processed/.gitkeep` - tracked
- Actual data files - **NOT tracked** (see .gitignore)

### Why Data Not in Git?
- File size concerns
- Privacy considerations
- Frequent updates during extraction
- Potential sensitive information

### Backup Strategy
1. **Local backups**: Regular copies to external drive
2. **Cloud backup**: Institutional OneDrive/Google Drive
3. **Versioning**: Date stamps in filenames
4. **Archival**: Final dataset archived with manuscript

## Data Updates

### During Data Collection
- Add new studies to `data/raw/data-extraction-form_DATE.csv`
- Re-run `01-data-preparation.R`
- Verify processed data
- Update analysis

### After Analysis
- If new data added, re-run entire workflow
- Document changes in methods
- Compare old vs new results
- Update PRISMA flow diagram

## Troubleshooting

### Issue: "Cannot find data file"
**Solution**: 
- Check file path
- Ensure file in correct directory
- Verify filename matches script
- Check working directory with `getwd()`

### Issue: "CSV reading error"
**Solution**:
- Check file encoding (should be UTF-8)
- Verify CSV format (commas vs semicolons)
- Check for special characters
- Try `read.csv()` vs `read_csv()`

### Issue: "Invalid correlation values"
**Solution**:
- Check for typos in data entry
- Verify values are between -1 and 1
- Check if r² entered instead of r (need square root)
- Review original paper

### Issue: "Missing required columns"
**Solution**:
- Compare CSV headers to template
- Check for extra spaces in column names
- Verify all required columns present
- Match template exactly

## Data Quality Checklist

Before running analyses, verify:

- [ ] All studies from screening entered
- [ ] No duplicate entries
- [ ] All required fields complete
- [ ] Numerical values validated
- [ ] Species names checked
- [ ] Author names and years verified
- [ ] DOIs confirmed
- [ ] Cross-extraction agreement checked
- [ ] Author queries resolved
- [ ] Data backed up
- [ ] Data preparation script runs without errors

## Metadata

For reproducibility, document:
- Data collection dates
- Extractor names/initials
- Software versions used
- Template versions
- Any protocol deviations

## Contact

Questions about data organization or quality:
- [Contact information]

## References

- Data organization guidelines: [To be added]
- FAIR data principles: https://www.go-fair.org/

---

**Last Updated**: 2025-12-09  
**Directory Status**: Ready for data collection  
**Current Version**: 1.0
