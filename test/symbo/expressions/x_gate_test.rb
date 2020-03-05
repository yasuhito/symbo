# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class XGateTest
    class BasicQubitTransitionTest < ActiveSupport::TestCase
      using Symbo
      include Symbo

      test 'X|0> = |1>' do
        assert_equal Qubit['1'], X * Qubit['0']
      end

      test 'X|1> = |0>' do
        assert_equal Qubit['0'], X * Qubit['1']
      end

      test 'X|+> = |+>' do
        assert_equal Qubit['+'], X * Qubit['+']
      end

      test 'X|-> = -|->' do
        assert_equal(-Qubit['-'], X * Qubit['-'])
      end

      test 'X|i> = i|-i>' do
        assert_equal 1i * Qubit['-i'], X * Qubit['i']
      end

      test 'X|-i> = -i|i>' do
        assert_equal(-1i * Qubit['i'], X * Qubit['-i'])
      end

      test 'X(1)|00> = |01>' do
        assert_equal Qubit['01'], TensorProduct[I, X] * Qubit['00']
      end
    end
  end
end
