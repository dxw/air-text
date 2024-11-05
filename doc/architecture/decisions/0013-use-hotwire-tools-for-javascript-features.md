# 13. Use Hotwire tools for Javascript features

Date: 2024-10-09

## Status

Accepted

## Context

AirTEXT is in part a "single-page application". We are planning to offer users a
single view on which they can switch between 3 days (today, tomorrow and the day
after). On each day's tab they will be able to:

- view predictions and guidance about air quality, pollen, UV and temperature

- interact with a map comprising a number of overlays showing various aspects of
  air quality, e.g. layers for nitrogen dioxide, particulate matter and ozone

This functionality will benefit from a front-end implementation where sections
of the page are reloaded as required, e.g. as a user chooses to load forecasts
for a different area or switches to a different day.

## Decision

We're going to use Rails' [Hotwire][] tools and conventions to:

- swap out chunks of pages using [Turbo][] (with HTML fragments prepared on the
  server rather than by building views from JSON in the brower with custom JS)

- handle UI sprinkles with [Stimulus][] e.g. for setting classes on UI events

## Consequences

We believe that by adopting the Hotwire conventions we'll produce more
maintainable code, with a greatly reduced amount of Javascript.

Developers will need to become familiar with the Hotwire techniques. We've found
Pragmatic Bookshelf's "[Modern Front-End Development for Rails][]" by Noel
Rappin to be a good complement to the offical online docs.

[Hotwire]: https://hotwired.dev
[Turbo]: https://turbo.hotwired.dev
[Stimulus]: https://stimulus.hotwired.dev
[Modern Front-End Development for Rails]:
  https://pragprog.com/titles/nrclient2/modern-front-end-development-for-rails-second-edition
