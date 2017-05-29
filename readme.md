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

Use **interactors** to select, interact with and test the visibility of elements. The goal of the `ui_interactors` gem is to allow you to write simple `Ruby` code like this to automate functional tests for web applications - tests that are resilient to `HTML` layout changes and `CSS` style changes:

```ruby
require 'selenium-webdriver'
require 'ui_interactors'

options = {}
driver = Selenium::WebDriver.for(:chrome, options)
url = 'http://localhost:3000/'
driver.navigate.to(url)

page = UiInteractors::Interactors::ViewInteractor.new(driver)

page.view('dashboard').is_not_visible!

page.view('sign-in').tap do |v|
  v.is_visible!
  v.text_field('email').enter_text('a7a80644@d9c4d54f.5a0')
  v.text_field('password').enter_text('57bc8f19c898')
  v.action('submit').activate
  v.is_not_visible!
end

page.view('dashboard').is_visible!
```

*More example code is available in the example sections below.*

The `ui_interactors` gem generalizes `HTML` elements into these types:

* **View** - container for other elements (`<div>`, `<span>`, etc).
* **Element** - any element containing only text (`<div>`, `<span>`, etc).
* **Action** - an element which could be clicked or tapped (`<a>`, `<button>`, `<div>`, `<span>`, etc).
* **List** - container for rows (typically a `<div>`, but could also be a `<table>`, or any other element containing other elements).
* **Row** - child of a list and also a container for other elements (a special type of **view**).
* **Text Field** - text input field (`<input type='text'>`, `<input type='password'>`, `<textarea>`).
* **Dropdown** - dropdown list field with options (`<select>`).
* **Checkbox** - checkbox field (`<input type='checkbox'>`).

This gem requires that you follow conventions in `HTML` to identify elements. The type of element is identified using a special `HTML` attribute name. The attribute *value* is used to identify the specific element.

For example, views which contain other elements are identified by the `HTML` attribute `data-view`. The associated attribute value is the name of the view. In `<div data-view='dashboard'></div>`, the `div` is identified as a view with the name *dashboard*.

By not classifying an element based on it's tag name (`<a>`, `<button>`, etc) or based on a `CSS` class name, we prevent our test code from being tightly coupled to design-related code. This can prevent many test failures related to design & layout changes. These design & layout changes do not change the functionality we are testing, but they could cause failures by changing the `HTML` tags or `CSS` classes our test code is expecting.

Identifying elements in `HTML` is one side of the equation, interacting with those elements in our tests is the other side. In our Ruby code, we use what are called *interactors* to find, test the visibility of and otherwise interact with these elements identified using the required `HTML` attributes.

Views and rows can contain other nested elements. Either of the associated interactors (`ViewInteractor` and `RowInteractor`) can be used to limit our search for elements to just their children. Consider the example `page.view('sign-in').text_field('email').is_visible!`. This line tests the visibility of the `email` text field, but will only look for that field as a child of the `sign-in` view.

This fluent-style API makes it quick and easy to select and interact with exactly the elements you need to. At the same time, the attribute-based approach used to identify `HTML` elements is resistant to `HTML` structure and style changes. The end result of using this approach is a nice combination of easy to write functional tests which are resistant to layout and style changes.

#### Interactors

The term *interactor* is used to refer to a special selenium-based Ruby class provided by this gem for interacting with an `HTML` element. This gem provides several interactors - one for each of the related elements:

* **ViewInteractor**
* **ElementInteractor**
* **ActionInteractor**
* **ListInteractor**
* **RowInteractor**
* **TextFieldInteractor**
* **DropdownFieldInteractor**
* **CheckboxFieldInteractor**

**ViewInteractor** represents a container `HTML` for other elements. These elements are designated by the `HTML` attribute `data-view='name'` which makes them selectable as a `ViewInteractor`. A `ViewInteractor` represents a context within a page.

Other interactors can be selected as children of a `ViewInteractor`. Our example above uses the page view as context to select the `sign-in` view: `page.view('sign-in')`.

If we had a more complex page, with many nested views, these could be used to select other unique elements. For example: `page.view('dashboard').view('stats').view('users').element('user-count')`.

**ElementInteractor** represents an `HTML` element which contains only text. For example, the name of a person. These elements are designated by the `HTML` attribute `data-element='name'` which makes them selectable as an `ElementInteractor` using the `name`. For example: `<span data-element='name'>John Doe</span>`.

**ActionInteractor** represents an `HTML` element which can be clicked on (desktop) or tapped on (mobile). These elements are designated by the `HTML` attribute `data-action='name'` which makes them selectable as an `ActionInteractor` using the `name`. For example, `<a data-action='navigate-home'>Home</a>`. An action is not limited to `<a>` elements. It is any element with the `data-action` attribute.

