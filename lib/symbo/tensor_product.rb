# frozen_string_literal: true

module Symbo
  class TensorProduct
    def self.[](matrix0, matrix1)
      col_ms = (0...matrix0.column_size).map do |col|
        ms = (0...matrix0.row_size).map do |row|
          matrix0[row, col] * matrix1
        end
        Matrix.vstack(*ms)
      end
      Matrix.hstack(*col_ms)
    end
  end
end
