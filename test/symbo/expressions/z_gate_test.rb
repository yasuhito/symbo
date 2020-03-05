# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class ZGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Z|0> = |0>' do
      assert_equal Qubit['0'], Z * Qubit['0']
    end

    test 'Z|1> = -|1>' do
      assert_equal(-Qubit['1'], Z * Qubit['1'])
    end

    test 'Z|+> = |->' do
      assert_equal Qubit['-'], Z * Qubit['+']
    end

    test 'Z|-> = |+>' do
      assert_equal Qubit['+'], Z * Qubit['-']
    end

    test 'Z|i> = |-i>' do
      assert_equal Qubit['-i'], Z * Qubit['i']
    end

    test 'Z|-i> = |i>' do
      assert_equal Qubit['i'], Z * Qubit['-i']
    end

    test 'Z(1)|01> = -|01>' do
      assert_equal(-Qubit['01'], TensorProduct[I, Z] * Qubit['01'])
    end
  end
end
