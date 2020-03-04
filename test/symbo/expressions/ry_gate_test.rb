# frozen_string_literal: true

require 'test_helper'

module Symbo
  class RyGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Ry(θ)|0> = cos(θ/2)|0> + sin(θ/2)|1>' do
      assert_equal Cos[:θ/2] * Qubit['0'] + Sin[:θ/2] * Qubit['1'], RyGate.new(:θ).apply(Qubit['0'], 0)
    end

    test 'Ry(θ)|1> = cos(θ/2)|1> - sin(θ/2)|0>' do
      assert_equal Cos[:θ/2] * Qubit['1'] - Sin[:θ/2] * Qubit['0'], RyGate.new(:θ).apply(Qubit['1'], 0)
    end

    test 'Ry(2π)|0> = cos(π)|0> + sin(π)|1> = -|0>' do
      assert_equal(-Qubit['0'], RyGate.new(2 * :π).apply(Qubit['0'], 0))
    end

    test 'Ry(2π)|1> = cos(π)|1> - sin(π)|0> = -|1>' do
      assert_equal(-Qubit['1'], RyGate.new(2 * :π).apply(Qubit['1'], 0))
    end
  end
end
