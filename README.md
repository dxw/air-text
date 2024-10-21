# airTEXT

This is a rebuild of the airTEXT.info service

1. [Getting started](/doc/getting-started.md)

## Description of the service

A service for providing forecasts and personalised alerts on air quality and
other environmental factors in:

- Greater London
- Cambridge
- the Chelmsford/Colchester area

## Terminology

We aim to use and refine a "ubiquitous language" for use throughout the service.
We believe that this will optimise our communication and minimise our
misunderstandings and our cognitive load. We will aim use the same terms in:

- the UI of the service
- the code we write
- our sketches and mockups
- our research sessions
- our documentation and our presentations to partner organisations

See [./doc/terminology.md][]

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

The service is deployed to Heroku at
[https://air-text-3e4548b53179.herokuapp.com/][].

## Source

This repository was bootstrapped from
[dxw's `rails-template`](https://github.com/dxw/rails-template).

[https://air-text-3e4548b53179.herokuapp.com/]:
  https://air-text-3e4548b53179.herokuapp.com/
[./doc/terminology.md]: ./doc/terminology.md
