# Meta-Analysis Protocol: Genomic Selection in Aquaculture

## Protocol Registration

**Title**: Effectiveness of Genomic Selection for Improving Production Traits in Aquaculture Species: A Systematic Review and Meta-Analysis

**Registration**: [To be registered with PROSPERO or similar registry]

**Protocol Version**: 1.0  
**Date**: 2025-12-09

**Authors**: [To be completed]

**Corresponding Author**: [Contact information]

---

## Administrative Information

### Amendments

Any amendments to this protocol will be documented with:
- Date of amendment
- Description of changes
- Rationale for changes

### Support

**Funding**: [To be specified]

**Conflicts of Interest**: None declared

### Role of Sponsors

[To be specified]

---

## Background and Rationale

### Context

Genomic selection (GS) has revolutionized animal breeding by enabling the prediction of breeding values using genome-wide markers. In aquaculture, GS offers the potential to accelerate genetic improvement for economically important traits such as growth rate, disease resistance, and product quality. Since the first applications of GS in aquaculture around 2010, numerous studies have reported varying levels of prediction accuracy across different species, traits, and methodologies.

### Rationale for Review

Despite the growing body of literature on genomic selection in aquaculture, several key questions remain:

1. What is the overall effectiveness of GS across aquaculture species?
2. How does prediction accuracy vary among species groups (e.g., salmonids, shellfish, tilapia)?
3. Which traits are most amenable to genomic prediction?
4. What is the impact of methodological factors (GS method, marker density, population size)?
5. How does GS performance in aquaculture compare to terrestrial livestock?

A comprehensive synthesis of the available evidence is needed to:
- Inform breeding program design
- Identify knowledge gaps
- Guide future research priorities
- Provide evidence-based recommendations for industry

### Previous Reviews

[To be completed with search of existing reviews]

---

## Objectives

### Primary Objective

To systematically review and quantitatively synthesize the evidence on the effectiveness of genomic selection for predicting breeding values in aquaculture species.

### Secondary Objectives

1. To estimate the pooled prediction accuracy of genomic selection across aquaculture species
2. To identify sources of heterogeneity in prediction accuracy
3. To compare effectiveness across:
   - Species groups (salmonids, shellfish, crustaceans, etc.)
   - Trait categories (growth, disease resistance, quality traits)
   - GS methodologies (GBLUP, Bayesian methods, machine learning)
   - Study designs and validation approaches
4. To assess publication bias and small-study effects
5. To examine the relationship between prediction accuracy and study characteristics (sample size, marker density, heritability)

---

## Methods

### Eligibility Criteria

#### Study Designs

**Included**:
- Empirical studies reporting genomic selection prediction accuracy
- Prospective and retrospective cohort studies
- Cross-sectional studies with validation
- Studies using real genotypic and phenotypic data

**Excluded**:
- Simulation-only studies (unless validated with real data)
- Review articles and meta-analyses
- Conference abstracts without full text
- Studies without quantitative prediction accuracy measures
- Case reports or single-family studies

#### Participants/Populations

**Included**:
- Any aquatic species farmed for food production
- Commercial breeding populations
- Research populations representative of production environments

**Excluded**:
- Ornamental fish not used for food production
- Wild populations without breeding context
- Model organisms (unless aquaculture relevance)

#### Interventions

**Included**:
- Genomic selection methods including:
  - GBLUP (Genomic Best Linear Unbiased Prediction)
  - Bayesian methods (BayesA, BayesB, BayesC, Bayesian Lasso)
  - Ridge regression BLUP (RRBLUP)
  - Reproducing Kernel Hilbert Spaces (RKHS)
  - Machine learning approaches (Random Forest, SVM, Neural Networks)
  - Ensemble methods

**Excluded**:
- Traditional BLUP without genomic information
- Marker-assisted selection with few markers (<100 SNPs)

#### Outcomes

**Primary Outcome**:
- Prediction accuracy (correlation between genomic estimated breeding values and observed/adjusted phenotypes)

**Acceptable Metrics**:
- Pearson correlation coefficient (r)
- Coefficient of determination (r²)
- Spearman rank correlation
- Accuracy of GEBV (where clearly defined)

**Secondary Outcomes**:
- Genetic gain (percentage improvement)
- Response to selection
- Prediction bias
- Realized accuracy in validation populations

#### Timing

