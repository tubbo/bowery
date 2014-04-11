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
$ bundle install
$ bowery init
```

This should create an `Componentfile` at the root of your repo, as well as
some support files for telling Bower where to download components.

## Usage

Bowery is meant to be used as the high-level interface by which you
manage assets. Under the hood, it leverages a number of lower-level
components such as [Rake][rake] for task running, [Sprockets][sprockets]
for asset compilation, and [Bower][bower] for asset fetching.

### Installing components

To download Bower components with Bowery, add them to your Componentfile:

```ruby
js 'jquery'
css 'foundation'
```

Once you're done, run the following command from the root of your app to
install your assets:

```bash
$ bowery install
```

### Configuring component options

Components can be given various options, such as configuring the Git repo
by which to pull content from, or specifying a `:path` to use a codebase
on the local disk.

#### Manifest Configuration

You can specify how you want the component to be required into your app
with the **:require** option, like so:

```ruby
css 'foundation', require: { css: false, js: 'javascripts/foundation' }
```

Note that all paths are prepended with the component path, so this will
actually look like the following in the manifest:

```js
//= require ./foundation/javascripts/foundation
```

By default, assets will be required like so in the JS manifest:

```js
//= require ./foundation/foundation
```

And like this in the CSS manifest:

```css
/**
 *= require ./foundation/foundation
 */
```

When we passed `css: false` into the require options, it dictated to
Bowery that we're not going to need a Sprockets directive for this
component's CSS. Instead, we'll use Sass' `@import` directive so that we
can override certain Foundation settings. Sass `@import` directives are
not supported by Bowery at this time.

#### Source Configuration

The following top-level options are available to configure the source by
which you wish to retrieve this asset. By default, if none of these
options are specified, Bower will attempt to simply download the most
recent version of the package that's currently on the registry

- **:path** - Pass a relative or absolute path to specify that this
  component can be found on the local disk.
- **:git** - Specify an alternative Git repository, like your own fork,
  rather than the one on the Bower registry.
- **:github** - A shorthand alias to :git that will expand
  ':user_name/:repo_name' into a GitHub HTTPS URL.

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
Componentfile. You can also update a single component by running:

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
components direct from the Componentfile. You can also specify `--path` to
customize where this file is stored and what it is called. Defaults to
**app/assets/javascripts/application.{js|css}**.

### Contributing

All contributions must be made in the form of a Git or Github pull
request. Contributions without accompanying tests, especially for bug
fixes, will not be accepted. Additionally, contributions which fail the
build on [Travis-CI][travis] will not be accepted.

[bower]: http://twitter.github.io/bower
[rails]: http://rubyonrails.org
[sprockets]: http://github.com/sstephenson/sprockets
[rake]: http://rake.rubyforge.org
[rspec]: http://rspec.com
[travis]: http://travis-ci.org
[cap]: http://capify.org
