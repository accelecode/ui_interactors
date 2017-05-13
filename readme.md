# UI Interactors

**UI Interactors** makes it easy to automate browser interaction using `selenium-webdriver` by following a series of conventions for *selecting* and then *interacting* with various types of HTML elements.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ui_interactors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ui_interactors

## Usage

TODO

## Development

#### Setup

After checking out the repo, in `src/gem`, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

#### Testing

A full suite of tests exist for this gem in `src/test`. The suite uses a web server to serve static files required for testing. The server must be started before the test suite is run. Start the server using:

    src/test $ bundle exec rake server

Run the test suite using:

    src/test $ bundle exec rake test

You can specify a file pattern to use to select test files to include. The default pattern, if no pattern is supplied, is `./tests/**/test_*.rb`

#### Publishing Gem Releases

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [ui_interactors](https://github.com/accelecode/ui_interactors).

It would be advisable to open an issue before developing new gem features and opening a pull request.