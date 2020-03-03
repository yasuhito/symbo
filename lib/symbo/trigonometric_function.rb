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
  end
end
