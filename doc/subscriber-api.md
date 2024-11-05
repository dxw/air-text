# Subscriber API

The airTEXT service will not handle subscriptions for air quality alerts
directly: they will be passed through to CERC, who will record these user
subscriptions and send out the alerts via email, text or phone.

We have mapped out two key user journeys using sequence diagrams to show the
flow of data between participants:

- the user signing up for alerts or signing in to view existing subscriptions
- this airTEXT service under development
- CERC's Subscriber API currently being agreed
- a notification service for authentication flows, e.g. [GOV.UK Notify][]

## Sequence diagrams

### User signs in to view existing alert subscriptions

- So that I can edit my existing alert subscriptions
- As a user with existing subscriptions
- I want to supply either an email or phone number to authenticate and see a
  list of associated alert subscriptions

#### Artefacts

- [User signs in to view existing subscriptions (Mermaid)][]
- [User signs in to view existing subscriptions (PNG)][]

### New user signs up for alert subscriptions

- So that I can receive alerts for the locations which are important to me and
  have them delivered in a way which suits me
- As a new airTEXT user
- I want to specify i) which zones I want alerts for and ii) how I want those
  alerts delivered and have these alert subscriptions associated with a verified
  email and/or phone number

#### Artefacts

- [New user signs up for alert subscriptions (Mermaid)][]
- [New user signs up for alert subscriptions (PNG)][]

## CERC subscriber API

We've suggested an API which would provide a interface for airTEXT to exchange
subscriber/subscription information with CERC:

- [Proposed Subscriber API between airTEXT and CERC][]

[GOV.UK Notify]: https://www.notifications.service.gov.uk
[User signs in to view existing subscriptions (Mermaid)]:
  ./subscriber_api/sequence_user_views_existing_subscriptions.mermaid
[User signs in to view existing subscriptions (PNG)]:
  ./subscriber_api/sequence_user_views_existing_subscriptions.png
[New user signs up for alert subscriptions (Mermaid)]:
  ./subscriber_api/sequence_new_user_signs_up_to_alerts.mermaid
[New user signs up for alert subscriptions (PNG)]:
  ./subscriber_api/sequence_new_user_signs_up_to_alerts.png
[Proposed Subscriber API between airTEXT and CERC]:
  ./subscriber_api/proposed_subscriber_api.md
