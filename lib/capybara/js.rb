require "capybara/js/version"

module Capybara
  module DSL
    def js_wait_for_variable name
      # for name = foo.bar.baz wait on foo, then foo.bar, then foo.bar.baz
      elts = name.split '.'
      initial_segments = (1..elts.length).map { |i| elts.take(i).join '.' }

      initial_segments.each do |segment|
        begin
          Timeout::timeout Capybara.default_wait_time do
            while page.evaluate_script("typeof #{segment} === 'undefined'")
              sleep Capybara.default_wait_time / 4
            end
          end
        rescue Timeout::Error
          # provide more information
          raise Timeout::Error.new "Timed out waiting for js var #{segment} in expression #{name}"
        end
      end
    end

    def js_initialize_helper_vars
      page.evaluate_script "window.capybara_js_originals = window.capybara_js_originals || {};"
      page.evaluate_script "window.capybara_js_spy_calls = window.capybara_js_spy_calls || [];"
    end

    def js_spy_on_method method
      js_initialize_helper_vars

      page.js_wait_for_variable method
      # back up original function
      page.evaluate_script "window.capybara_js_originals['#{method}'] = #{method};";
      # replace with a spy that records calls and passes through
      page.evaluate_script <<js
        #{method} = function () {
          window.capybara_js_spy_calls['#{method}'].push(arguments);
          return window.capybara_js_originals['#{method}'].call(this, arguments);
        };
js
    end

    def js_method_invoked? method
      js_initialize_helper_vars
      page.evaluate_script "window.capybara_js_spy_calls['#{method}'] && window.capybara_js_spy_calls['#{method}'].length > 0"
    end

    def js_stub_method method, new_definition

    end

    def js_restore_original_variable name
    end

  end
end
