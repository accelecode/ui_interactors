# UI Interactors

**UI Interactors** makes it simple to write automated browser tests using `selenium-webdriver` - tests which are resilient to `HTML` structure and style changes.

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

### Overview

Use **interactors** to select, interact and test visibility of elements. The goal of the `ui_interactors` gem is to allow you to write simple `Ruby` code like this to automate functional tests for web applications - tests that are resilient to `HTML` layout changes and `CSS` style changes:

```ruby
view('dashboard').is_not_visible!

view('sign-in').tap do |v|
  v.is_visible!
  v.text_field('email').enter_text('a7a80644@d9c4d54f.5a0')
  v.text_field('password').enter_text('57bc8f19c898')
  v.action('submit').activate
  v.is_not_visible!
end

view('dashboard').is_visible!
```

*For further discussion of this code, please see the example section below.*

Element selection is based on using a series of conventions for HTML attribute name/value pairs. The attribute name is used to identify the type of element being interacted with (view, form field, etc). The attribute value is used to identify the specific element.

For example, views which contain other elements are identified by the `HTML` attribute `data-view`. The associated attribute value is the name of the view. In `<div data-view='dashboard'></div>`, the div is identified as a view with the name *dashboard*.

The attribute-based approach used to select, interact with and test visibility of elements is resistant to `HTML` structure and style changes.

### Example: Sign In Form

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
  <input type="submit" data-action="submit">Sign In</input>
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

Functional tests which use CSS class names or element types to select elements can break when styles or elements are changed.

The beauty of this approach is that style changes to the sign in form will **not** cause test failures. As previously mentioned, this is because the attribute-based approach used to select, interact with and test visibility of elements is resistant to style changes.

For example, the same test would pass for this sign in form with (1) more elements, (2) different styles (`bootstrap` in this case) and (3) a different type of element used for the submit button:

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
      <button data-action="sign-up" class="btn btn-default" style="width: 100%;">Sign Up</button>
    </form>
  </div>
</div>
```

#### minitest

The example above uses `minitest`. However, `minitest` is not required. You can use any test framework you want, or no test framework at all. However, there is a special level of support provided by the gem for `minitest`. The test base class defines a root view (an unnamed view). Inside the test, references to interactors are forwarded to the root view (`view`, `action`, `element`, `list`, `text_field`, `dropdown_field`, `checkbox_field`). As such, we can use code like this directly in the test `view('dashboard').is_not_visible!`. `view` is being forwarded to the root view, which is acting as a default scope.

## Interactor Reference

### `ViewInteractor`

The `ViewInteractor` is used primarily to work with elements that have children (a container element).

A `ViewInteractor` allows you to perform three operations: (1) ensure the `view` is *visible*, (2) ensure the view is *invisible* and (3) *select* child elements.

*Methods*

Two core methods are provided to check element visibility.

`#is_visible!` - ensure the view is visible.

`#is_not_visible!` - ensure the view is not visible.

The remaining methods are used to select child elements via interactors scoped to the current `view`.

`#view(name)` - returns a `ViewInteractor` representing a child element with the `data-view` attribute value corresponding to `name` (`<element data-view='name' />`).

`#action(name)` - returns an `ActionInteractor` representing a child element with the `data-action` attribute value corresponding to `name` (`<element data-action='name' />`).

`#element(name)` - returns an `ElementInteractor` representing a child element with the `data-element` attribute value corresponding to `name` (`<element data-element='name' />`).

`#list(name)` - returns a `ListInteractor` representing a child element with the `data-view` attribute value corresponding to `name` (`<element data-view='name' />`).

`#text_field(name)` - returns a `TextFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).

`#dropdown_field(name)` - returns a `DropdownFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).

`#checkbox_field(name)` - returns a `CheckboxFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).

### `ElementInteractor`

### `ActionInteractor`

### `interactor `

### `TextFieldInteractor`

### `DropdownFieldInteractor`

### `CheckboxFieldInteractor`

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