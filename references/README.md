# References Directory

This directory is for managing references and literature related to the meta-analysis project.

## Purpose

Store and organize:
- PDFs of included studies
- Full-text articles for screening
- Key methodological papers
- Background literature
- Reference lists

## Directory Structure

```
references/
├── included/         # PDFs of studies included in meta-analysis (optional subdirectory)
├── excluded/         # PDFs of excluded full-text studies (optional subdirectory)
├── methods/          # Methodological references (optional subdirectory)
├── background/       # General background literature (optional subdirectory)
└── README.md         # This file
```

## Reference Management

### Recommended Tools

#### Citation Managers
1. **Zotero** (Free, open-source)
   - Best for: Collaboration, browser integration
   - Export: BibTeX, RIS, CSV
   - URL: https://www.zotero.org/

2. **Mendeley** (Free)
   - Best for: PDF annotation, social features
   - Export: BibTeX, RIS, XML
   - URL: https://www.mendeley.com/

3. **EndNote** (Paid)
   - Best for: Large libraries, institutional use
   - Export: BibTeX, RIS, XML
   - URL: https://endnote.com/

4. **JabRef** (Free, open-source)
   - Best for: BibTeX users, LaTeX integration
   - Export: BibTeX
   - URL: https://www.jabref.org/

### Workflow Integration

#### 1. Literature Search
```
Database search → Export citations → Import to reference manager
```

#### 2. Screening
```
Reference manager → Export to screening tool (Covidence/Rayyan) → 
Screen → Import included studies back to reference manager
```

#### 3. Data Extraction
```
Reference manager → Open PDFs → Extract data using template → 
Enter into data-extraction-form.csv
```

#### 4. Manuscript Writing
```
Reference manager → Generate bibliography → 
Export as .bib or RIS → Insert citations
```

## File Organization

### Naming Convention

For PDF files stored locally:

**Format**: `FirstAuthor_Year_ShortTitle.pdf`

**Examples**:
```
Smith_2020_GenomicSelectionSalmon.pdf
Johnson_2021_BayesianMethodsTilapia.pdf
Zhang_2022_SNPdensityOyster.pdf
```

**Benefits**:
- Easy to sort by author or year
- Quickly identifiable
- Compatible across operating systems
- No special characters

### Folder Structure (Optional)

If managing many PDFs locally:

```
references/
├── included/
│   ├── by_species/
│   │   ├── salmonids/
│   │   ├── tilapia/
│   │   ├── shellfish/
│   │   └── crustaceans/
│   └── by_year/
│       ├── 2015-2019/
│       └── 2020-2025/
├── excluded/
│   └── (organized by exclusion reason)
└── methods/
    ├── PRISMA_guidelines/
    ├── meta_analysis_methods/
    └── R_packages/
```

## Reference Data

### Citation Information to Collect

For each study, record:
- ✅ Authors (all or first + et al.)
- ✅ Year
- ✅ Title
- ✅ Journal/Source
- ✅ Volume and issue
- ✅ Page numbers
- ✅ DOI (if available)
- ✅ PMID (if applicable)
- ✅ URL (if open access)
- ✅ Abstract
- ✅ Keywords
- ✅ Accession date

### Metadata Management

**In Citation Manager**:
- Add tags for easy filtering (e.g., "included", "excluded", "screening")
- Use folders/collections to organize
- Add notes with exclusion reasons or key findings
- Rate or star important papers

**Example Zotero Tags**:
```
- included_in_meta
- excluded_no_GS
- excluded_simulation
- key_methodological
- salmon
- tilapia
- disease_resistance
- growth_traits
```

## Integration with Analysis

### BibTeX Export

For R Markdown or LaTeX manuscripts:

```r
# In R Markdown document
bibliography: references.bib
```

Create `references.bib` file:
```bibtex
@article{Smith2020,
  author = {Smith, J. and Jones, A.},
  title = {Genomic Selection in Atlantic Salmon},
  journal = {Aquaculture},
  year = {2020},
  volume = {520},
  pages = {734567},
  doi = {10.1016/j.aquaculture.2020.734567}
}
```

### Reference List in Manuscript

Generate reference list automatically:
```r
# Using knitr/rmarkdown
# Citations inserted as [@Smith2020]
# Bibliography generated automatically at end
```

## Privacy and Copyright

### Copyright Considerations

**What you can do**:
- ✅ Download PDFs for personal research use
- ✅ Store for systematic review purposes
- ✅ Annotate and highlight for analysis
- ✅ Extract data for meta-analysis

