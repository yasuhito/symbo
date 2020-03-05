# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class RzGateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'Rz(θ)|0> = e^{-iθ/2}|0>' do
      assert_equal (E**(-1i * :θ/2)) * Qubit['0'], Rz(:θ) * Qubit['0']
    end

    test 'Rz(θ)|1> = e^{iθ/2}|1>' do
      assert_equal (E**(1i * :θ/2)) * Qubit['1'], Rz(:θ) * Qubit['1']
    end

    test 'Rz(2π)|0> = e^{-iπ}|0> = -|0>' do
      assert_equal(-Qubit['0'], Rz(2 * :π) * Qubit['0'])
    end

    test 'Rz(2π)|1> = e^{iπ}|1> = -|1>' do
      assert_equal(-Qubit['1'], Rz(2 * :π) * Qubit['1'])
    end

    test 'Rz(θ)1|00> = e^{-iθ/2}|00>' do
      assert_equal (E**(-1i * :θ/2)) * Qubit['00'], TensorProduct[I, Rz(:θ)] * Qubit['00']
    end
  end
end
