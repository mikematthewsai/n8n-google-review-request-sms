# Sprint inventory

Observed on 2026-09-21. Private configuration, webhook addresses, credentials, contact details, and customer data are intentionally omitted.

## n8n account

The account contained 27 workflows. Eighteen were published and nine were unpublished templates, setup utilities, or inactive creative pipelines.

### Published and used or tested

- Lead response system: Setup, Core Error Handler, Send SMS, Owner Alert, Inbound SMS Router, Lead Pipeline, Website Form, and Phone Line.
- Review system: Review Engine and Review Entry.
- Follow-up add-ons: Quote Chaser, Invoice Nudge, Morning Brief, and three phone-friendly entry forms.
- Appointment Reminder and its entry form.
- The Cold Archive render and post pipeline.

The n8n overview showed 71 production executions, three failed production executions, a 4.2% failure rate, and 1.54 seconds average runtime. One Cold Archive execution had been running for roughly 95 hours and was not changed.

### Unpublished but tested templates

- Google review request by SMS: ten documented live scenarios, 22 local planning and deduplication cases, and a recent execution list containing 15 successes plus one canceled quiet-hours test.
- Appointment reminders with quiet hours: four live runs and 11 planning cases.
- STOP, START, and HELP handler: six simulated inbound events, real owner alerts, a public echo endpoint standing in for a CRM, and 12 local sorting cases.
- Standalone quote chaser: three documented live runs.
- Standalone 7 AM owner brief: documented live manual runs.

### Draft, setup, or unused

- Twilio inbound-webhook repointing utility.
- Setup workflow, which is intentionally not published as a trigger.
- Nightwake Post Health Check and Generate Music Beds were not published.

## Existing GitHub presentation

- The public profile has 13 repositories.
- `n8n-lead-response` is pinned and is the main workflow portfolio piece.
- It presents 15 connected workflows plus five standalone templates, an MIT license, diagrams, setup documentation, test logs, known limitations, and CI validation.
- The repository showed 38 commits, zero stars, zero forks, and zero watchers at inspection time.
- The profile README gives the n8n repository prominent treatment and links the workflow, its diagram, and the standalone template folder.
- The other prominent public case study is `clinic-billing-architecture`, focused on architecture and privacy boundaries rather than an importable workflow.

The opportunity is presentation focus, not missing substance. A single-workflow drop gives a prospective client or employer a smaller artifact they can understand and import quickly.

## LinkedIn inventory and traction

Five published posts were visible. No scheduled posts were listed.

| Topic and hook | Age | Visible engagement |
| --- | --- | --- |
| Gave away a tested n8n lead-response workflow, opening with the bug found during STOP testing | 3 days | 62 impressions, 1 comment |
| Automated the task he dreads, but wrote the LinkedIn post by hand | 2 months | 212 impressions |
| Sensitive automation should stay local when possible | 2 months | 143 impressions |
| The unglamorous plumbing behind starting a business | 3 months | 62 impressions |
| Automate volume, keep human voice human | 3 months | 27 impressions |

The strongest available pattern is a first-person tension followed by a concrete operating lesson. The best-performing post was not a feature list; it started with a task Mike avoids and a boundary he would not automate. The privacy post also did well by teaching one clear architectural principle. The new workflow post should therefore lead with a real missed business habit, show one defect found in testing, and avoid repeating the previous broad lead-response launch.
