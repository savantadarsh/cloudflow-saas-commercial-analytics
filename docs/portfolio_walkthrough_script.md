# CloudFlow — interview walkthrough

This is a short speaking outline, not something to memorise word for word. Use the charts when explaining the results.

**The context.** CloudFlow is a fictional B2B SaaS company. I looked at revenue, payment events and customer records to understand where the business should investigate next. I wanted to distinguish findings we can act on from questions the available data cannot settle.

**Revenue.** Recorded order value increased from £4.15 million in 2022 to £4.60 million in 2023, about 10.7%. Pro made up around 64% of that increase. I would look at order count, order size and customer mix before assuming the tier is more profitable or has better retention.

**Payments.** Of 403 subscriptions that opened the payment widget, 78 reached Complete, so the recorded completion rate is 19.4%. But 150 reached Payment Success, and there are 119 mismatches between the stored current status and the latest event. I would reconcile those states with settlement records before calling anything lost revenue.

**Customer opportunity.** The screening rules identified 164 unique accounts with one active product and at least 5,000 seats on one subscription. That's a manageable list for Customer Success to review, not a forecast of 164 upgrades.

**What I'd recommend.** I would fix measurement and validate the payment funnel first, while running a small expansion pilot with a control group. The financial model tests different assumptions about uptake, contract value, margin and programme cost; none of those scenarios is an achieved result.

**What I'd discuss if asked:**

- **Why not report MRR or NRR?** The records do not give a reliable history of recurring invoices by account and period.
- **What exactly does 19.4% measure?** Unique subscriptions reaching Complete divided by unique subscriptions reaching Widget Opened, regardless of repeated events.
- **Why not claim payment revenue was lost?** The 2024 event log cannot be tied to a settlement ledger or the 2022–2023 order amounts.
- **How did you stop duplicate accounts affecting the results?** I counted customer IDs, distinct active products, and the maximum number of seats on one active subscription. I also flagged duplicate customer-table keys.
- **What would you do next with more data?** Build an attempt-level payment funnel with settled amounts, then measure realised incremental value from a controlled expansion offer.

**Before recording a walkthrough:** Reproduce the figures, understand the grain of the SQL queries, and explain the limitations in your own words.