**ListInteractor** represents an `HTML` element which contains "rows". These elements are designated by the `HTML` attribute `data-view='name'`, like a `ViewInteractor` is.

**RowInteractor** represents an `HTML` element that contains other elements, and as such, acts like a `ViewInteractor`. A `RowInteractor` is always a child of a `ListInteractor` and is selectable based on (1) having the attribute `data-view='row'` and having one or more `ElementInteractors` (`data-element` elements). Please refer to the section below, titled *Example #2: Working With Lists & Rows* for a concrete example.

**TextFieldInteractor** represents an `HTML` text field element. These elements are designated by the standard `HTML` attribute `name='name'` which makes them selectable as a `TextFieldInteractor` using the value for `name`. For example, `<input type='text' name='firstName' />`. Elements which can be used with this interactor are: `<input type='text'>`, `<input type='password'>` and `<textarea>`.

**DropdownFieldInteractor** represents an `HTML` `<select>` element with `<option>` child elements. A dropdown field element is designated by the standard `HTML` attribute `name='name'` which makes them selectable as a `DropdownFieldInteractor` using the value for `name`. For example, `<select name='userType'><option>Standard</option><option>Admin</option></select>`.

**CheckboxFieldInteractor** represents an `HTML` checkbox input field element. These elements are designated by the standard `HTML` attribute `name='name'` which makes them selectable as a `CheckboxFieldInteractor` using the value for `name`. For example, `<input type='checkbox' name='isAdmin' />`.

### Example #1: Sign In Form

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

And finally, this is the `Ruby` we expect to write to automate the sign in process (using the built-in `minitest` support):

```ruby
require 'selenium-webdriver'
require 'ui_interactors/minitest/interactor_test'

class TestSignInSuccess < UiInteractors::InteractorTest

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

  # This method is used to provide the driver to the base class in order for it to wire up ui_interactors support.
  # Note too that you can use this approach along with your own test base class to create a singleton instance of the
  # driver for reuse. Please see this gem's test suite for an example.
  def provide_driver
    # avoid the "save password?" Chrome dialog
    options = {
      'prefs': {
        'credentials_enable_service': false,
        'profile': {
          'password_manager_enabled': false
        }
      }
    }
    Selenium::WebDriver.for(:chrome, options)
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

The example above uses `minitest`. However, `minitest` is not required. You can use any test framework you want, or no test framework at all. However, there is a special level of support provided by the gem for `minitest`.

The test base class defines a root view (an unnamed view which represents the page itself). Inside the test, references to interactors are forwarded to the root view (`view`, `action`, `element`, `list`, `text_field`, `dropdown_field`, `checkbox_field`). As such, we can use code like this directly in the test `view('dashboard').is_not_visible!`. Here, `view` is being forwarded to the root view, which is acting as a default scope.

### Example #2: Working With Lists & Rows

Working with lists can be a key automation problem. Consider another example: clicking an action that is inside a row.

Given this `HTML`:

```html
<div data-view="people">
  <div data-view="row">
    <span data-element="firstName">John</span>
    <span data-element="lastName">Smith</span>
    <span data-view="friends"><span data-element="first">Gloria</span>, <span data-element="second">Richard</span></span>
    <a data-action="view-record" href="john-smith.html">view</a>
  </div>
  <div data-view="row">
    <span data-element="firstName">John</span>
    <span data-element="lastName">Miller</span>
    <span data-view="friends"><span data-element="first">James</span>, <span data-element="second">Amy</span></span>
    <a data-action="view-record" href="john-miller.html">view</a>
  </div>
</div>
```

How can we click on the `view-record` action for the person named John Miller? We need to first identify the row for John Miller, find the related action and then click on it.

This could be a challenging situation to automate. Depending on the circumstance of the test, we cannot assume that John Miller is the second row. Additionally, the first name and last name are broken up into two different `HTML` elements, which could make it harder for us to find the correct row.

This is what the `ui_interactors`-based code would look like to activate the `view-record` action for John Miller:

```ruby
# Setup our page/root view interactor
require 'selenium-webdriver'
require 'ui_interactors'

options = {}
driver = Selenium::WebDriver.for(:chrome, options)
url = 'http://localhost:3000/'
driver.navigate.to(url)

page = UiInteractors::Interactors::ViewInteractor.new(driver)

# Activate the action
page.list('people').row(elements: {firstName: 'John', lastName: 'Miller'}).action('view-record').activate
```

In one line, using a fluent API, we have (1) identified the action for the correct row and (2) activated that action.

Further, consider how this approach is resistant to `HTML` changes. The same line of Ruby would activate the correct action for this `HTML`, which is quite different from the previous `HTML`:

```html
<div data-view="people">
  <div data-view="row">
    <a data-action="view-record" href="john-smith.html">
      <span data-element="firstName">John</span>
      <span data-element="lastName">Smith</span>
    </a>
  </div>
  <div data-view="row">
    <a data-action="view-record" href="john-miller.html">
      <span data-element="firstName">John</span>
      <span data-element="lastName">Miller</span>
    </a>
  </div>
