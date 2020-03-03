# frozen_string_literal: true

require 'symbo/function'

module Symbo
  class TrigonometricFunction < Function
    using Symbo

    def x
      @operands[1]
    end

    def simplify
      self.class.new(x.simplify)._simplify
    end

    private

    # rubocop:disable Metrics/AbcSize
    def kn_pi?
      x.product? && x.length == 2 && x.operand(0).constant? && x.operand(1) == PI &&
        [1, 2, 3, 4, 6].include?(x.operand(0).denominator) && x.operand(0).numerator.integer?
    end
    # rubocop:enable Metrics/AbcSize
  end
end
