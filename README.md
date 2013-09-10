## JavaScript helpers for Capybara

Fix mysterious timing issues in your tests by waiting for JS variables
to be initialized. Spy on JS methods, or stub methods to prevent default
actions and isolate your tests.

### Usage

```sh
gem install capybara-js
```

Or add it to your Gemfile. Then in your rspec,

```ruby
# wait for something to become defined, in this case jQuery
page.js_wait_for_variable '$'
```
