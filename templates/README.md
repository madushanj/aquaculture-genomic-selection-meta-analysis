# Templates Directory

This directory contains standardized templates for conducting a systematic review and meta-analysis following PRISMA guidelines.

## Files

### 1. data-extraction-form.csv

A comprehensive data extraction template for recording information from included studies.

**How to use:**
1. Open the CSV file in a spreadsheet program (Excel, Google Sheets, LibreOffice Calc)
2. Each row represents one study
3. Fill in all relevant columns for each included study
4. Keep consistent naming and formatting across all entries
5. Use the example rows as a guide for data entry
6. Save the completed form in the `data/raw/` directory

**Key fields:**
- **Study identification**: study_id, author, year, journal, doi
- **Species information**: species_common, species_scientific, population_strain
- **Sample characteristics**: sample sizes, number of families
- **Genotyping details**: platform, number of SNPs, GS method
- **Trait information**: trait category and specific trait measured
- **Results**: prediction accuracy (r and r²), confidence intervals, genetic gain, heritability
- **Study design**: design type, validation method, notes

**Tips:**
- Assign unique study IDs (e.g., STUDY001, STUDY002, etc.)
- Record multiple traits from the same study as separate rows
- Include enough detail in the notes column for quality assessment
- Double-check numerical values for accuracy

### 2. study-quality-assessment.csv

A template for assessing the methodological quality and risk of bias in included studies.

**How to use:**
1. Complete one row per study after extracting the data
2. Rate each quality dimension as Low, Moderate, or High
3. Calculate an overall quality score (0-10 scale)
4. Assign an overall risk of bias level
5. Provide comments justifying your assessments

**Quality dimensions assessed:**
- **Selection bias**: Random sampling, representative populations
- **Performance bias**: Standardization of protocols, environmental control
- **Detection bias**: Objective outcome measurement, blinding
- **Reporting bias**: Complete reporting of outcomes
- **Sample size adequacy**: Statistical power considerations
- **Validation method**: Robustness of prediction validation
- **Genotyping quality**: QC procedures, missing data handling
- **Statistical methods**: Appropriateness of analytical approaches
- **Data transparency**: Data and code availability

**Scoring guide:**
- Low risk = Good practices, minimal concerns
- Moderate risk = Some limitations but not critical
- High risk = Major methodological concerns

### 3. PRISMA-checklist.md

The PRISMA 2020 checklist for reporting systematic reviews and meta-analyses.

**How to use:**
1. Review the checklist at the beginning of your project to understand reporting requirements
2. Check off items as you complete them during the review process
3. Record the page number where each item is addressed in your manuscript
4. Add notes for any items requiring clarification
5. Submit the completed checklist with your final manuscript

**Sections covered:**
- Title and Abstract
- Introduction (Rationale and Objectives)
- Methods (Eligibility, Search, Selection, Data Collection, Risk of Bias, Synthesis)
- Results (Study Selection, Characteristics, Syntheses, Reporting Biases)
- Discussion
- Other Information (Registration, Support, Competing Interests)

**Reference:**
Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ 2021;372:n71.

## Workflow Integration

These templates should be used in the following sequence:

1. **Planning phase**: Review PRISMA-checklist.md to understand reporting requirements
2. **Screening phase**: Prepare to use data-extraction-form.csv for included studies
3. **Data extraction phase**: Complete data-extraction-form.csv for all included studies
4. **Quality assessment phase**: Complete study-quality-assessment.csv for all included studies
5. **Analysis phase**: Import completed CSV files using scripts in `scripts/` directory
6. **Reporting phase**: Complete PRISMA-checklist.md before manuscript submission

## Data Management

- Store completed forms in `data/raw/` directory with date stamps
- Keep backup copies of all completed templates
- Document any modifications to the templates in your protocol
- Use version control (git) to track changes to templates over time

## Customization

These templates can be customized for specific research questions:
- Add or remove columns in CSV files as needed
- Adjust quality assessment criteria for your domain
- Document all modifications in your protocol (see `docs/protocol.md`)

## Getting Help

For questions about:
- PRISMA guidelines: Visit http://www.prisma-statement.org/
- Meta-analysis methods: See `docs/protocol.md`
- Data analysis: See `scripts/README.md`
