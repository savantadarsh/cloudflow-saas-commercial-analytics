# KPI definitions and analytical grain

| Metric | Definition | Unit / denominator | Caveat |
|---|---|---|---|
| Recorded order value | `SUM(subscriptions.revenue)` grouped by `orderdate` | GBP (£), display assumption; source currency unspecified | Not MRR, ARR, recognised revenue or settled payments |
| YoY recorded order value | `(2023 total / 2022 total) - 1` | Percentage | Mix, pricing and counts all contribute; not same-account growth |
| Product contribution to growth | 2023 less 2022 recorded order value for each product | GBP (£), reporting assumption | Product names from `products` dimension |
| Widget-opened subscriptions | Unique `subscriptionid` with payment status 1 | 403 | 2024 logs; not unique user sessions or payment attempts |
| Stage reach | Unique subscriptions with `statusid` in 1–5 | Distinct subscriptions | A subscription can retry; status 0 error is not ordered funnel step |
| Completion rate among openers | Unique subscriptions with status 5 / with status 1 | 78 / 403 = 19.35% | *Complete* is a logged stage; does not independently verify settlement |
| Non-completion count | Widget-opened distinct subscriptions minus those reaching Complete | 403 − 78 = 325 | Not proven abandoned/recoverable orders |
| Completed-journey duration | Last minus first movement timestamp where status 5 ever reached | Median 28 min; p90 40.3 min | Log span includes pauses/retries; not active screen time |
| Cancellation reason share | Distinct cancelled subscriptions mentioning reason in any of three reason fields / cancellation records | 22 / 59 = 37.3% for price | Non-exclusive; not customer churn rate or primary reason share |
| Expansion screen | `active=1`, one distinct product and at least 5,000 seats in *largest* active subscription | 164 of 340 accounts with source-active subscription | Seat overlaps, opportunity size, age, as-of date and propensity unknown |
| Financial scenario net contribution | Candidates × uptake × incremental annual order value × contribution margin − implementation spend | Hypothetical GBP (£) over 12 months | Input assumptions are illustrative; no causal uplift evidence |

**Important chronology:** Recorded orders are dated 2022–2023; payment movements are dated January–April 2024; cancellations span 2022–2024; frontend events are dated April–July 2023. Treat these as different observational windows rather than building an ungrounded end-to-end acquisition-to-payment causal funnel.
