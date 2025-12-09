# Documentation Directory

This directory contains the protocol and methodological documentation for the systematic review and meta-analysis of genomic selection in aquaculture.

## Files

### 1. protocol.md

**Purpose**: Complete research protocol following PRISMA-P guidelines

**Contents**:
- Research objectives and rationale
- Detailed methods for all review stages
- PICO framework
- Information sources and search strategy
- Study selection process
- Data extraction procedures
- Risk of bias assessment approach
- Statistical synthesis methods
- Timeline and milestones

**Use**: 
- Read before starting the review
- Reference during all review stages
- Register with PROSPERO or similar registry
- Cite in manuscripts

**Updates**: Document any protocol amendments with dates and rationale

### 2. search-strategy.md

**Purpose**: Comprehensive search strategy documentation

**Contents**:
- List of databases to search
- Complete search strings for each database
- Boolean operators and search logic
- Date ranges and filters
- Grey literature sources
- Citation tracking approach
- Search update strategy

**Use**:
- Execute database searches
- Ensure reproducibility
- Report in methods section
- Document in PRISMA flow diagram

**Updates**: Record each search execution with date and results

### 3. inclusion-exclusion-criteria.md

**Purpose**: Detailed eligibility criteria for study selection

**Contents**:
- Inclusion criteria (PICO framework)
- Exclusion criteria
- Decision rules for borderline cases
- Examples of included/excluded studies
- Decision tree for rapid assessment
- Quality thresholds

**Use**:
- Guide title/abstract screening
- Guide full-text assessment
- Resolve disagreements between reviewers
- Document rationale for exclusions

**Updates**: Clarifications documented during screening process

## Workflow Integration

### Protocol Development Phase
1. **protocol.md** - Develop and finalize research protocol
2. Register protocol (PROSPERO, OSF, or institutional registry)
3. Have protocol peer-reviewed if possible

### Search Phase
1. **search-strategy.md** - Execute database searches
2. Document search results in search log
3. Export citations to reference manager
4. Remove duplicates

### Screening Phase
1. **inclusion-exclusion-criteria.md** - Apply criteria to titles/abstracts
2. Resolve disagreements using decision rules
3. Retrieve full texts of potentially eligible studies
4. Apply criteria to full-text assessment
5. Document exclusions with reasons

### Data Extraction Phase
1. Use data extraction form (see `templates/`)
2. Refer back to **protocol.md** for variable definitions
3. Contact authors for missing data as per protocol

### Analysis Phase
1. Follow statistical methods outlined in **protocol.md**
2. Conduct all planned analyses
3. Perform sensitivity analyses as specified

### Reporting Phase
1. Follow PRISMA 2020 checklist
2. Report all methods as per **protocol.md**
3. Include search strategy from **search-strategy.md**
4. Report flow diagram with **inclusion-exclusion-criteria.md** applied

## Best Practices

### Version Control
- Use git to track all changes to documentation
- Commit after each significant update
- Use meaningful commit messages

### Transparency
- Document all decisions and deviations
- Keep audit trail of protocol amendments
- Report any changes in final manuscript

### Reproducibility
- Provide enough detail for replication
- Share all search strings and filters
- Document software versions used
- Archive complete search results

### Registration
Before starting data collection:
1. Finalize protocol
2. Register with PROSPERO (https://www.crd.york.ac.uk/prospero/)
   - Or OSF Registries (https://osf.io/)
   - Or institutional registry
3. Obtain registration number
4. Update protocol.md with registration details

### Protocol Amendments

If protocol changes are necessary:
1. Document in amendments section of protocol.md
2. Include:
   - Date of amendment
   - What was changed
   - Rationale for change
   - Impact on completed work
3. Update registry if registered
4. Report transparently in manuscript

## File Organization

### Current Structure
```
docs/
├── protocol.md (17KB) - Main protocol
├── search-strategy.md (13KB) - Search details
├── inclusion-exclusion-criteria.md (15KB) - Eligibility criteria
└── README.md (this file) - Documentation guide
```

### Related Files
- `templates/PRISMA-checklist.md` - Reporting checklist
- `templates/data-extraction-form.csv` - Data collection template
- `templates/study-quality-assessment.csv` - Risk of bias template

## Peer Review

Consider having protocol reviewed by:
1. Methodologist or statistician
2. Content expert in aquaculture genetics
3. Systematic review methodologist
4. Librarian (for search strategy)

## Citation

When citing this protocol:
```
[Authors]. (2025). Meta-Analysis of Genomic Selection in Aquaculture: 
A PRISMA Approach - Protocol. [Registry]. [Registration number].
```

## Resources

### Guidelines and Standards
- **PRISMA 2020**: http://www.prisma-statement.org/
- **PRISMA-P**: http://www.prisma-statement.org/Extensions/Protocols
- **Cochrane Handbook**: https://training.cochrane.org/handbook
- **PROSPERO**: https://www.crd.york.ac.uk/prospero/

### Training Materials
- Cochrane Interactive Learning: https://training.cochrane.org/
- PRISMA training resources: http://www.prisma-statement.org/
- JBI systematic review training: https://jbi.global/

### Tools and Software
- **Covidence**: Screening and data extraction
- **Rayyan**: Free screening tool
- **RevMan**: Cochrane review software
- **R metafor**: Meta-analysis package (see scripts/)

## Contact

For questions about the protocol or documentation:
- [Contact information to be added]

## License

This documentation is released under the MIT License. See main repository LICENSE file.

## Acknowledgments

Protocol development guided by:
- PRISMA 2020 statement
- Cochrane Handbook
- Campbell Collaboration guidelines
- Expertise of the research team

---

**Last Updated**: 2025-12-09  
**Version**: 1.0  
**Status**: Draft / Under Review / Registered
