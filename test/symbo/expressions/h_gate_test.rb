# frozen_string_literal: true

require 'test_helper'

module Symbo
  class HGateTest < ActiveSupport::TestCase
    using Symbo

    test 'H|0> = |+>' do
      assert_equal Qubit['+'], HGate.new.apply(Qubit['0'], 0)
    end

    test 'H|1> = |->' do
      assert_equal Qubit['-'], HGate.new.apply(Qubit['1'], 0)
    end

    test 'H|+> = |0>' do
      assert_equal Qubit['0'], HGate.new.apply(Qubit['+'], 0)
    end

    test 'H|-> = |1>' do
      assert_equal Qubit['1'], HGate.new.apply(Qubit['-'], 0)
    end

    test 'H|i> = e^{iπ/4}|-i>' do
      assert_equal (E**(1i * PI/4) * Qubit['-i']).state, HGate.new.apply(Qubit['i'], 0)
    end

    test 'H|-i> = e^{-iπ/4}|i>' do
      assert_equal (E**(-1i * PI/4) * Qubit['i']).state, HGate.new.apply(Qubit['-i'], 0)
    end
  end
end
