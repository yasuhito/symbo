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

    test 'TensorProduct[Matrix[[1, 2], [3, 4]], Matrix[[5, 6], [7, 8]]]' do
      assert_equal Matrix[[5, 6, 10, 12],
                          [7, 8, 14, 16],
                          [15, 18, 20, 24],
                          [21, 24, 28, 32]],
                   TensorProduct[Matrix[[1, 2], [3, 4]], Matrix[[5, 6], [7, 8]]]
    end
  end
end
