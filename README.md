# Meta-Analysis of Genomic Selection in Aquaculture: A PRISMA Approach

[![R](https://img.shields.io/badge/R-%E2%89%A54.0.0-blue)](https://www.r-project.org/)
[![PRISMA](https://img.shields.io/badge/PRISMA-2020-green)](http://www.prisma-statement.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive, reproducible workflow for conducting systematic reviews and meta-analyses of genomic selection effectiveness in aquaculture species, following PRISMA 2020 guidelines.

## Overview

This repository provides a complete framework for synthesizing evidence on genomic selection (GS) prediction accuracies across aquaculture species. It includes:

- **Structured templates** for data extraction and quality assessment
- **R scripts** for meta-analysis, subgroup analysis, and publication bias assessment
- **Detailed documentation** of protocol, search strategy, and eligibility criteria
- **Automated visualizations** including forest plots, funnel plots, and PRISMA flow diagrams

**Research Question**: What is the effectiveness of genomic selection for predicting breeding values in aquaculture species, and how does it vary by species, trait, and methodology?

## Table of Contents

- [Features](#features)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Detailed Workflow](#detailed-workflow)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Citation](#citation)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## Features

✨ **Key Features**:

- 📋 **PRISMA 2020 Compliant**: Complete checklist and flow diagram generation
- 📊 **Comprehensive Meta-Analysis**: Fixed-effect, random-effects, subgroup, and meta-regression analyses
- 🔍 **Publication Bias Assessment**: Funnel plots, Egger's test, trim-and-fill analysis
- 📈 **Publication-Ready Figures**: High-resolution forest plots, funnel plots, and visualizations
- 🎯 **Systematic Approach**: Structured templates for data extraction and quality assessment
- 🔄 **Reproducible**: Complete R scripts with detailed comments and session info
- 📖 **Extensive Documentation**: Protocol, search strategy, and inclusion/exclusion criteria
- 🤝 **Collaboration-Friendly**: Designed for team-based systematic reviews

## Repository Structure

```
.
├── README.md                          # This file
├── LICENSE                            # MIT License
├── CITATION.cff                       # Citation information
├── .gitignore                         # Git ignore rules
│
├── data/                              # Data files
│   ├── raw/                          # Original data extraction forms
│   ├── processed/                    # Cleaned, analysis-ready data
│   └── README.md                     # Data organization guide
│
├── templates/                         # Standardized templates
│   ├── data-extraction-form.csv      # Data extraction template with examples
│   ├── study-quality-assessment.csv  # Quality assessment template
│   ├── PRISMA-checklist.md          # PRISMA 2020 checklist
│   └── README.md                     # Template usage guide
│
├── scripts/                           # R analysis scripts
│   ├── 01-data-preparation.R         # Data loading and preprocessing
│   ├── 02-meta-analysis.R            # Main meta-analysis
│   ├── 03-publication-bias.R         # Bias assessment
│   ├── 04-subgroup-analysis.R        # Subgroup and moderator analyses
│   ├── 05-visualization.R            # Publication-ready figures
│   └── README.md                     # Script execution guide
│
├── docs/                              # Protocol and documentation
│   ├── protocol.md                   # Detailed research protocol
│   ├── search-strategy.md            # Database search strategies
│   ├── inclusion-exclusion-criteria.md # Eligibility criteria
│   └── README.md                     # Documentation guide
│
├── results/                           # Analysis outputs
│   ├── figures/                      # All plots and visualizations
│   ├── tables/                       # Summary tables and model objects
│   └── README.md                     # Results interpretation guide
│
└── references/                        # Literature management
    └── README.md                     # Reference organization guide
```

## Installation

### Prerequisites

- **R** version ≥ 4.0.0 ([Download R](https://cloud.r-project.org/))
- **RStudio** (recommended but optional) ([Download RStudio](https://posit.co/download/rstudio-desktop/))
- **Git** for version control ([Download Git](https://git-scm.com/downloads))

### Required R Packages

The scripts will automatically install missing packages, but you can install them manually:

```r
install.packages(c(
  # Meta-analysis
  "metafor",      # Meta-analysis methods
  "meta",         # Additional meta-analysis tools
  
  # Data manipulation
  "dplyr",        # Data transformation
  "tidyr",        # Data tidying
  "readr",        # Fast CSV reading
  "readxl",       # Excel file support
  
  # Visualization
  "ggplot2",      # Advanced plotting
  "forestplot",   # Forest plots
  "gridExtra",    # Multiple plot arrangement
  "DiagrammeR",   # PRISMA flow diagrams
  
  # Reporting
  "knitr",        # Report generation
  "rmarkdown",    # Markdown documents
  "kableExtra"    # Enhanced tables
))
```

### Clone Repository

```bash
git clone https://github.com/madushanj/aquaculture-genomic-selection-meta-analysis.git
cd aquaculture-genomic-selection-meta-analysis
```

## Quick Start

### 6-Step Workflow

1. **Review Documentation** (15-30 minutes)
   ```r
   # Read protocol and search strategy
   # See docs/protocol.md and docs/search-strategy.md
   ```

2. **Conduct Literature Search** (1-2 weeks)
   ```r
   # Follow search strategy in docs/search-strategy.md
   # Use templates in templates/ directory
   ```

3. **Extract Data** (2-4 weeks)
   ```r
   # Complete data-extraction-form.csv
   # Save to data/raw/
   ```

4. **Prepare Data** (5 minutes)
   ```r
   setwd("/path/to/aquaculture-genomic-selection-meta-analysis")
   source("scripts/01-data-preparation.R")
   ```

5. **Run Analyses** (10-15 minutes)
   ```r
   source("scripts/02-meta-analysis.R")
   source("scripts/03-publication-bias.R")
   source("scripts/04-subgroup-analysis.R")
   source("scripts/05-visualization.R")
   ```

6. **Review Results** (1-2 hours)
   ```r
   # Check results/figures/ and results/tables/
   # See results/README.md for interpretation
   ```

## Detailed Workflow

### Phase 1: Planning and Protocol Development

1. **Review and customize protocol**
   - Read `docs/protocol.md`
   - Adapt to specific research questions
   - Register protocol (PROSPERO, OSF)

2. **Finalize eligibility criteria**
   - Review `docs/inclusion-exclusion-criteria.md`
   - Customize for specific needs
   - Train screening team

3. **Prepare data extraction tools**
   - Review `templates/data-extraction-form.csv`
   - Add/remove variables as needed
   - Pilot test on 5 studies

### Phase 2: Literature Search and Screening

1. **Execute database searches**
   - Follow `docs/search-strategy.md`
   - Document search dates and results
   - Export citations to reference manager

2. **Remove duplicates**
   - Use citation manager (Zotero, EndNote)
   - Manual verification of potential duplicates

3. **Screen titles and abstracts**
   - Two independent reviewers
   - Use Covidence or Rayyan (recommended)
   - Resolve conflicts through discussion

4. **Full-text screening**
   - Retrieve full texts
   - Apply eligibility criteria
   - Document exclusion reasons

### Phase 3: Data Extraction and Quality Assessment

1. **Extract data from included studies**
   - Use `templates/data-extraction-form.csv`
   - Two independent extractors (recommended)
   - Cross-check entries

2. **Assess study quality**
   - Use `templates/study-quality-assessment.csv`
   - Apply risk of bias criteria
   - Consensus on ratings

3. **Save completed forms**
   ```bash
   cp data-extraction-form.csv data/raw/data-extraction-form_2025-12-09.csv
   cp study-quality-assessment.csv data/raw/study-quality-assessment_2025-12-09.csv
   ```

### Phase 4: Statistical Analysis

1. **Data preparation**
   ```r
   source("scripts/01-data-preparation.R")
   # Validates data, calculates effect sizes, handles missing data
   ```

2. **Main meta-analysis**
   ```r
   source("scripts/02-meta-analysis.R")
   # Fixed and random-effects models, heterogeneity, sensitivity analyses
   ```

3. **Publication bias assessment**
   ```r
   source("scripts/03-publication-bias.R")
   # Funnel plots, Egger's test, trim-and-fill
   ```

4. **Subgroup analysis**
   ```r
   source("scripts/04-subgroup-analysis.R")
   # Analyses by species, trait, method, platform
   ```

5. **Generate visualizations**
   ```r
   source("scripts/05-visualization.R")
   # Publication-ready figures, PRISMA diagram, summary tables
   ```

### Phase 5: Reporting and Dissemination

1. **Complete PRISMA checklist**
   - Use `templates/PRISMA-checklist.md`
   - Document page numbers in manuscript

2. **Write manuscript**
   - Include all required PRISMA elements
   - Reference figures in `results/figures/`
   - Include tables from `results/tables/`

3. **Prepare supplementary materials**
   - Additional forest plots
   - Sensitivity analyses
   - Complete search strategies
   - Data extraction forms

4. **Share data and code**
   - Archive on Zenodo or OSF
   - Link to GitHub repository
   - Ensure reproducibility

## Usage

### Example: Running Complete Analysis

```r
# Set working directory
setwd("/path/to/aquaculture-genomic-selection-meta-analysis")

# Run complete workflow
source("scripts/01-data-preparation.R")
source("scripts/02-meta-analysis.R")
source("scripts/03-publication-bias.R")
source("scripts/04-subgroup-analysis.R")
source("scripts/05-visualization.R")

# Review results
list.files("results/figures/")
list.files("results/tables/")
```

### Example: Custom Analysis

```r
# Load processed data
data <- readRDS("data/processed/prepared_data.rds")

# Load models
models <- readRDS("results/tables/meta_analysis_models.rds")
re_model <- models$re_model

# Custom forest plot
library(metafor)
pdf("my_forest_plot.pdf", width = 12, height = 10)
forest(re_model, 
       xlab = "Prediction Accuracy (Fisher's z)",
       cex = 0.8,
       col = "darkblue")
dev.off()

# Custom subgroup analysis
library(dplyr)
specific_species <- data %>% 
  filter(species_common == "Atlantic salmon")

salmon_model <- rma(yi = fisher_z, 
                    vi = var_fisher_z, 
                    data = specific_species,
                    method = "REML")
summary(salmon_model)
```

## Documentation

### Key Documents

- **[Protocol](docs/protocol.md)**: Complete research protocol with methods
- **[Search Strategy](docs/search-strategy.md)**: Database search details
- **[Eligibility Criteria](docs/inclusion-exclusion-criteria.md)**: Inclusion/exclusion rules
- **[PRISMA Checklist](templates/PRISMA-checklist.md)**: Reporting checklist

### README Files

Each directory contains a README with specific guidance:
- [data/README.md](data/README.md) - Data organization
- [templates/README.md](templates/README.md) - Template usage
- [scripts/README.md](scripts/README.md) - Script execution
- [docs/README.md](docs/README.md) - Protocol documentation
- [results/README.md](results/README.md) - Results interpretation
- [references/README.md](references/README.md) - Reference management

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

### Areas for Contribution

- Additional subgroup analyses
- Alternative visualization methods
- Extended documentation
- Bug fixes and improvements
- Translation of templates

## Citation

If you use this repository, please cite:

**Text format**:
```
Madhushan, J. (2025). Meta-Analysis of Genomic Selection in Aquaculture: 
A PRISMA Approach (Version 1.0.0) [Computer software]. 
https://github.com/madushanj/aquaculture-genomic-selection-meta-analysis
```

**BibTeX**:
```bibtex
@software{Madhushan2025,
  author = {Madhushan, J.},
  title = {Meta-Analysis of Genomic Selection in Aquaculture: A PRISMA Approach},
  year = {2025},
  version = {1.0.0},
  url = {https://github.com/madushanj/aquaculture-genomic-selection-meta-analysis},
  license = {MIT}
}
```

See [CITATION.cff](CITATION.cff) for more details.

### Key References

**PRISMA Guidelines**:
- Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ. 2021;372:n71. doi:10.1136/bmj.n71

**Meta-Analysis Methods**:
- Viechtbauer W. Conducting meta-analyses in R with the metafor package. Journal of Statistical Software. 2010;36(3):1-48. doi:10.18637/jss.v036.i03
- Borenstein M, Hedges LV, Higgins JPT, Rothstein HR. Introduction to Meta-Analysis. Wiley; 2009.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Summary**: You are free to use, modify, and distribute this software, provided you include the original copyright notice and license text.

## Contact

**Author**: Madhushan, J.

**Repository**: https://github.com/madushanj/aquaculture-genomic-selection-meta-analysis

**Issues**: Please report bugs or request features via [GitHub Issues](https://github.com/madushanj/aquaculture-genomic-selection-meta-analysis/issues)

## Acknowledgments

This workflow was developed following:
- **PRISMA 2020** guidelines for systematic review reporting
- **Cochrane Handbook** for systematic review methods
- **metafor package** documentation and best practices
- Best practices in transparent and reproducible research

Special thanks to the developers of:
- R and RStudio
- metafor package (Wolfgang Viechtbauer)
- tidyverse packages
- DiagrammeR for flow diagrams
- The PRISMA working group

---

**Keywords**: meta-analysis, systematic review, genomic selection, aquaculture, PRISMA, breeding, genetics, R, reproducible research

**Last Updated**: 2025-12-09  
**Version**: 1.0.0  
**Status**: Active Development
