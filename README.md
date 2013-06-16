# Bowery

Bowery is an asset management system for Rails applications. It
leverages Bower, Librarian and Sprockets to provide a complete solution
for managing JavaScript and CSS assets in a Rails app.

## Features

- Bundler-style DSL syntax for describing JavaScript dependencies
- Makes use of the powerful [Bower][bower] package manager to download
  and update asset packages.
- Hooks into [Sprockets][sprockets-rails] tasks for precompilation to
  provide seamless asset fetching in production. You never need to check
  your `vendor/assets/components` directory into the repo ever again!

## Installation

Add the following line to your application's Gemfile:

```ruby
gem 'bowery'
```

Then, run the generator:

```bash
$ bundle && rails generate assets:manifest
```

This should create an `Assetfile` at the root of your repo, as well as
some support files for telling Bower where to download components.

## Usage

Bowery is meant to be used as the high-level interface by which you
manage assets. Under the hood, it leverages a number of lower-level
components such as [Rake][rake] for task running, [Sprockets][sprockets]
for asset compilation, and [Bower][bower] for asset fetching.

### Installing assets

To download assets, add them to your Assetfile:

```ruby
js 'jquery'
js 'jquery-ujs'
css 'foundation'

group :test do
  js 'jasmine'
end
```

The `js` and `css` methods both alias to `component`.

Once you're done, run the following command from the root of your app to
install your assets:

```bash
$ bowery install
```

### Precompiling assets in production

Bowery can also be used to fetch assets just prior to asset
precompilation. The Rake task `assets:install` will run `bowery
install` independently, and the `assets:precompile` task is overridden
to include this new task.

You can also use Bowery as part of a Capistrano deployment by using the
regular Sprockets Capistrano task, as it will run `rake
assets:precompile`, which is hooked to provide Bowery support.

### Updating assets

Assets can be updated by simply running the following command:

```bash
$ bowery update
```

This basically rebuilds the lockfile with the versions specified in
Assetfile. You can also update a single component by running:

```bash
$ bowery update jquery
```

### File Locations

All assets are downloaded to `vendor/assets/components`. An initializer
that comes included in the `Rails::Engine` configures Sprockets to read
assets from this directory. Additionally, the install generator will add
this directory to `.gitignore` to make sure Bower-fetched assets won't
be accidentally committed to the repo.
