# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class TensorProductTest < ActiveSupport::TestCase
    test "TensorProduct[Qubit['0'], Qubit['0']] → |00>" do
      assert_equal Matrix[[1], [0], [0], [0]], TensorProduct[Qubit['0'], Qubit['0']]
    end

    test "TensorProduct[Qubit['0'], Qubit['1']] → |01>" do
      assert_equal Matrix[[0], [1], [0], [0]], TensorProduct[Qubit['0'], Qubit['1']]
    end

    test "TensorProduct[Qubit['1'], Qubit['0']] → |10>" do
      assert_equal Matrix[[0], [0], [1], [0]], TensorProduct[Qubit['1'], Qubit['0']]
    end

    test "TensorProduct[Qubit['1'], Qubit['1']] → |11>" do
      assert_equal Matrix[[0], [0], [0], [1]], TensorProduct[Qubit['1'], Qubit['1']]
    end

    test 'TensorProduct[X, I]' do
      assert_equal Matrix[[0, 0, 1, 0], [0, 0, 0, 1], [1, 0, 0, 0], [0, 1, 0, 0]],
                   TensorProduct[Matrix[[0, 1], [1, 0]], Matrix.I(2)]
    end
  end
end
