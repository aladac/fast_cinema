# README

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/8964ece6f80445408c6be8d678549537)](https://app.codacy.com/gh/aladac/fast_cinema?utm_source=github.com&utm_medium=referral&utm_content=aladac/fast_cinema&utm_campaign=Badge_Grade_Settings)
[![Codacy Badge](https://app.codacy.com/project/badge/Coverage/1807b17f91514791b7dc0d8ee8ddf22a)](https://www.codacy.com/gh/aladac/fast_cinema/dashboard?utm_source=github.com&utm_medium=referral&utm_content=aladac/fast_cinema&utm_campaign=Badge_Coverage)

# Description
MVP cinema API 

## Setup
```sh
$ git clone git@github.com:aladac/fast_cinema.git

$ cd fast_cinema

$ bundle install 

$ rails db:setup

$ rails server

# visit http://localhost:3000 in browser
```

## Features
### Get Movie info
- list `/movies`
- show `/movies/{id}`
- leave rating `/movies/{id}/review/{rating}`

### CRUD on Prices
- `/prices/{id}`
- `/prices`

### CRUD on Showings
- `/showings/{id}`
- `/showings`

### View showitmes
- endpoint for apps, digital signage, lobby display
- `/showtime`
- time filters `start` and `finish` 
- to add to this view:
  - Create a `Price` or use an existing one
  - Create a `Showing` using the `Price` and `Movie`
  - `/showtime` should now show the significant details 

### Too many review ratings protection
A simple protection was implemented using cache to prevent multiple calls which engage a DB query.
To run on `development` enable `rails dev:cache` first.

### Rake tasks
```sh
# OMDB_API_KEY env var should hold the key

$ OMDB_API_KEY=key_value rails -T omdb
rails omdb:import  # Import all movies
rails omdb:update  # Update existing movies
```

## DEVOPS
### Deployment
App is currently deployed automatically on Heroku from the `master` branch:

https://fast-cinema.herokuapp.com/

The app redirects to the swagger API docs and is seeded with example `Prices` and all `Movies`

### Code and Style
Codacy integration was added
### GitHub Actions
Lint and specs run on GH Actions

# What I missed, what would I add
- Better, more detailed specs
- Scoping by cinema this app is easily adaptable to be mutli tenant
- Pagination and filtering
- Better `429` handling
- More sensible commit messages and PR's referencing issues / tasks if possible
