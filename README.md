# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

Make sure to install latest version of ruby 2.7.\*

- System dependencies

Bundle Install
`bundle update`
`bundle install`

- Configuration

Create the env file depending on the environment
eg `.env.development`

Add the following properties:

```BASH
POSTGRES_USER=<USER>
POSTGRES_PASSWORD=<PASS>
POSTGRES_DB=<DB NAME>

```

- Database creation

Boot the DB with docker compose
`docker compose up`

- Database initialization

Try to create the db if not created already:
`rake db:create`

Then Migrate:
`rake db:migrate`

Finally seed the DB with the following command:
`rake db:seed`

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
