# frozen_string_literal: true

class Complex
  alias plus +
  alias mult *

  include Symbo::Constant
  include Symbo::ExpressionType

  def +(other)
    plus other
  rescue TypeError
    Symbo::Sum[self, other]
  end

  def *(other)
    mult other
  rescue TypeError
    Symbo::Product[self, other]
  end
end
