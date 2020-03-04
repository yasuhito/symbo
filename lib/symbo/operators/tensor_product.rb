# frozen_string_literal: true

module Symbo
  class TensorProduct
    # Returns the tensor product of two matrices.
    #
    #   TensorProduct[Qubit['0'], Qubit['0']] # => Matrix[[1], [0], [0], [0]] (|00>)
    #   TensorProduct[Matrix[[1, 2], [3, 4]], Matrix[[5, 6], [7, 8]]]
    #     # => Matrix[[5, 6, 10, 12],
    #                 [7, 8, 14, 16],
    #                 [15, 18, 20, 24],
    #                 [21, 24, 28, 32]]
    def self.[](matrix1, matrix2)
      Matrix.hstack(*(0...matrix1.column_size).map do |col|
                      Matrix.vstack(*(0...matrix1.row_size).map do |row|
                                      matrix1[row, col] * matrix2
                                    end)
                    end)
    end
  end
end
