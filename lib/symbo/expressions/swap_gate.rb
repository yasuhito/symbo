# frozen_string_literal: true

module Symbo
  class SwapGate
    using Symbo

    def apply(state, qubit1, qubit2)
      state_length = Math.log2(state.row_size).to_i
      Qubit.rows((matrix(qubit1, qubit2, state_length) * state).to_a)
    end

    def matrix(qubit1, qubit2, state_length)
      (0...(2.pow(state_length))).map do |each|
        qstr = format('%0*b', state_length, each) # rubocop:disable Style/FormatStringToken
        t = qstr[qubit1]
        qstr_swap = qstr.dup
        qstr_swap[qubit1] = qstr_swap[qubit2]
        qstr_swap[qubit2] = t
        Qubit[qstr] * Qubit[qstr_swap].bra
      end.inject(:+)
    end
  end

  def Swap(qubit1, qubit2, length:) # rubocop:disable Naming/MethodName
    SwapGate.new.matrix(qubit1, qubit2, length)
  end
end
