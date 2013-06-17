# Bowery

Bowery is a dependency manager for your JavaScript and CSS assets in a
[Ruby on Rails][rails] app. It is the missing link between
[Bower][bower], an amazing web package manager, and [the asset
pipeline][sprockets]. Bowery allows you to manage your JavaScript
dependencies in the same manner as your RubyGem dependencies, and fits
right in with Sprockets to hook into precompilation so you never have to
store your external JavaScript assets in the repo again.

## Features

- Bundler-style DSL syntax for describing JavaScript dependencies
- Makes use of the powerful [Bower][bower] package manager to download
  and update asset packages.
- Hooks into [Sprockets][sprockets] tasks for precompilation to
  provide seamless asset fetching in production.

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
component 'jquery'
component 'jquery_ujs'
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

You can also use Bowery as part of a [Capistrano][cap] deployment by using the
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

### Generating Sprockets manifests

Bowery is also handy for generating your `application.js` manifest file.
Just run the generator!

```bash
$ rails generate bowery:manifest
```

This will generate an `application.js` file in
**app/assets/javascripts** that contain all of your Bowery-installed
components direct from the Assetfile.

## Development

Bowery was built with [Librarian][librarian], a framework for building
Bundler-style dependency managers. First demonstrated in
[Librarian::Chef][librarian-chef], we took their underlying framework
and reworked it to fit the [Bower][bower] package management tool.
Bowery is built with Ruby and developed specifically for the [Ruby on
Rails][rails] web application framework.

We use the full [RSpec][rspec] framework for our testing purposes, as
well as the `Rails::Engine` test helpers and dummy app for actual
testing of the gem's effects.

### Contributing

All contributions must be made in the form of a Git or Github pull
request. Contributions without accompanying tests, especially for bug
fixes, will not be accepted. Additionally, contributions which fail the
build on [Travis-CI][travis] will not be accepted.

[bower]: http://twitter.github.io/bower
[rails]: http://rubyonrails.org
[sprockets]: http://github.com/sstephenson/sprockets
[rake]: http://rake.rubyforge.org
[librarian]: http://github.com/applicationsonline/librarian
[librarian-chef]: http://github.com/applicationsonline/librarian-chef
[rspec]: http://rspec.com
[travis]: http://travis-ci.org
[cap]: http://capify.org
