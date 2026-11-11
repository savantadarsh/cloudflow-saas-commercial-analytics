# CloudFlow SQL analysis — MySQL 8.0+

The case study is organised around SQL queries for subscription-order value, payment-state reach, expansion screening, cancellation reason mentions and data-quality checks. The CSVs in `data/cleaned/` are **already prepared** for import; no separate data-preparation script is needed.

## Run the queries

1. Open MySQL Workbench and execute [`00_schema_mysql8.sql`](00_schema_mysql8.sql) to create the `cloudflow_portfolio` database and its nine tables.
2. Use **Table Data Import Wizard** to import each CSV from [`data/cleaned/`](../data/cleaned/) into the table with the same name. Choose the first row as column names. These are prepared files: do not import the unstandardised `data/raw/` versions into this schema.
3. Optionally execute [`00b_indexes_mysql8.sql`](00b_indexes_mysql8.sql) once, after importing the data.
4. Run the analytical scripts in order:
   - [`01_order_value_and_product.sql`](01_order_value_and_product.sql): revenue by year, month and product
   - [`02_payment_journey.sql`](02_payment_journey.sql): payment-stage reach and event chronology
   - [`03_expansion_screen.sql`](03_expansion_screen.sql): unique eligible customer accounts
   - [`04_cancellation_mentions.sql`](04_cancellation_mentions.sql): non-exclusive cancellation reasons
   - [`05_data_quality.sql`](05_data_quality.sql): key, status and chronology exceptions
   - [`06_support_instrumentation.sql`](06_support_instrumentation.sql): optional support-event exploration
5. Execute [`07_reconciliation_checks.sql`](07_reconciliation_checks.sql) to compare selected calculated results with the published case-study values.

Results are also available as saved CSV tables in [`outputs/tables/`](../outputs/tables/), with charts in [`outputs/charts/`](../outputs/charts/). These are **published analytical snapshots**, not evidence that the included MySQL queries have run successfully in this environment.

## Analytical definitions and limitations

Payment stages count **distinct subscriptions ever reaching each status**, not unique payment attempts. Recorded `revenue` is the supplied subscription-order value, presented in **GBP (£)** by assumption; it is **not** verified MRR, ARR or payment settlement. The expansion list is an eligibility screen, not a predictive model. Customer dimension keys are not unique, so customer-level segmentation is performed from the subscription table without multiplying rows through an unguarded customer join.

**Execution status:** SQL has been reviewed for MySQL 8 syntax but **not executed against a live MySQL server** for this release. Import behaviour, query outputs and reconciliation checks must be verified locally before presenting them as SQL-tested results.
