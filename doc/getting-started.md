# Set up

## Install Ruby dependencies

This project uses Ruby on Rails, so you need to have Ruby installed. You can use
a version manager like RVM or rbenv to manage your Ruby versions. Make sure you
have the correct Ruby version specified in the `.ruby-version` file. You can
check your Ruby version with:

```bash
ruby -v
```

Install bundler to manage Ruby gems:

```bash
gem install bundler
```

Install the required gems for the project:

```bash
bundle install
```

## Install JavaScript dependencies

This project uses Yarn for managing JavaScript dependencies. Make sure you have
Node.js and npm installed. You can check your Node.js version with:

```bash
node -v
```

And your npm version with:

```bash
npm -v
```

Install Yarn if you haven't already:

```bash
npm install yarn
```

Then, install the JavaScript dependencies:

```bash
yarn install
```

## Set up the database

This project uses PostgreSQL as the database. Make sure you have PostgreSQL
installed and running. You can check your PostgreSQL version with:

```bash
psql --version
```

Create the database:

```bash
rails db:setup
```

The database will be seeded with the zones and zone groups defined in the
`db/seeds.rb`.

## Set up environment variables

This project uses environment variables for configuration. For local
development, create a `.env.development.local` file in the root of the project
and add the necessary environment variables. You can refer to the `.env.example`
file for guidance on what variables are needed.

On a production server, you should set these environment variables in your
server's configuration.
