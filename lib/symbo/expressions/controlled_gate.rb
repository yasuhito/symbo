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
            one_matrix = TensorProduct[one_matrix, @gate]
          else
            zero_matrix = IGate.new.matrix
            one_matrix = @gate
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

  def Controlled(gate, length, control_target) # rubocop:disable Naming/MethodName
    control = control_target.keys.first
    target = control_target.values.first
    ControlledGate.new(gate).matrix(length, target, control)
  end
end