**Included**: Studies from 2009 onwards (first GS applications in aquaculture)

**Language**: English (other languages if translation available)

### PICO Framework

**P (Population)**: Farmed aquaculture species  
**I (Intervention)**: Genomic selection methods  
**C (Comparator)**: Traditional selection or cross-validation baseline  
**O (Outcomes)**: Prediction accuracy of genomic estimated breeding values

---

## Information Sources

### Electronic Databases

The following databases will be searched from 2009 to present:

1. **PubMed/MEDLINE** - biomedical literature
2. **Web of Science Core Collection** - multidisciplinary
3. **Scopus** - largest abstract and citation database
4. **ASFA (Aquatic Sciences and Fisheries Abstracts)** - specialized aquaculture database
5. **CAB Abstracts** - agricultural and veterinary sciences
6. **Google Scholar** - supplementary search for gray literature

### Search Dates

- Initial search: [Date to be specified]
- Search updates: Every 6 months until manuscript submission

### Other Sources

1. **Reference Lists**: Hand-searching of included studies and relevant reviews
2. **Citation Tracking**: Forward citation search using Web of Science and Google Scholar
3. **Grey Literature**:
   - Conference proceedings (ISGA, WAS, EAS, Aquaculture America)
   - Theses and dissertations (ProQuest Dissertations)
   - Industry reports and technical bulletins
4. **Expert Consultation**: Contact with leading researchers in the field
5. **Clinical Trial Registries**: [If applicable]

---

## Search Strategy

### Search Terms

The search strategy combines three concept groups using Boolean operators:

**Concept 1: Genomic Selection**
- "genomic selection" OR "genome-wide prediction" OR "genomic prediction" OR GEBV OR "genomic breeding value*" OR "genomic estimated breeding value*" OR GBLUP OR "genome-wide association" OR GWAS OR "marker-assisted" OR "SNP-based" OR "whole genome" OR "genome-enabled"

**Concept 2: Methods**
- GBLUP OR "Bayesian" OR "ridge regression" OR RRBLUP OR "random forest" OR "machine learning" OR "deep learning" OR "kernel method*" OR RKHS OR "best linear unbiased"

**Concept 3: Aquaculture Species**
- aquaculture OR aquatic OR fish OR salmon OR trout OR tilapia OR carp OR catfish OR shrimp OR prawn OR oyster OR mussel OR clam OR abalone OR seabream OR seabass OR "sea bass" OR "sea bream" OR shellfish OR crustacean OR mollusc OR "finfish"

**Full Search String** (example for PubMed):
```
(("genomic selection"[Title/Abstract] OR "genome-wide prediction"[Title/Abstract] 
OR "genomic prediction"[Title/Abstract] OR GEBV[Title/Abstract] OR 
"genomic breeding value*"[Title/Abstract]) AND (aquaculture[Title/Abstract] OR 
aquatic[Title/Abstract] OR fish[Title/Abstract] OR salmon[Title/Abstract] OR 
tilapia[Title/Abstract] OR shrimp[Title/Abstract] OR oyster[Title/Abstract]) 
AND (prediction[Title/Abstract] OR accuracy[Title/Abstract] OR breeding[Title/Abstract]))
```

### Search Filters

- **Date**: 2009 onwards
- **Language**: English
- **Document Type**: Articles, conference papers, theses

### Database-Specific Strategies

Detailed search strategies for each database will be documented in `search-strategy.md`.

---

## Selection Process

### Screening Stages

#### Stage 1: Title and Abstract Screening
- **Reviewers**: Two independent reviewers
- **Software**: Covidence or Rayyan
- **Criteria**: Apply broad eligibility criteria
- **Conflicts**: Resolved through discussion or third reviewer

#### Stage 2: Full-Text Assessment
- **Reviewers**: Two independent reviewers
- **Assessment**: Detailed eligibility criteria application
- **Documentation**: Reasons for exclusion recorded
- **Conflicts**: Consensus meeting or third reviewer arbitration

### Inter-Rater Reliability

- Calculate Cohen's kappa for title/abstract screening
- Calculate agreement percentage for full-text assessment
- Target: κ > 0.70 or agreement > 85%

### Automation Tools

- **Citation Management**: Zotero or EndNote
- **Deduplication**: Automated with manual verification
- **Screening**: Covidence or Rayyan for collaborative review

