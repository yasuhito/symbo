# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class RyGateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'Ry(θ)|0> = cos(θ/2)|0> + sin(θ/2)|1>' do
      assert_equal Cos[:θ/2] * Qubit['0'] + Sin[:θ/2] * Qubit['1'], Ry(:θ) * Qubit['0']
    end

    test 'Ry(θ)|1> = cos(θ/2)|1> - sin(θ/2)|0>' do
      assert_equal Cos[:θ/2] * Qubit['1'] - Sin[:θ/2] * Qubit['0'], Ry(:θ) * Qubit['1']
    end

    test 'Ry(2π)|0> = cos(π)|0> + sin(π)|1> = -|0>' do
      assert_equal(-Qubit['0'], Ry(2 * :π) * Qubit['0'])
    end

    test 'Ry(2π)|1> = cos(π)|1> - sin(π)|0> = -|1>' do
      assert_equal(-Qubit['1'], Ry(2 * :π) * Qubit['1'])
    end

    test 'Ry(2π)1|00> = -|00>' do
      assert_equal(-Qubit['00'], TensorProduct[I, Ry(2 * :π)] * Qubit['00'])
    end
  end
end
