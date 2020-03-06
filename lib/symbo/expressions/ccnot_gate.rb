# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class CcnotGate < Gate
    using Symbo

    # rubocop:disable Metrics/AbcSize
    def matrix(length, control_target)
      control = control_target.keys.first
      target = control_target[control]

      (0...(2.pow(length))).map do |each|
        input = format('%0*b', length, each) # rubocop:disable Style/FormatStringToken
        if control.all? { |cbit| input[cbit] == '1' }
          output = input.dup
          output[target] = output[target] == '0' ? '1' : '0'
          Qubit[input] * Qubit[output].bra
        else
          Qubit[input] * Qubit[input].bra
        end
      end.inject(:+)
    end
    # rubocop:enable Metrics/AbcSize
  end

  def Ccnot(length, control_target) # rubocop:disable Naming/MethodName
    CcnotGate.new.matrix(length, control_target)
  end
end
