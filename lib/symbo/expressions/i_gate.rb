# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class IGate < Gate
    def matrix
      Matrix.I(2)
    end
  end

  I = IGate.new.matrix
end
