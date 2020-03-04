# frozen_string_literal: true

require 'test_helper'

module Symbo
  class IGateTest < ActiveSupport::TestCase
    test 'I|0> = |0>' do
      assert_equal Qubit['0'], IGate.new.apply(Qubit['0'], 0)
    end

    test 'I|1> = |1>' do
      assert_equal Qubit['1'], IGate.new.apply(Qubit['1'], 0)
    end
  end
end
