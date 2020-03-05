# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class XGate < Gate
    def matrix
      Matrix[[0, 1], [1, 0]]
    end
  end

  X = XGate.new.matrix
end
