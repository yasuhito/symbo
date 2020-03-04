# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class ControlledGate < Gate
    using Symbo

    def initialize(gate)
      @gate = gate
    end

    # http://www.sakkaris.com/tutorials/quantum_control_gates.html
    def apply(state, target, control)
      Qubit.rows((matrix(Math.log2(state.row_size).to_i, target, control) * state).to_a)
    end

    private

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/PerceivedComplexity
    def matrix(state_length, target, control)
      zero_matrix = nil
      one_matrix = nil

      (0...state_length).each do |each|
        if each == control
          if zero_matrix
            zero_matrix = TensorProduct[zero_matrix, Qubit['0'] * Qubit['0'].bra]
            one_matrix = TensorProduct[one_matrix, Qubit['1'] * Qubit['1'].bra]
          else
            zero_matrix = Qubit['0'] * Qubit['0'].bra
            one_matrix = Qubit['1'] * Qubit['1'].bra
          end
        elsif each == target
          if zero_matrix
            zero_matrix = TensorProduct[zero_matrix, IGate.new.matrix]
            one_matrix = TensorProduct[one_matrix, @gate.matrix]
          else
            zero_matrix = IGate.new.matrix
            one_matrix = @gate.matrix
          end
        elsif zero_matrix
          zero_matrix = TensorProduct[zero_matrix, IGate.new.matrix]
          one_matrix = TensorProduct[one_matrix, IGate.new.matrix]
        else
          zero_matrix = IGate.new.matrix
          one_matrix = IGate.new.matrix
        end
      end

      zero_matrix + one_matrix
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
