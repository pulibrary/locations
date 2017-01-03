# PUL Locations

[![Build Status](https://travis-ci.org/pulibrary/locations.png?branch=master)](https://travis-ci.org/pulibrary/locations)
[![Coverage Status](https://coveralls.io/repos/pulibrary/locations/badge.svg?branch=master)](https://coveralls.io/r/pulibrary/locations?branch=master)

A mountable Rails Engine for managing PUL Library, Holding, Hours, and Delivery location data, including forms for managing that data and JSON APIs for integration with other services.

## To Install for Development

After you've cloned the repo:

```
$ bundle install
$ rake engine_cart:regenerate
$ rake spec
```
Note: [phantomjs](http://phantomjs.org/download.html) must be installed and in your PATH for all tests to pass.

## To Mount in an Application

In your application gemfile add

```
gem 'locations', git: 'git@github.com:pulibrary/locations.git', branch: 'master'
```

Then run

```
$ bundle install
$ rails generate locations:install
```
