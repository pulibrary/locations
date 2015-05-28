# PUL Locations

A mountable Rails Engine for managing PUL Library, Holding, and Delivery location data, including forms for managing that data and (read-only) JSON APIs for integration with other services.

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
$ rails generate locations:install
```