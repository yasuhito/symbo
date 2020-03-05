# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class RxGateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'Rx(θ)|0> = cos(θ/2)|0> - isin(θ/2)|1>' do
      assert_equal Cos[:θ/2] * Qubit['0'] - (1i * Sin[:θ/2]) * Qubit['1'], Rx(:θ) * Qubit['0']
    end

    test 'Rx(θ)|1> = cos(θ/2)|1> - isin(θ/2)|0>' do
      assert_equal Cos[:θ/2] * Qubit['1'] - (1i * Sin[:θ/2]) * Qubit['0'], Rx(:θ) * Qubit['1']
    end

    test 'Rx(2π)|0> = cos(π)|0> - isin(π)|1> = -|0>' do
      assert_equal(-Qubit['0'], Rx(2 * :π) * Qubit['0'])
    end

    test 'Rx(2π)|1> = cos(π)|1> - isin(π)|0> = -|1>' do
      assert_equal(-Qubit['1'], Rx(2 * :π) * Qubit['1'])
    end

    test 'Rx(2π)1|00> = -|00>' do
      assert_equal(-Qubit['00'], TensorProduct[I, Rx(2 * PI)] * Qubit['00'])
    end
  end
end
