# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class QuotTest < ActiveSupport::TestCase
    using Symbo

    test 'Quot[1, 0].evaluate → Undefined' do
      assert_equal UNDEFINED, Quot[1, 0].evaluate
    end

    test 'Quot[1, 2].evaluate → 1/2' do
      assert_equal 1/2, Quot[1, 2].evaluate
    end

    test 'Quot[2/3, 4/5].evaluate → 10/12' do
      assert_equal 10/12, Quot[2/3, 4/5].evaluate
    end
  end
end
