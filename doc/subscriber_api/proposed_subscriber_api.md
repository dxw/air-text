# Proposed Subscriber API

**Oct 24, 2024**

## Operations on subscribers

### Find a user's SubscriberID

GET to `/find-subscriber` with

- `email` or
- `phone`

returns subscriber representation, status 200:

- subscriberId (UUID)

returns 404 if not found

## Operations on subscriptions

### List subscriptions for subscriber

We'll need this to:

- show a logged in user their list of subscriptions
- delete all subscriptions if a user want to withdraw from the service fully

GET `/subscriptions/{subscriberId}`

returns list of subscriptions:

- subscriptionId
- subscriberId
- zone or zoneID
- medium (email | voice | sms)

### Create subscription

POST to `/subscriptions` with:

- subscriberId (optional)
- zone
- medium (email | txt | voice)

returns subscription ID (UUID), status 201

If a UUID is not supplied a new `subscriberID` UUID is generated (and can then
by used for making further subscriptions for the a new user)

### Delete subscription

DELETE to` /subscriptions` with:

- subscriptionId UUID

returns `subscriptionId`, status 200
