# Repository map and SQL reproduction

```text
cloudflow-saas-commercial-analytics/
├── README.md                   Executive commercial analytics case study
├── data/raw/                   Source-format CSV datasets with published aliases
├── data/cleaned/               Prepared CSVs for MySQL import
├── sql/                        MySQL 8 schema, analysis, and reconciliation checks
├── outputs/charts/             Seven stakeholder-facing analytical figures
├── outputs/tables/             Result tables and data-quality exports
├── docs/                       Metrics, methodology, assumptions, and executive PDF
└── .github/workflows/          Repository structure checks
```

## Reproducing the analysis

Open [`sql/README.md`](../sql/README.md), create the tables, import the prepared CSVs, and run the SQL scripts in order. The `07_reconciliation_checks.sql` script compares selected calculated results with the values presented in the case study.

The CSV results and charts are precomputed analytical exports. The supplied SQL has not been executed and reconciled against a live MySQL instance in this release.

**Scope:** This is an independent portfolio case study using fictional company context. Payment recovery, customer expansion uplift, and realised ROI remain hypotheses pending settlement reconciliation and controlled evaluation.
