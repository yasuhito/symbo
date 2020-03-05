# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class YGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Y|0> = i|1>' do
      assert_equal 1i * Qubit['1'], Y * Qubit['0']
    end

    test 'Y|1> = -i|0>' do
      assert_equal(-1i * Qubit['0'], Y * Qubit['1'])
    end

    test 'Y|+> = -i|->' do
      assert_equal(-1i * Qubit['-'], Y * Qubit['+'])
    end

    test 'Y|-> = i|+>' do
      assert_equal 1i * Qubit['+'], Y * Qubit['-']
    end

    test 'Y|i> = |i>' do
      assert_equal Qubit['i'], Y * Qubit['i']
    end

    test 'Y|-i> = -|-i>' do
      assert_equal(-Qubit['-i'], Y * Qubit['-i'])
    end

    test 'Y(1)|00> = i|01>' do
      assert_equal 1i * Qubit['01'], TensorProduct[I, Y] * Qubit['00']
    end
  end
end
