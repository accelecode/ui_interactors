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

Consider a simple example: automating the sign in process for a typical web application.

Here is the `HTML` generated for the sign in form:

```html
<div data-view="sign-in">
  <div>
    <label for="email">Email</label>
    <input type="text" name="email" value="">
  </div>
  <div>
    <label for="password">Password</label>
    <input type="password" name="password" value="">
  </div>
  <button type="submit" data-action="submit">Sign In</button>
</div>
```

Here is the important part of the `HTML` we expect to see on the authenticated home page/dashboard page: 

```html
<div data-view="dashboard">
</div>
```

And finally, this is the `Ruby` we expect to write to automate the sign in process:

```ruby
require 'ui_interactors/minitest/interactor_test'

class TestSignInSuccess < UiInteractors::InteractorTest

  def provide_driver
    DriverProvider.instance.driver
  end

  def test_successful_sign_in
    view('dashboard').is_not_visible!

    view('sign-in').tap do |v|
      v.is_visible!
      v.text_field('email').enter_text('a7a80644@d9c4d54f.5a0')
      v.text_field('password').enter_text('57bc8f19c898')
      v.action('submit').activate
      v.is_not_visible!
    end

    view('dashboard').is_visible!
  end

end
```

We used `minitest` for our example, but that is not required. You can use any test framework you want - or, no test framework at all. However, there is a special level of support provided by the gem for `minitest`.

The beauty of this approach is that style changes to the sign in form will **not** cause test failures. This is because the attribute-based approach used to select, interact with and test visibility of elements is resistant to style changes.

For example, the same test would pass for this sign in form with more elements and also styled with `bootstrap` CSS:

```html
<div class="panel panel-default" data-view="sign-in">
  <div class="panel-heading">Please Sign In</div>
  <div class="panel-body">
    <form>
      <div class="form-group">
        <label for="email">Email</label>
        <div class="field">
          <input type="text" name="email" class="form-control" value="">
        </div>
      </div>
      <div class="form-group ">
        <label for="password">Password</label>
        <div class="field">
          <input type="password" name="password" class="form-control" value="">
        </div>
      </div>
      <div class="text-right">
        <button data-action="forgot-password" type="button" class="btn btn-link"
                style="font-size: 12px; padding: 0px 0px 10px;">Forgot Password?
        </button>
      </div>
      <button type="submit" data-action="submit" class="btn btn-primary" style="width: 100%;">Sign In</button>
      <div class="lined-header">
        <hr>
        <span>Don't have an account?</span></div>
      <button data-action="sign-up" type="button" class="btn btn-default" style="width: 100%;">Sign Up</button>
    </form>
  </div>
</div>
```

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