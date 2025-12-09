# Inclusion and Exclusion Criteria

## Overview

This document provides detailed inclusion and exclusion criteria for study selection in the systematic review and meta-analysis of genomic selection in aquaculture. These criteria follow the PICO framework (Population, Intervention, Comparator, Outcome) and align with our research objectives.

---

## Inclusion Criteria

### 1. Study Design

**Included Study Types**:
- ✅ Empirical studies with real genotypic and phenotypic data
- ✅ Prospective cohort studies
- ✅ Retrospective analysis of existing breeding data
- ✅ Cross-sectional studies with validation
- ✅ Longitudinal studies tracking prediction accuracy over time
- ✅ Studies comparing multiple GS methods
- ✅ Pilot studies and proof-of-concept studies (if quantitative data provided)

**Required Elements**:
- Must report quantitative prediction accuracy or correlation
- Must use real genotypic data (SNPs or other markers)
- Must use real phenotypic data (not simulated)
- Must include validation component (cross-validation, independent set, or forward prediction)

### 2. Population/Participants

**Eligible Species**:
- ✅ Any aquatic species farmed for food production
- ✅ Finfish (teleosts and elasmobranchs)
- ✅ Crustaceans (shrimp, prawn, crayfish, lobster)
- ✅ Molluscs (oysters, mussels, clams, scallops, abalone)
- ✅ Other aquaculture species (sea cucumber, sea urchin)

**Eligible Populations**:
- ✅ Commercial breeding populations
- ✅ Nucleus breeding populations
- ✅ Research populations representative of production environments
- ✅ Pedigreed populations with known family structure
- ✅ Mixed-family populations
- ✅ Both domesticated and recently domesticated populations

**Sample Size Requirements**:
- ✅ Minimum of 50 individuals with genotypes and phenotypes
- ✅ At least 2 families (for family-based designs)
- ✅ Validation set with minimum 20 individuals

### 3. Intervention (Genomic Selection Method)

**Eligible GS Methods**:
- ✅ GBLUP (Genomic Best Linear Unbiased Prediction)
- ✅ RRBLUP (Ridge Regression BLUP)
- ✅ Bayesian methods:
  - BayesA, BayesB, BayesC, BayesCπ
  - Bayesian Lasso
  - Bayesian Ridge Regression
- ✅ RKHS (Reproducing Kernel Hilbert Spaces)
- ✅ Machine learning methods:
  - Random Forest
  - Support Vector Machines (SVM)
  - Neural Networks
  - Deep Learning
  - Gradient Boosting
- ✅ Ensemble methods combining multiple approaches
- ✅ ssGBLUP (single-step GBLUP)
- ✅ Hybrid methods combining genomic and pedigree information

**Marker Requirements**:
- ✅ SNP arrays (any density)
- ✅ Genotyping-by-Sequencing (GBS)
- ✅ RAD-seq or ddRAD-seq
- ✅ Whole Genome Sequencing (WGS)
- ✅ Low-pass sequencing with imputation
- ✅ Targeted sequencing panels
- ✅ Minimum 100 SNPs (to distinguish from traditional marker-assisted selection)

### 4. Comparator

**Not Strictly Required** (single-arm studies acceptable), but if present:
- ✅ Traditional BLUP (without genomic information)
- ✅ Phenotypic selection
- ✅ Alternative GS methods
- ✅ Different marker densities
- ✅ Cross-validation as baseline

### 5. Outcomes

**Primary Outcome** - At least one of:
- ✅ Prediction accuracy reported as correlation (r)
- ✅ Coefficient of determination (r²)
- ✅ Spearman rank correlation
- ✅ Accuracy of GEBV (genomic estimated breeding values)
- ✅ Correlation between GEBV and adjusted phenotypes
- ✅ Correlation between GEBV and true breeding values (if known)

**Acceptable Reporting**:
- ✅ Point estimate with or without variance measures
- ✅ Confidence intervals or standard errors
- ✅ Multiple accuracies for different traits (each treated separately)
- ✅ Accuracy by validation set or cross-validation fold

