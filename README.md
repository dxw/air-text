# airTEXT

This is a rebuild of the airTEXT.info service

1. [Getting started](/doc/getting-started.md)

## Tests

### Local unit and integration tests

#### Fast feedback loop

These tests (Rspec and Capybara) can be run at maximum speed with:

```sh
bundle exec rspec
```

### Full pre-commit checks

Before committing you should run our complete set of checks and tests.

Choose from either the dockerised or undockerised version of the supplied
comprehensive test script which includes:

- formatting files with `prettier`
- checking scripts with `shellcheck`
- linting Ruby files with `standardrb`
- linting JS with `eslint`
- linting CSS with `stylelint`
- running automated test suite with `rspec`
- running API specs and generating OpenAPI spec via the
  `rswag_api_tests_with_docs` `rake` task
- analysing vulnerabilities in Ruby gems with `brakeman`

e.g.

```sh
./script/no-docker/test
```

## Making changes

When making a change, update the [changelog](CHANGELOG.md) using the
[Keep a Changelog 1.0.0](https://keepachangelog.com/en/1.0.0/) format. Pull
requests should not be merged before any relevant updates are made.

## Releasing changes

When making a new release, update the [changelog](CHANGELOG.md) in the release
pull request.

## Architecture decision records

We use ADRs to document architectural decisions that we make. They can be found
in doc/architecture/decisions and contributed to with the
[adr-tools](https://github.com/npryce/adr-tools).

## Managing environment variables

We use [Dotenv](https://github.com/bkeepers/dotenv) to manage our environment
variables locally.

The repository will include safe defaults for development in `/.env.example` and
for test in `/.env.test`. We use 'example' instead of 'development' (from the
Dotenv docs) to be consistent with current dxw conventions and to make it more
explicit that these values are not to be committed.

To manage sensitive environment variables:

1. Add the new key and safe default value to the `/.env.example` file eg.
   `ROLLBAR_TOKEN=ROLLBAR_TOKEN`
1. Add the new key and real value to your local `/.env.development.local` file,
   which should never be checked into Git. This file will look something like
   `ROLLBAR_TOKEN=123456789`

### Required environment variables

- `CERC_API_HOST_URL`: find the URL of the CERC API host in the 1Password vault
- `CERC_API_KEY`: find the API key in the 1Password vault

## Access

TODO: Where can people find the service and the different environments?

## Source

This repository was bootstrapped from
[dxw's `rails-template`](https://github.com/dxw/rails-template).
