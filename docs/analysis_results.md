# CloudFlow — findings and supporting evidence

The figures below are supported by the published CSV result tables and the MySQL 8 queries in `sql/`. The SQL scripts are provided for independent verification and have not been run against a live MySQL instance in this release. Monetary figures use GBP (£) as a presentation assumption. The supplied records do not identify their currency and no FX conversion has been performed.

## Finding 1 — Growth was concentrated in the Pro tier

- Recorded subscription-order value: **£4,152,600 (2022)** vs **£4,597,700 (2023)**, a **10.72%** increase.
- Product changes: Pro **+£285,400**, Basic **+£89,700**, Premium **+£70,000**. Pro supplied **64.12%** of the observed net increase of £445,100.
- **Business implication:** Pro is the largest recorded *growth contributor* in the available records, not necessarily the most profitable tier. Evaluate margin, acquisition cohort and subscription term before reallocating spend.
- Evidence: `outputs/tables/yearly_revenue.csv`, `product_yoy.csv`; charts 01–02.

## Finding 2 — Final completion is materially lower than intermediate payment success

- The 2024 payment log shows **403** distinct subscription IDs reaching Widget Opened, **316** Payment Entered, **238** Submitted, **150** Payment Success and **78** Complete.
- **19.35%** of widget-opened subscriptions ever reached Complete; **52.0%** of the 150 subscriptions reaching Payment Success also reached Complete.
- Median first-to-last event span among the 78 completers was **28 minutes** (p90 **40.3 minutes**).
- **Business implication:** Audit what Payment Success versus Complete means before assuming the gap reflects actual unpaid orders. A substantial instrumentation/reconciliation question is visible; a confirmed recovery amount is not.
- Evidence: `outputs/tables/payment_funnel.csv`, `payment_journeys.csv`; charts 03 and 05.

## Finding 3 — A defined list exists for expansion *discovery*, not proven upsell

- **340** unique accounts hold one or more subscriptions with the source `active=1` flag.
- **164** accounts meet the screening heuristic: one distinct active product and a largest single subscription containing at least 5,000 listed users.
- **Business implication:** Verify account ownership, actual seats and product suitability with Customer Success; run a controlled outreach test, rather than assuming the 164 are ready buyers.
- Evidence: `outputs/tables/expansion_candidates.csv` and `sql/03_expansion_screen.sql`.

## Finding 4 — Pricing appears among overlapping cancellation mentions

- **22 of 59** cancellation records (37.29%) mention "Too expensive" in one of up to three reasons.
- Features and no-longer-needed each appear in **21 of 59** records. These reason shares overlap and do not sum to 100%.
- **Business implication:** Use qualitative follow-ups and segment-level willingness-to-pay assessment; indiscriminate discounting is not warranted by the current evidence.
- Evidence: `outputs/tables/cancellation_reasons.csv`; chart 04.

## Finding 5 — Source quality changes the answer

- **119** subscription current-status flags disagree with the latest payment log event.
- **2** duplicate customer dimension keys and **2** cancellation-before-order records were found.
- **Business implication:** Remedy grain and status definitions before operationalising these KPIs; the expanded candidate list is deliberately de-duplicated at customer ID grain.
- Evidence: `outputs/tables/data_quality_checks.csv` and `docs/data_quality_audit.md`.