**Secondary Outcomes** (nice to have):
- ✅ Genetic gain or response to selection
- ✅ Realized accuracy in subsequent generations
- ✅ Prediction bias
- ✅ Mean squared error of prediction (MSEP)

### 6. Publication Characteristics

**Language**:
- ✅ English language publications (primary)
- ✅ Other languages if translation available and resources permit

**Publication Type**:
- ✅ Peer-reviewed journal articles
- ✅ Conference proceedings with full papers
- ✅ Master's theses
- ✅ Doctoral dissertations
- ✅ Technical reports from recognized institutions
- ✅ Preprints (bioRxiv, etc.) if sufficient detail provided

**Time Period**:
- ✅ Published from 2009 onwards (first GS applications in aquaculture)
- ✅ No upper date limit (search to present)

**Publication Status**:
- ✅ Published studies
- ✅ In-press articles
- ✅ Preprints
- ✅ Unpublished data from researchers (if meeting quality standards)

---

## Exclusion Criteria

### 1. Study Design

**Excluded Study Types**:
- ❌ Simulation-only studies (no real data)
- ❌ Purely theoretical or mathematical papers
- ❌ Review articles (systematic reviews, meta-analyses, narrative reviews)
- ❌ Opinion pieces, editorials, commentaries
- ❌ Conference abstracts without full text
- ❌ Poster abstracts
- ❌ Letters to the editor (unless containing original data)
- ❌ Studies lacking validation of predictions

**Design Limitations**:
- ❌ No validation component (training only)
- ❌ Prediction accuracy not reported or calculable
- ❌ Insufficient detail to extract effect sizes
- ❌ Studies reporting only training set accuracy

### 2. Population/Participants

**Excluded Species**:
- ❌ Ornamental fish not used for food production (guppies, goldfish, zebrafish as model)
- ❌ Terrestrial livestock (cattle, pigs, chickens, sheep)
- ❌ Non-aquatic species
- ❌ Model organisms used solely for methods development (unless aquaculture relevance)
- ❌ Wild populations not in breeding context

**Population Limitations**:
- ❌ Sample size < 50 total individuals
- ❌ Validation set < 20 individuals
- ❌ Single individual or family case studies
- ❌ In vitro or cell line studies
- ❌ Purely wild populations without breeding application

### 3. Intervention

**Excluded Methods**:
- ❌ Traditional pedigree BLUP without genomic information
- ❌ Marker-assisted selection with < 100 markers
- ❌ Single-marker or few-marker association studies
- ❌ Parentage assignment or traceability studies (unless GS component)
- ❌ QTL mapping without genomic prediction
- ❌ GWAS without predictive validation
- ❌ Transcriptomic or proteomic prediction (unless DNA-based component)

**Marker Limitations**:
- ❌ Microsatellites or other non-SNP markers only
- ❌ < 100 genetic markers used
- ❌ Candidate gene approach with targeted markers only
- ❌ Markers not genome-wide distributed

### 4. Outcomes

**Excluded if**:
- ❌ No prediction accuracy reported
- ❌ Only heritability estimates (without prediction)
- ❌ Only genetic parameter estimates
- ❌ Only allele frequency data
- ❌ Only marker-trait associations
- ❌ Only variance component estimates
- ❌ Breeding values reported but no validation accuracy
- ❌ Insufficient data to calculate or estimate correlation

**Unacceptable Reporting**:
- ❌ Qualitative descriptions only ("good", "poor" accuracy)
- ❌ Graphical results without numerical values and no response from authors
- ❌ Results impossible to extract or convert to correlation

### 5. Publication Characteristics

**Language**:
- ❌ Non-English publications without translation (if resources constrained)

**Publication Type**:
- ❌ Abstracts only (no full text available)
- ❌ Duplicates of the same study
- ❌ Retracted articles
- ❌ Secondary publications of same data (keep primary only)

