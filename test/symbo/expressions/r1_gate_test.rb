# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class R1GateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'R1(θ)|0> = |0>' do
      assert_equal Qubit['0'], R1(:θ) * Qubit['0']
    end

    test 'R1(θ)|1> = e^{iθ}|1>' do
      assert_equal E**(1i * :θ) * Qubit['1'], R1(:θ) * Qubit['1']
    end

    test 'R1(π)|0> = |0>' do
      assert_equal Qubit['0'], R1(:π) * Qubit['0']
    end

    test 'R1(π)|1> = e^{iπ}|1> = -|1>' do
      assert_equal(-Qubit['1'], R1(:π) * Qubit['1'])
    end

    test 'R1(θ)1|01> = e^{iθ}|01>' do
      assert_equal E**(1i * :θ) * Qubit['01'], TensorProduct[I, R1(:θ)] * Qubit['01']
    end
  end
end
