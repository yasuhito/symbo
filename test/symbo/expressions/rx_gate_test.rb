# frozen_string_literal: true

require 'test_helper'

module Symbo
  class RxGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Rx(θ)|0> = cos(θ/2)|0> - isin(θ/2)|1>' do
      assert_equal Cos[:θ/2] * Qubit['0'] - (1i * Sin[:θ/2]) * Qubit['1'], RxGate.new(:θ).apply(Qubit['0'], 0)
    end

    test 'Rx(θ)|1> = cos(θ/2)|1> - isin(θ/2)|0>' do
      assert_equal Cos[:θ/2] * Qubit['1'] - (1i * Sin[:θ/2]) * Qubit['0'], RxGate.new(:θ).apply(Qubit['1'], 0)
    end

    test 'Rx(2π)|0> = cos(π)|0> - isin(π)|1> = -|0>' do
      assert_equal(-Qubit['0'], RxGate.new(2 * :π).apply(Qubit['0'], 0))
    end

    test 'Rx(2π)|1> = cos(π)|1> - isin(π)|0> = -|1>' do
      assert_equal(-Qubit['1'], RxGate.new(2 * :π).apply(Qubit['1'], 0))
    end
  end
end