**What you should not do**:
- ❌ Share copyrighted PDFs publicly
- ❌ Upload to public repositories without permission
- ❌ Redistribute copyrighted materials
- ❌ Include in version control (git)

**Best Practice**:
- Store PDFs locally only
- Don't commit PDFs to git
- Share DOIs/citations instead of files
- Use institutional access when available

### Data Sharing

When sharing research:
- Share reference lists (citations only)
- Share DOIs and PMIDs
- Link to open access versions when available
- Provide search strategies for replication

## Tracking

### Study Status Tracking

Use citation manager or spreadsheet to track:

| Study | Status | Notes |
|-------|--------|-------|
| Smith 2020 | Included | High quality, salmon |
| Jones 2019 | Excluded | Simulation only |
| Lee 2021 | Screening | Need full text |

### Search Results Log

Document each search:
```
Database: PubMed
Date: 2025-12-09
Hits: 234
Exported: Yes
File: pubmed_export_20251209.ris
Imported to Zotero: Yes
```

## Quality Assurance

### Reference Completeness Check

Before finalizing manuscript:
- [ ] All included studies cited
- [ ] All citations have complete information
- [ ] DOIs verified and active
- [ ] Duplicate entries removed
- [ ] Formatting consistent
- [ ] Author names correct
- [ ] Years correct
- [ ] Journal abbreviations standard

### Cross-Referencing

Verify:
- Citations in text match reference list
- Reference list matches included studies table
- DOIs link correctly
- No broken links
- PMID/PMCID correct if used

## Backup

### Important Notes

⚠️ **PDFs are not backed up in git repository**

**Backup Strategy**:
1. Keep PDFs in institutional/personal cloud storage
2. Regular backups to external drive
3. Export citation library regularly
4. Keep reference manager synced across devices

**What to backup**:
- Citation manager database/library
- Exported .bib or .ris files
- Annotated PDFs (if significant work invested)
- Custom tags and organization
- Notes and comments

## Collaboration

### Sharing References

**With Co-authors**:
- Use shared Zotero library (free)
- Use Mendeley groups
- Export and share .bib file
- Share via cloud storage (citations only)

**With Review Team**:
- Export citations to screening tool
- Share via collaborative platform
- Maintain master reference list
- Document changes and additions

## Key References

### PRISMA Guidelines
- Page MJ, et al. (2021). The PRISMA 2020 statement. BMJ. 372:n71.
- URL: http://www.prisma-statement.org/

### Meta-Analysis Methods
- Borenstein M, et al. (2009). Introduction to Meta-Analysis. Wiley.
- Viechtbauer W. (2010). Conducting meta-analyses in R with the metafor package. J Stat Software. 36(3):1-48.

### Cochrane Handbook
- Higgins JPT, et al. (2022). Cochrane Handbook for Systematic Reviews of Interventions version 6.3.
- URL: https://training.cochrane.org/handbook

### R Packages Documentation
- metafor: https://wviechtb.github.io/metafor/
- meta: https://cran.r-project.org/package=meta

## Resources

### Open Access Repositories
- PubMed Central: https://www.ncbi.nlm.nih.gov/pmc/
- bioRxiv (preprints): https://www.biorxiv.org/
- arXiv (quantitative bio): https://arxiv.org/archive/q-bio

### Finding Full Text
- Unpaywall browser extension
- Google Scholar
- Research Gate (contact authors)
- Email authors directly
- Institutional library services
- Inter-library loan

## Data Not Tracked in Git

This directory is listed in `.gitignore` for:
- PDF files (copyright)
- Large file sizes
- Privacy considerations
- Repository size management

Only this README is tracked.

## Citation Format

### In Manuscript

Follow journal requirements. Common formats:

**APA Style**:
```
Smith, J., & Jones, A. (2020). Genomic selection in Atlantic salmon. 
Aquaculture, 520, 734567. https://doi.org/10.1016/j.aquaculture.2020.734567
```

**Vancouver Style**:
```
Smith J, Jones A. Genomic selection in Atlantic salmon. 
Aquaculture. 2020;520:734567.
```

**Nature Style**:
```
Smith, J. & Jones, A. Genomic selection in Atlantic salmon. 
Aquaculture 520, 734567 (2020).
```

## Contact

Questions about reference management:
- [Contact information]

---

**Last Updated**: 2025-12-09  
**Status**: Ready for literature collection  
**Recommended**: Set up Zotero or Mendeley before starting searches