**Availability**:
- ❌ Full text not accessible after reasonable efforts
- ❌ Proprietary/confidential data not shareable

### 6. Data Quality

**Excluded for**:
- ❌ Obvious errors in reported data (after author contact)
- ❌ Internally inconsistent results
- ❌ Suspicion of data fabrication or fraud
- ❌ Inability to verify study authenticity
- ❌ Major methodological flaws making results unreliable

---

## Special Cases and Decision Rules

### Borderline Cases

#### Case 1: Simulation with Empirical Parameters
**Question**: Study uses simulated data but parameters derived from real aquaculture populations?

**Decision**: 
- **Exclude** if purely simulated data
- **Include** if simulated data used only to supplement real data and real data results reported separately
- **Include** if simulation validated against real data subset

#### Case 2: Multiple Publications from Same Dataset
**Question**: Two papers report different aspects of same dataset?

**Decision**:
- **Include** both if reporting different traits (treat as separate effect sizes)
- **Include** both if different validation methods or time points
- **Include** only one if exact same analysis reported (choose most complete)
- Document relationship between studies in extraction

#### Case 3: Hybrid Genomic-Pedigree Methods
**Question**: Study uses single-step GBLUP combining pedigree and genomic info?

**Decision**:
- **Include** if can extract genomic contribution to accuracy
- **Include** if compared to pedigree-only and difference reported
- **Exclude** if cannot separate genomic vs pedigree contribution

#### Case 4: Aquaculture Species Not Primarily for Food
**Question**: Species has ornamental value but also eaten (e.g., some carp varieties)?

**Decision**:
- **Include** if study context is food production
- **Include** if dual-purpose breeding program
- **Exclude** if purely ornamental breeding context

#### Case 5: Very Small Sample Sizes
**Question**: Study has < 50 individuals but high-quality data and methods?

**Decision**:
- **Include** pilot studies with 30-50 individuals (sensitivity analysis)
- **Exclude** if < 30 individuals
- Flag small studies for quality assessment and subgroup analysis

#### Case 6: Multiple Validation Methods Reported
**Question**: Study reports both cross-validation and independent validation?

**Decision**:
- **Include** independent validation as primary (if available)
- **Include** cross-validation as secondary
- Use most rigorous validation method available
- May extract multiple effect sizes for sensitivity analysis

#### Case 7: Machine Learning Without Traditional Benchmarks
**Question**: Study uses only ML methods without comparing to GBLUP?

**Decision**:
- **Include** as valid GS method
- Note absence of benchmark in quality assessment
- Extract best-performing method's accuracy

#### Case 8: Pre-selected SNPs or Candidate Gene Panels
**Question**: Study uses targeted SNP panel (1000-5000 SNPs) from previous GWAS?

**Decision**:
- **Include** if > 100 SNPs and genome-wide representation
- **Exclude** if few candidate genes only
- Document in subgroup analysis as "targeted" vs "genome-wide"

#### Case 9: Multiple Traits in Single Study
**Question**: One study reports accuracy for 10 different traits?

**Decision**:
- **Include** all traits as separate effect sizes
- Account for dependency in statistical analysis
- Use multilevel/hierarchical models if appropriate
- Sensitivity analysis excluding multiple traits per study

#### Case 10: Gray Literature with Limited Peer Review
**Question**: Conference paper or thesis with no peer review?

**Decision**:
- **Include** if sufficient methodological detail
- **Include** if from recognized academic institution
- Flag for quality assessment
- Conduct sensitivity analysis excluding gray literature

---

## Decision Tree

```
Start: Is the study about aquaculture species?
  ├─ No → EXCLUDE
  └─ Yes → Does it use genomic data (>100 SNPs)?
      ├─ No → EXCLUDE
      └─ Yes → Does it report prediction accuracy?
          ├─ No → EXCLUDE
          └─ Yes → Does it use real (not simulated) data?
              ├─ No → EXCLUDE
              └─ Yes → Does it include validation?
                  ├─ No → EXCLUDE
                  └─ Yes → Is sample size adequate (n≥50)?
                      ├─ No → EXCLUDE (or include with flag)
                      └─ Yes → INCLUDE ✓
```

