# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class DiffTest < ActiveSupport::TestCase
    using Symbo

    test 'Diff[1/0].evaluate → UNDEFINED' do
      assert_equal UNDEFINED, Diff[1/0].evaluate
    end

    test 'Diff[:x].evaluate → -:x' do
      assert_equal(-:x, Diff[:x].evaluate)
    end

    test 'Diff[1/0, :x].evaluate → UNDEFINED' do
      assert_equal UNDEFINED, Diff[1/0, :x].evaluate
    end

    test 'Diff[:x, 1/0].evaluate → UNDEFINED' do
      assert_equal UNDEFINED, Diff[:x, 1/0].evaluate
    end

    test 'Diff[2, 1].evaluate → 1' do
      assert_equal 1, Diff[2, 1].evaluate
    end
  end
end
