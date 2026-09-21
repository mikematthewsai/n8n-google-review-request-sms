# Workflow decision

Scores use a 1 to 5 scale. For **speed**, 5 means a trustworthy first version can be packaged quickly. Total possible score is 35.

| Candidate | Useful now | Public gap | Safe to verify | Portfolio | LinkedIn lesson | Safe to share | Speed | Total |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Google review request by SMS, quiet hours and 90-day deduplication | 5 | 5 | 5 | 5 | 5 | 5 | 5 | **35** |
| Prospect reply-gap alert from the Twilio log | 5 | 4 | 3 | 5 | 4 | 5 | 3 | 29 |
| Stale CRM next-action cleanup report | 4 | 4 | 3 | 5 | 4 | 4 | 2 | 26 |
| Proposal-to-onboarding checklist and owner alert | 4 | 3 | 3 | 5 | 4 | 4 | 2 | 25 |
| Content repurposing and publishing queue | 3 | 2 | 4 | 4 | 4 | 5 | 3 | 25 |

## Selection

**Google review request by SMS** was selected.

It solves a real small-business problem without touching production CRM or customer-facing systems during development. It is already useful to Matthews Automation as a reusable client component, and it demonstrates the less visible parts of implementation work: time-zone planning, deduplication, provider-log reconciliation, truthful error reporting, and a non-gated customer experience.

It also has stronger proof than the other candidates. The final version has ten documented live scenarios and 22 local cases, while the alternatives would require new production integrations or real prospect activity to verify honestly.

## Evidence of a public gap

- n8n's public library has a broad appointment-confirmation, reminder, win-back, and review workflow that depends on Google Sheets, Gmail, Twilio, Slack, and other services and is sold for $149: <https://n8n.io/workflows/17123-send-appointment-confirmations-reminders-and-reviews-with-sheets-gmail-and-twilio/>
- Search results for review automation are concentrated on reading and replying to existing reviews, including AI-generated responses, rather than reliably asking every completed customer for one review.
- One public law-firm request workflow routes only high ratings to Google and low ratings to a private form. The selected workflow intentionally sends the same Google link to every completed customer instead.
- The selected workflow needs only n8n and Twilio, uses the provider log rather than a separate database, and documents live defects and re-tests.

The claim is not that no similar workflow exists. The defensible claim is that the common public examples are broader, heavier, paid, oriented toward review replies, or weak on deduplication and failure evidence.

## Four-week backlog

1. **Prospect reply-gap alert:** surface inbound messages that have not received a business reply, using the Twilio log as evidence.
2. **CRM next-action hygiene report:** find qualified opportunities with no owner, due date, or next action, without modifying them automatically.
3. **Proposal-to-onboarding handoff:** turn an accepted proposal into a checklist and owner alert with idempotent retries.
4. **Client proof brief:** produce a weekly, sanitized report of completed work, exceptions, and next decisions.

Each week follows the same loop: observe a real internal problem, check the public template gap, build one modest improvement, verify it, sanitize it, publish the workflow and proof, then reuse the implementation lesson as content.

