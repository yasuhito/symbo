# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class TGate < Gate
    using Symbo

    def matrix
      Matrix[[1, 0], [0, E**(1i * PI/4)]]
    end
  end

  T = TGate.new.matrix
end
