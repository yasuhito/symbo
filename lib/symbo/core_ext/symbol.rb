# frozen_string_literal: true

require 'symbo/concerns/expression_type'

class Symbol
  include Symbo::ExpressionType

  def +(other)
    Symbo::Sum[self, other]
  end
end