---

## Data Collection Process

### Data Extraction

- **Tool**: Standardized data extraction form (see `templates/data-extraction-form.csv`)
- **Pilot Testing**: Form tested on 5 studies and refined
- **Extractors**: Two independent extractors
- **Verification**: Cross-checking of extracted data
- **Conflicts**: Resolved through discussion or third reviewer

### Data Items Collected

#### Study Identification
- Author, year, journal, DOI
- Funding sources

#### Study Characteristics
- Study design and setting
- Country and institution
- Study period

#### Population Characteristics
- Species (common and scientific name)
- Population/strain information
- Sample sizes (reference and validation populations)
- Number of families

#### Genotyping Information
- Genotyping platform and technology
- Number of SNPs/markers
- Call rate and quality control measures
- Imputation methods (if used)

#### Phenotypic Information
- Trait(s) evaluated
- Trait category (growth, disease resistance, quality, etc.)
- Measurement methods and units
- Environmental conditions

#### Genomic Selection Methods
- GS method/algorithm used
- Software/package
- Model parameters
- Prior distributions (for Bayesian methods)

#### Outcomes
- Prediction accuracy (r, r², or equivalent)
- Standard error or confidence intervals
- Heritability estimate
- Genetic gain (if reported)
- Validation method (cross-validation, independent set, forward prediction)

#### Study Quality Indicators
- Sample size adequacy
- Validation approach rigor
- Missing data handling
- Statistical methods appropriateness

### Missing Data

- **Strategy**: Contact corresponding authors for missing data
- **Timeline**: Allow 2 weeks for response, send one reminder
- **Imputation**: Not planned for primary analyses
- **Sensitivity Analysis**: Explore impact of missing data

---

## Study Risk of Bias Assessment

### Risk of Bias Tool

Adapted criteria based on QUADAS-2 and risk of bias in observational studies:

#### Selection Bias
- Random selection of individuals
- Representative populations
- Appropriate sampling frame

#### Performance Bias
- Standardized phenotyping protocols
- Environmental control
- Blinding (where applicable)

#### Detection Bias
- Objective outcome measurement
- Consistent measurement across groups
- Systematic error potential

#### Reporting Bias
- Selective outcome reporting
- Complete reporting of results
- Protocol availability

#### Other Biases
- Sample size adequacy (power analysis)
- Appropriate statistical methods
- Data transparency and availability

### Assessment Process

- **Assessors**: Two independent reviewers
- **Rating Scale**: Low / Moderate / High risk
- **Overall Quality Score**: 0-10 composite score
- **Conflicts**: Resolved through discussion

### Quality Threshold

- No studies excluded based on quality
- Quality scores used in sensitivity analyses
- Potential stratification by risk of bias level

---

## Effect Measures

### Primary Effect Measure

**Correlation coefficient (r)** - correlation between genomic predictions and observed phenotypes

**Transformation**: Fisher's z transformation for meta-analysis
- z = 0.5 × ln[(1 + r)/(1 - r)]
- Variance: 1/(n - 3)

### Alternative Measures

- **r²** (coefficient of determination) - will be converted to r
- **Spearman ρ** - treated similarly to Pearson r
- **Standardized accuracy** - context-specific conversion

### Unit of Analysis

- Study-trait combination (multiple traits from same study = separate effect sizes)
- Account for dependency in sensitivity analyses

---

## Synthesis Methods

### Meta-Analysis Models

#### Fixed-Effect Model
- Assumes single true effect across all studies
- Inverse variance weighting

#### Random-Effects Model (Primary)
- Assumes distribution of true effects
- REML (restricted maximum likelihood) estimation
- DerSimonian-Laird method as sensitivity check

### Heterogeneity Assessment

**Statistics**:
- **I²**: Percentage of variation due to heterogeneity
  - <25%: Low heterogeneity
  - 25-50%: Moderate heterogeneity
  - 50-75%: Substantial heterogeneity
  - >75%: Considerable heterogeneity
- **Q statistic**: Test for heterogeneity
- **τ²**: Between-study variance

### Subgroup Analyses

