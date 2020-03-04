# frozen_string_literal: true

require 'symbo/expressions/concerns/constant'
require 'symbo/expressions/concerns/expression_type'

class Integer
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
