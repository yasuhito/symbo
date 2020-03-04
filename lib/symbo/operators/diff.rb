# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  class Diff < Expression
    using Symbo

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/AbcSize
    def evaluate
      v = operand(0).simplify

      if length == 1
        if v == UNDEFINED
          UNDEFINED
        else
          Product[-1, v].evaluate
        end
      elsif length == 2
        w = operand(1).simplify

        if v == UNDEFINED || w == UNDEFINED
          UNDEFINED
        else
          Sum[v, -w].evaluate
        end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/AbcSize
  end
end