</div>
```

By following some basic guidelines, like keeping the same elements in the row (`data-element='firstName'`, `data-element='lastName'`, and `data-action='view-record'`), automated tests would continue to pass even after making drastic changes to the `HTML`. This is a great benefit of using `ui_interactors` for test automation.

## Interactor Reference

Following is a reference of all public methods available for each interactor.

### `ViewInteractor`

The `ViewInteractor` is used primarily to work with elements that have children (a container element).

A `ViewInteractor` allows you to perform three operations: (1) ensure the `view` is *visible*, (2) ensure the view is *invisible* and (3) *select* child elements.

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Select child elements via interactors scoped to the current `view`.

* `#view(name)` - returns a `ViewInteractor` representing a child element with the `data-view` attribute value corresponding to `name` (`<element data-view='name' />`).
* `#action(name)` - returns an `ActionInteractor` representing a child element with the `data-action` attribute value corresponding to `name` (`<element data-action='name' />`).
* `#element(name)` - returns an `ElementInteractor` representing a child element with the `data-element` attribute value corresponding to `name` (`<element data-element='name' />`).
* `#list(name)` - returns a `ListInteractor` representing a child element with the `data-view` attribute value corresponding to `name` (`<element data-view='name' />`).
* `#text_field(name)` - returns a `TextFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).
* `#dropdown_field(name)` - returns a `DropdownFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).
* `#checkbox_field(name)` - returns a `CheckboxFieldInteractor` representing a child element with the given `name` attribute (`<element name='name' />`).

### `ElementInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Check for the text contained in the `HTML` element.

* `has_text!(text)` - ensure the element has the given text.
* `does_not_have_text!(text)` - ensure the element does not have the given text.

### `ActionInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Interact with the action.

* `#activate` - invoke the action (click on the `HTML` element).

### `ListInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Select a row.

* `#row(selector_options)` - uses the given `selector_options` to select a row (return a `RowInteractor`). `selector_options` is a `Hash` which expects a single key/value pair with the key `:elements`. The value for `:elements` is a `Hash` that describes the element names and values which identify a row. Row `HTML` elements are children of the list `HTML` element. Row `HTML` elements follow the special attribute naming convention `data-view='row'`. These row `HTML` elements are then matched using the given `:elements` `Hash`. For example this `selector_options` value, `{elements: {firstName: 'John', lastName: 'Doe'}}`, would match a row with the two `data-element` elements described (`<div data-view='row'><span data-element='firstName'>John</span><span data-element='lastName'>Doe</span></div>`). Note that the row would then be treated as a `ViewInteractor` allowing you to find and interact with other views, elements, fields, actions, etc.

### `RowInteractor`

A `RowInteractor` is a special case of a `ViewInteractor`. Please refer to the reference for `ViewInteractor`. You build a `RowInteractor` using `ListInteractor#row`.

### `TextFieldInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Interact with the text field.

* `#has_text!(text)` - ensure the input has the given text.
* `#does_not_have_text!(text)` - ensure the input does not have the given text.
* `#is_blank!` - ensure the input is empty (that it does not have any text).
* `#enter_text(text)` - enter text in the input. Any existing value is cleared.
* `#clear_text` - uses `<ctrl>` + `a`, `<delete>` to clear text. This approach of clearing text triggers React's change event. 

### `DropdownFieldInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Interact with the select.

* `#option_is_selected!(option_name)` - ensure option with given text visible to the user (`option_name`) is selected.
* `#option_is_not_selected!(option_name)` - ensure option with given text visible to the user (`option_name`) is not selected.
* `#empty_option_is_selected!` - ensure option with no text is selected.
* `#select_option(option_name)` - select an option with the given text visible to the user (`option_name`).
* `#select_empty_option` - select an option which has no text.

### `CheckboxFieldInteractor`

*Methods*

Check `HTML` element visibility.

* `#is_visible!` - ensure the `HTML` element is visible.
* `#is_not_visible!` - ensure the `HTML` element is not visible.

Interact with checkbox field.

* `#is_checked!` - ensure checkbox is checked.
* `#is_not_checked!` - ensure checkbox is not checked.
* `#check` - check the checkbox. Leaves the checkbox in a checked state. If the checkbox is already checked, this method does nothing.
* `#uncheck` - uncheck the checkbox. Leaves the checkbox in an unchecked state. If the checkbox is already unchecked, this method does nothing.

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