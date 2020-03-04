# frozen_string_literal: true

class Symbol
  include Symbo::ExpressionType

  def +(other)
    Symbo::Sum[self, other]
  end
end
