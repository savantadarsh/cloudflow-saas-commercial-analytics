# Decision brief — three interventions, with gates

**Audience:** VP Product, Revenue Operations and Customer Success.  
**Context:** Independent CloudFlow portfolio case study using a limited historical dataset with known inconsistencies; the company context is fictional.

| Priority | Recommendation | What supports it | First validation gate | Next KPI | Status |
|---|---|---|---|---|---|
| 1 | Resolve the meaning of Payment Success → Complete and instrument attempt-level outcomes | 150 subscriptions reached success; 78 reached Complete; 119 latest-status mismatches | Reconcile payment provider ledger, event definitions and an independently reviewed set of journeys | Verified settled-order completion rate by attempt and error class | Investigation, **not a proven revenue recovery** |
| 2 | Pilot expansion outreach to eligible existing accounts | 164 source-active, single-product accounts with ≥5,000 seats in one subscription | Verify customer identity, seats, eligibility, sales capacity and offer economics | Incremental contract value and profit **versus control** | Screening pool, **not sales forecast** |
| 3 | Run pricing/value interviews with cancelling cohorts | 22/59 cancellation records mention price; 21 each mention features / no longer needed | Confirm primary reason, account segment, competitor and willingness-to-pay | Save rate, net contribution, ongoing retention, complaint trend | Hypothesis needing testing |

## Illustrative 12-month expansion scenario — not observed benefit

The only **observed** number in this model is the screened eligible-account count (164); every other input is a clearly labelled scenario assumption.

| Hypothetical input | Conservative | Base | Upside |
|---|---:|---:|---:|
| Eligible accounts (observed screen) | 164 | 164 | 164 |
| Hypothetical offer uptake | 5% | 10% | 20% |
| Hypothetical incremental annual contract value per adopter | £2,000 | £3,000 | £4,000 |
| Hypothetical contribution margin | 65% | 70% | 75% |
| Hypothetical implementation cost | £10,000 | £12,000 | £16,000 |
| **Modelled net incremental contribution** | **£660** | **£22,440** | **£82,400** |

Method: `eligible × uptake × incremental annual value × contribution margin − campaign cost`. Expected adopters can be fractional because this is an expected-value estimate. The scenarios **are not predictions, achieved savings or measured ROI**. Neither product prices nor actual outreach costs are supplied.

## Suggested execution and measurement plan

**Weeks 1–2:** Confirm data contracts, remove duplicate dimension keys, reconcile status event semantics, validate instrumented checkout logs; freeze KPI definitions.  
**Weeks 3–4:** Create properly attributed payment-attempt funnel; reconcile to settlement data; estimate *verified* value at risk only if matching monetary amounts exist.  
**Weeks 5–8:** Run a customer-success pilot with an eligible and comparable control group. Record exposure, acceptance, incremental contract value and any costs.  
**Week 9+:** Assess contribution after costs, holdout-adjusted uplift and segment heterogeneity. Expand only if economics and customer experience support it.

## Risks and alternatives

Selection bias (active accounts may differ systematically), missing billing cadence, cross-year data mismatch, concurrent campaigns, imperfect status instrumentation and uncertain provider success semantics all restrict attribution. Prefer controlled tests and a measured operational process over large extrapolated promises.
