# A La Carte

This is a backend API that manages recipe information.

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

# Run Development Environment

Before running make sure the Database is running, see above how to run.

`bin/rails s`

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- Auth0 Code Flow

This projects API uses codeflow with Auth0.
See more info [here](https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow/add-login-auth-code-flow)
See api prereqs [here](https://auth0.com/docs/get-started/authentication-and-authorization-flow/authorization-code-flow/call-your-api-using-the-authorization-code-flow)

Essentially,

1. the front end initiates the authentication code flow with authorize?
2. Then a code is sent back as url param
3. This url parama "code" can be used to retrieve access token.
4. Access token is stored a http only cookie to be used as bearer token.
5. Backend validates access_token and permissions within. Responds accordingly, granted -> RESPONSE(200...) not granted 403 Forbidden.

# Rails Generate commands

To generate models, controllers, migrationssee below commands, there are more examples in Rails documentation

```BASH

rails g model Cookbook name:string user_id:User is_favorite:boolean

rails g model User sub:string

rails g controller Cookbook index create edit destroy

bin/rails generate migration AddCookbookAndUserIdToRecipe
```
