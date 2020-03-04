# frozen_string_literal: true

module Symbo
  class SwapGate
    using Symbo

    def apply(state, qubit1, qubit2)
      Qubit.rows((matrix(state, qubit1, qubit2) * state).to_a)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def matrix(state, qubit1, qubit2)
      state_length = Math.log2(state.row_size).to_i

      (0...state.row_size).map do |each|
        qstr = format('%0*b', state_length, each) # rubocop:disable Style/FormatStringToken
        t = qstr[qubit1]
        qstr_swap = qstr.dup
        qstr_swap[qubit1] = qstr_swap[qubit2]
        qstr_swap[qubit2] = t
        Qubit[qstr] * Qubit[qstr_swap].bra
      end.inject(:+)
    end
    # rubocop:enable Metrics/AbcSize
  end
end
