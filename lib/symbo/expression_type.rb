# frozen_string_literal: true

module Symbo
  module ExpressionType
    # :section: Expression Type Methods

    def undefined?
      self == UNDEFINED
    end

    def integer?
      is_a?(Integer)
    end

    def complex?
      is_a?(Complex)
    end

    def fraction?
      is_a?(Fraction)
    end

    def constant?
      is_a?(Constant)
    end

    def sum?
      is_a?(Sum)
    end

    def product?
      is_a?(Product)
    end

    def power?
      is_a?(Power)
    end

    def symbol?
      is_a?(Symbol)
    end
  end
end
