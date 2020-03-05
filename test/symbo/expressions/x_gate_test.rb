# frozen_string_literal: true

require 'test_helper'

module Symbo
  class XGateTest
    class BasicQubitTransitionTest < ActiveSupport::TestCase
      using Symbo

      test 'X|0> = |1>' do
        assert_equal Qubit['1'], XGate.new.apply(Qubit['0'], 0)
      end

      test 'X|1> = |0>' do
        assert_equal Qubit['0'], XGate.new.apply(Qubit['1'], 0)
      end

      test 'X|+> = |+>' do
        assert_equal Qubit['+'], XGate.new.apply(Qubit['+'], 0)
      end

      test 'X|-> = -|->' do
        assert_equal(-Qubit['-'], XGate.new.apply(Qubit['-'], 0))
      end

      test 'X|i> = i|-i>' do
        assert_equal 1i * Qubit['-i'], XGate.new.apply(Qubit['i'], 0)
      end

      test 'X|-i> = -i|i>' do
        assert_equal(-1i * Qubit['i'], XGate.new.apply(Qubit['-i'], 0))
      end

      test 'X(1)|00> = |01>' do
        assert_equal Qubit['01'], TensorProduct[I, X] * Qubit['00']
      end
    end
  end
end
