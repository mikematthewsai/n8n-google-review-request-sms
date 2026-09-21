# Verified results

Test date: 2026-09-21.

The workflow was exercised through its production webhook against a real Twilio number. The owner's controlled handset stood in for the customer. No customer was contacted.

## Live scenarios

| Scenario | Result |
| --- | --- |
| Invalid short phone number | Passed. Webhook returned `ok: false`, the owner was told why, and no customer text was sent. |
| Placeholder review link | Passed. The execution stopped before waiting and reported the missing configuration. |
| Normal completed job with zero delay | Passed. The workflow checked 89 earlier outbound texts, found no matching review link, sent one request, and notified the owner. |
| Same customer immediately after a successful request | Passed. The earlier request was found and the new send was skipped. |
| Same event posted twice, seconds apart, with a two-minute delay | Passed. One execution waited and sent; the duplicate was refused as already waiting. |
| Request planned inside a test quiet window | Passed for planning and exact resume time. It resumed at the end of the quiet window and was then canceled manually, so no real customer text was sent in that scenario. |
| Twilio rejects the destination | Passed after a defect fix. The owner received Twilio's specific message and code. |
| Same rejected destination retried | Passed after a defect fix. The failed attempt did not count as a prior request. |
| Owner updates disabled | Passed. The review request sent and the owner received no success text. |
| New event 90 seconds after a successful request | Passed. It was refused while the in-flight guard was valid, then accepted after the two-minute expiry. |

The recent n8n execution list showed 15 successful executions for the final workflow and one canceled execution associated with the quiet-hours test.

## Defects found and fixed

1. **Waiting memory never cleared.** A static-data write after the Wait node was not retained. The guard now expires two minutes after the planned send time, after which the Twilio message log is authoritative.
2. **The provider error was hidden.** The standard Twilio node returned a generic message. The customer send now uses Twilio's Messages API through an authenticated HTTP node with non-throwing responses so the owner can see the useful provider reason.
3. **A failed send counted as an ask.** Twilio records failed attempts. Deduplication now ignores failed, undelivered, and canceled messages.

## Local harness

The planning and checking code passed 22 clock-frozen cases covering:

- quiet hours that wrap midnight and daytime quiet windows;
- exact quiet-hour boundaries;
- zero delay;
- invalid numbers and missing configuration;
- missing name or job values;
- both sides of the 90-day boundary;
- outbound texts without the review link;
- failed delivery statuses; and
- expiry of the in-flight duplicate guard.

## Export integrity

After testing, the workflow settings were restored to defaults and all business values were replaced with fictional placeholders. The exported workflow matched the tested n8n workflow node by node, excluding generated IDs and credential references. The package validator independently checks that the export parses, contains the expected nodes, has no credential block, retains fictional settings, and does not contain obvious secrets or production URLs.

## Not verified

- A real opted-out handset producing Twilio error `21610` was not used in this workflow.
- The default two-hour delay was shortened during live runs.
- A full overnight wait was not observed live, although the planned resume time was exercised in the local harness.
- Live sends used one controlled handset rather than several independent customer phones.
- Recovery after n8n restarts during a Wait was not exercised.
