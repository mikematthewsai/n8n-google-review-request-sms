# LinkedIn draft

I kept forgetting the same small task after a job: ask the customer for a review while the work was still fresh.

So I built a small n8n workflow for my own business.

When a job is marked complete, it waits two hours, stays out of quiet hours, checks whether that customer already received the same Google review link in the last 90 days, and sends one text. The owner gets a plain-English update if it sent, skipped, or failed.

The useful part was not the happy path. It was the failed-send test.

Twilio keeps failed text attempts in its message log. My first version saw that record and treated it as a successful review request. A customer who never received the text could have been skipped for 90 days.

I changed the check to ignore failed, undelivered, and canceled messages, then reran the case. The retry went through.

I also kept the workflow intentionally boring: no AI model, no spreadsheet, no separate database, and no review gating. Every completed customer gets the same review link. Twilio's own log is the delivery record.

The final version went through ten live scenarios on a real Twilio number plus 22 clock-frozen planning and deduplication cases. I have listed what passed and what is still unverified in the repository.

The workflow is free to use and modify: https://github.com/mikematthewsai/n8n-google-review-request-sms

If you run a service business, what part of the review request process is easiest to forget: asking, timing it, or making sure the same customer is not asked twice?

## Publication recommendation

Publish Tuesday, September 22, 2026, at 9:00 AM Eastern. There are no scheduled LinkedIn posts, and this leaves four days after the previous workflow post while keeping the weekly-series promise.

## Accompanying visual

Use `docs/workflow-diagram.svg` as the lead image. It shows the business logic without exposing an account, webhook, credential, or customer record.

## Follow-up post

**A failed text is still a record, but it is not proof of delivery.** Explain why provider logs must be filtered by delivery status before they are used for deduplication, and show the before-and-after decision rule.

## Next workflow category

Investigate prospect reply-gap alerts next: identify inbound Twilio messages that did not receive a business reply, surface them to the owner, and do not auto-message the prospect.