---

## Examples

### Example 1: Clearly Included Study

**Citation**: Smith et al. (2020). Genomic selection for growth in Atlantic salmon using 50K SNP array.

**Assessment**:
- ✅ Aquaculture species (Atlantic salmon)
- ✅ Real genotypic data (50K SNP array)
- ✅ Real phenotypic data (body weight)
- ✅ Prediction accuracy reported (r = 0.65)
- ✅ Validation with independent set
- ✅ Sample size adequate (n = 1500)
- ✅ Peer-reviewed journal

**Decision**: **INCLUDE**

### Example 2: Clearly Excluded Study

**Citation**: Johnson et al. (2019). Simulation study of optimal SNP density for aquaculture breeding.

**Assessment**:
- ❌ Simulation only, no real data
- ❌ Multiple hypothetical species

**Decision**: **EXCLUDE** (simulation only)

### Example 3: Borderline - Small Sample

**Citation**: Lee et al. (2021). Pilot genomic selection in endangered sturgeon (n = 45).

**Assessment**:
- ✅ Aquaculture species
- ✅ Real data
- ⚠️ Small sample (n = 45, below threshold but close)
- ✅ Prediction accuracy reported
- ✅ Cross-validation used

**Decision**: **INCLUDE with flag** for sensitivity analysis
**Justification**: Endangered species, limited availability, pilot study, still provides information

### Example 4: Borderline - Methods

**Citation**: Zhang et al. (2020). Genomic prediction using 500 pre-selected SNPs in tilapia.

**Assessment**:
- ✅ Aquaculture species
- ⚠️ Pre-selected SNPs (500, above threshold)
- ✅ Real data and validation
- ✅ Prediction accuracy reported

**Decision**: **INCLUDE**
**Justification**: Meets marker number threshold, represents cost-effective approach
**Note**: Flag as "targeted" vs "genome-wide" panel for subgroup analysis

### Example 5: Borderline - Duplicate Data

**Citation 1**: Chen et al. (2018). Genomic selection for disease resistance in shrimp.
**Citation 2**: Chen et al. (2019). Comparison of GS methods for disease traits in shrimp.

**Assessment**:
- Same research group
- Same breeding population
- Citation 2 mentions "using data from Chen et al. 2018"
- Citation 2 includes additional analysis methods

**Decision**: **INCLUDE both**
**Justification**: 
- If different traits → include separately
- If same trait but different methods → include most recent/comprehensive
- Document relationship between studies

---

## Quality Thresholds

While we don't exclude based solely on quality, studies will be assessed for:

### Critical Quality Indicators
1. Sample size adequacy
2. Validation method rigor
3. Genotyping quality control
4. Phenotyping standardization
5. Statistical methods appropriateness
6. Transparency and reporting quality

### Risk of Bias
Studies with high risk of bias will be:
- Included in main analysis
- Flagged in quality assessment
- Examined in sensitivity analyses
- Potentially downweighted in meta-analysis

---

## Handling Disagreements

### Between Reviewers

**Process**:
1. Initial independent screening by two reviewers
2. Comparison of decisions
3. Discussion of disagreements
4. Consensus meeting
5. Third reviewer for unresolved conflicts

**Documentation**:
- Record all disagreements
- Document rationale for final decisions
- Calculate inter-rater reliability (Cohen's kappa)

---

## Updates and Amendments

Any changes to inclusion/exclusion criteria will be:
- Documented with date and rationale
- Applied consistently to all studies
- Requiring re-screening of affected studies
- Reported in final manuscript

---

## References

For guidance on criteria development:
1. PRISMA 2020 guidelines
2. Cochrane Handbook for Systematic Reviews
3. PICO framework literature

---

**Version**: 1.0  
**Date**: 2025-12-09  
**Last Review**: 2025-12-09  
**Next Review**: Before screening begins
