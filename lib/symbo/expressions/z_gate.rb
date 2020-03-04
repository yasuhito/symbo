# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class ZGate < Gate
    def matrix
      Matrix[[1, 0], [0, -1]]
    end
  end
end
