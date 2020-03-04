# frozen_string_literal: true

require 'test_helper'

module Symbo
  class RzGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Rz(θ)|0> = e^{-iθ/2}|0>' do
      assert_equal (E**(-1i * :θ/2)) * Qubit['0'], RzGate.new(:θ).apply(Qubit['0'], 0)
    end

    test 'Rz(θ)|1> = e^{iθ/2}|1>' do
      assert_equal (E**(1i * :θ/2)) * Qubit['1'], RzGate.new(:θ).apply(Qubit['1'], 0)
    end

    test 'Rz(2π)|0> = e^{-iπ}|0> = -|0>' do
      assert_equal(-Qubit['0'], RzGate.new(2 * :π).apply(Qubit['0'], 0))
    end

    test 'Rz(2π)|1> = e^{iπ}|1> = -|1>' do
      assert_equal(-Qubit['1'], RzGate.new(2 * :π).apply(Qubit['1'], 0))
    end
  end
end
