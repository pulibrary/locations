# PUL Locations

[![Build Status](https://travis-ci.org/pulibrary/locations.png?branch=development)](https://travis-ci.org/pulibrary/locations)
[![Coverage Status](https://coveralls.io/repos/pulibrary/locations/badge.svg?branch=development)](https://coveralls.io/r/pulibrary/locations?branch=development)

A mountable Rails Engine for managing PUL Library, Holding, Hours, and Delivery location data, including forms for managing that data and JSON APIs for integration with other services.

## To Install for Development

After you've cloned the repo:

```
$ bundle install
$ rake engine_cart:regenerate
$ rake spec
```

## To Mount in an Application

In your application gemfile add

```
gem 'locations', git: 'git@github.com:pulibrary/locations.git', branch: 'development'
```

Then run

```
$ bundle install
$ rails generate locations:install
```
