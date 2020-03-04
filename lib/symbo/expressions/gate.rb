# frozen_string_literal: true

module Symbo
  class Gate
    include Symbo

    using Symbo

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def apply(state, target)
      m = nil

      state_length = Math.log2(state.row_size).to_i
      (0...state_length).each do |each|
        if m && each == target
          m = TensorProduct[m, matrix]
        elsif m && each != target
          m = TensorProduct[m, Matrix.I(2)]
        elsif !m && each == target
          m = matrix
        elsif !m && each != target
          m = Matrix.I(2)
        end
      end

      Qubit.rows((m * state).to_a)
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
