# frozen_string_literal: true

require 'symbo/expressions/concerns/expression_type'

class Symbol
  include Symbo::ExpressionType

  def +(other)
    Symbo::Sum[self, other]
  end
end
