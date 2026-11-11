# Data-quality audit and interpretation risks

The source supplied with the project has nine CSVs. Raw inputs are preserved in the nine public-safe CSVs in `data/raw/` after pseudonymisation of names and email fields. The project does not invent missing rows or silently modify business attributes. See `outputs/tables/data_quality_checks.csv` for machine-generated counts.

## High-impact exceptions

1. **Customer dimension is not unique.** Two duplicate `customerid` values have conflicting company names. An unguarded join inflated the screened expansion list from 164 to 165 rows. We avoid joining the raw customer names into the account-grain candidate export.
2. **119 payment status mismatches.** `subscriptions.currentstatus` disagrees with the latest movement when ordered by event timestamp and ID. Choosing `MAX(statusid)` would hide reversals, retries and errors.
3. **Status 0 is present in all 583 subscription payment journeys.** This includes completed journeys, so errors cannot be treated as uniquely responsible for lost conversions or simply summed as failed payments.
4. **Two cancellations pre-date their subscription order dates.** Another two occur after subscription expiration. The source chronology requires review before calculating tenure or churn.
5. **59 inactive subscriptions have no cancellation record.** `59` recorded cancellations cannot serve as the numerator in a business-wide subscription churn rate without a clearly defined at-risk cohort and complete cancellation history.
6. **Different date windows.** 2022–2023 order value and 2024 payment-stage logs cannot be joined to infer contemporaneous incremental revenue at risk. Support events are concentrated among only 59 of 596 users.
7. **Reporting currency and billing frequency are unverified.** The case study uses GBP (£) as a display convention, with no FX conversion. The source does not specify a currency or recurring invoice schedule, so it does not support reliable MRR/NRR/ARR.

## Recommended remediation for a production system

- Establish a unique customer master key and reconcile duplicate customer names against a source-of-truth CRM before dimensional joins.
- Add `payment_attempt_id`, `checkout_session_id`, event correlation IDs and explicit terminal outcome definitions; reconcile final success with provider settlements.
- Capture billing invoice periods, contract start/end, active snapshot date, refunds, currency, taxes and FX before recurring-revenue or profitability reporting.
- Validate cancellation records against subscription lifecycle and harden event timestamp rules, including clock zones and ordering.
- Expand user instrumentation coverage and capture service-ticket resolution outcomes before drawing adoption or support-effectiveness conclusions.

The documented issues are intentionally retained in the provided dataset, with supporting counts in `outputs/tables/data_quality_checks.csv`. Use the SQL data-quality and reconciliation scripts to investigate them in MySQL before relying on the findings for an operational decision.