Pre-specified subgroups:
1. **Species group** (salmonids, tilapia, molluscs, crustaceans, other)
2. **Trait category** (growth, disease resistance, quality, reproduction)
3. **GS method** (GBLUP, Bayesian, RKHS, machine learning)
4. **Genotyping platform** (SNP array, GBS, WGS)
5. **Sample size** (<200, 200-500, 500-1000, >1000)
6. **Marker density** (<10K, 10-50K, >50K SNPs)
7. **Validation method** (cross-validation, independent set, forward prediction)
8. **Publication year** (before 2015, 2015-2019, 2020+)

**Test**: Q-between for subgroup differences

### Meta-Regression

Continuous moderators:
- Sample size (log-transformed)
- Number of SNPs (log-transformed)
- Heritability
- Publication year

**Method**: Mixed-effects meta-regression

### Sensitivity Analyses

1. **Leave-one-out analysis**: Remove each study sequentially
2. **Influence diagnostics**: Identify influential cases
3. **Quality-based**: Exclude low-quality studies
4. **Publication type**: Peer-reviewed only vs. all sources
5. **Effect measure**: Compare r vs. r² vs. Spearman
6. **Model choice**: Compare fixed vs. random effects

### Reporting Bias Assessment

**Methods**:
1. **Funnel plots**: Visual asymmetry assessment
2. **Egger's regression test**: Statistical test for asymmetry
3. **Begg's rank correlation test**: Non-parametric alternative
4. **Trim-and-fill**: Impute missing studies
5. **Fail-safe N**: Number of null studies needed to nullify effect
6. **Contour-enhanced funnel plots**: Distinguish bias from heterogeneity

### Software

- **R version**: ≥ 4.0.0
- **Packages**: metafor, meta, dplyr, ggplot2
- **Scripts**: Available in `scripts/` directory

---

## Certainty Assessment

### GRADE Framework

Assessment of certainty of evidence using GRADE criteria:
1. **Risk of bias**: Study limitations
2. **Inconsistency**: Heterogeneity of results
3. **Indirectness**: Differences in PICO
4. **Imprecision**: Wide confidence intervals
5. **Publication bias**: Assessed through funnel plots and tests

**Ratings**: High / Moderate / Low / Very Low

---

## Timeline

| Phase | Timeline | Milestones |
|-------|----------|-----------|
| Protocol development | Month 1 | Protocol finalization and registration |
| Literature search | Month 2 | Complete database searches |
| Title/abstract screening | Month 2-3 | First round screening |
| Full-text screening | Month 3-4 | Retrieve and assess full texts |
| Data extraction | Month 4-6 | Complete data extraction forms |
| Quality assessment | Month 5-6 | Risk of bias assessment |
| Data analysis | Month 6-7 | Meta-analysis and subgroup analyses |
| Manuscript preparation | Month 7-9 | Write and revise manuscript |
| Submission | Month 9 | Submit for publication |

---

## Data Management

### Data Storage
- All data stored in version-controlled repository
- Regular backups maintained
- Data sharing plan per FAIR principles

### Documentation
- Detailed audit trail of all decisions
- Protocol deviations documented
- Analysis scripts version-controlled

---

## Dissemination

### Publications
- Peer-reviewed journal article (primary output)
- Protocol publication (separate paper)
- Conference presentations

### Data Sharing
- De-identified data repository (GitHub/Zenodo)
- Analysis scripts publicly available
- PRISMA flowchart and checklist included

---

## References

### Key Methodological References

1. Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ. 2021;372:n71.

2. Viechtbauer W. Conducting meta-analyses in R with the metafor package. Journal of Statistical Software. 2010;36(3):1-48.

3. Borenstein M, Hedges LV, Higgins JPT, Rothstein HR. Introduction to Meta-Analysis. Wiley; 2009.

4. Higgins JPT, Thomas J, Chandler J, et al. Cochrane Handbook for Systematic Reviews of Interventions version 6.3. Cochrane; 2022.

### Domain-Specific References

[To be completed with key aquaculture genomic selection papers]

---

## Appendices

### Appendix A: Full Search Strategies
See `search-strategy.md`

### Appendix B: Data Extraction Form
See `templates/data-extraction-form.csv`

### Appendix C: Risk of Bias Tool
See `templates/study-quality-assessment.csv`

### Appendix D: PRISMA Checklist
See `templates/PRISMA-checklist.md`

---

**Protocol Version History**:
- Version 1.0 (2025-12-09): Initial protocol

**Corresponding Author**: [Contact information]

**Protocol Registration**: [To be completed]
