# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter %r{^/test/}
end

require 'active_support'
require 'active_support/test_case'
require 'minitest/autorun'
