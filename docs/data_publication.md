# Data sources and public-use preparation

**Nature of this project:** Independent SaaS analytics portfolio case study built from nine provided CSV files, using a fictional company context. No real-client engagement, realised benefit or audited billing history is claimed.

## Public-release privacy treatment

The downloadable repository contains a **pseudonymised copy** of the provided dataset:

- `data/raw/Customers.csv`: customer business names have been replaced with stable `Organisation NNN` labels. Different source strings get distinct labels, so the duplicate-ID/name-conflict test still detects the source-data anomaly.
- `data/raw/Users.csv`: user names use `User U###` and email addresses use the reserved `example.com` domain. User identifiers, department and customer relationships are unchanged.
- Other source tables retain their supplied analytical values, timestamps and identifiers. All nine tables preserve row counts and business relationships.
- `data/cleaned/` contains prepared, pseudonymised CSV files with standardised column names and ISO-formatted dates for SQL import. The original-shape public-safe files remain in `data/raw/`.

These transformations are not represented as data cleaning discoveries and do not change the reported financial totals, event counts or opportunity screen. The project does not assume that the source was personal data or that replacing strings establishes a dataset licence.

## Gaps and limitations

The underlying data origin, collection method, source currency, recurring billing cadence and redistribution licence are not independently verifiable from the supplied repository. Check redistribution rights before making the repository public. Do not treat customer names, user aliases or pseudonymous email domains as real business contacts.

For numerical definitions, consult [`metric_dictionary.md`](metric_dictionary.md) and [`data_quality_audit.md`](data_quality_audit.md).
