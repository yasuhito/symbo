# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class TGateTest < ActiveSupport::TestCase
    using Symbo

    test 'T|0> = |0>' do
      assert_equal Qubit['0'], T * Qubit['0']
    end

    test 'T|1> = e^{iπ/4}|1>' do
      assert_equal E**(1i * PI/4) * Qubit['1'], T * Qubit['1']
    end

    test 'T1|01> = e^{iπ/4}|01>' do
      assert_equal E**(1i * PI/4) * Qubit['01'], TensorProduct[I, T] * Qubit['01']
    end
  end
end
