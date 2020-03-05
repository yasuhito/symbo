# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class SGateTest < ActiveSupport::TestCase
    using Symbo

    test 'S|0> = |0>' do
      assert_equal Qubit['0'], S * Qubit['0']
    end

    test 'S|1> = i|1>' do
      assert_equal 1i * Qubit['1'], S * Qubit['1']
    end

    test 'S|+> = |i>' do
      assert_equal Qubit['i'], S * Qubit['+']
    end

    test 'S|-> = |-i>' do
      assert_equal Qubit['-i'], S * Qubit['-']
    end

    test 'S|i> = |->' do
      assert_equal Qubit['-'], S * Qubit['i']
    end

    test 'S|-i> = |+>' do
      assert_equal Qubit['+'], S * Qubit['-i']
    end

    test 'S1|01> = i|1>' do
      assert_equal 1i * Qubit['01'], TensorProduct[I, S] * Qubit['01']
    end
  end
end
