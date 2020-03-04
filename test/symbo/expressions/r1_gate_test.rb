# frozen_string_literal: true

require 'test_helper'

module Symbo
  class R1GateTest < ActiveSupport::TestCase
    using Symbo

    test 'R1(θ)|0> = |0>' do
      assert_equal Qubit['0'], R1Gate.new(:θ).apply(Qubit['0'], 0)
    end

    test 'R1(θ)|1> = e^{iθ}|1>' do
      assert_equal E**(1i * :θ) * Qubit['1'], R1Gate.new(:θ).apply(Qubit['1'], 0)
    end

    test 'R1(π)|0> = |0>' do
      assert_equal Qubit['0'], R1Gate.new(:π).apply(Qubit['0'], 0)
    end

    test 'R1(π)|1> = e^{iπ}|1> = -|1>' do
      assert_equal(-Qubit['1'], R1Gate.new(:π).apply(Qubit['1'], 0))
    end
  end
end
