# frozen_string_literal: true

module Symbo
  module RelationalOperators
    # :section: Relational Operator Methods

    def ==(other)
      other.is_a?(self.class) && @operands == other.operands
    end

    def zero?
      false
    end
  end
end
